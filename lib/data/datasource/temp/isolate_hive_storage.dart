

import 'package:hive/hive.dart';

import 'hive_temp_support.dart';

abstract class HiveStorageSupport<T> {
  String get dbLoggerName;

  String get boxNameForUser;

  bool _keepBoxActive = true;

  void enableLongTermActiveBox() {
    _keepBoxActive = true;
  }

  void disableLongActiveBox() {
    _keepBoxActive = false;
  }

  Future<Box<T>?> _getBox() async {
    try {
      if (Hive.isBoxOpen(boxNameForUser)) {
        return Hive.box<T>(boxNameForUser);
      }
      return await Hive.openBox<T>(boxNameForUser);
    } on Exception catch (e) {
      LoggingService()
          .severe('$dbLoggerName || box failed to open', 'failure', error: e);
      return null;
    } catch (e) {
      LoggingService().severe(
          '$dbLoggerName || box failed to open with unknown error', 'failure',
          error: e);
      return null;
    }
  }

  Future<void> closeBox() async {
    try {
      if (!_keepBoxActive && Hive.isBoxOpen(boxNameForUser)) {
        await Hive.box<T>(boxNameForUser).close();
      }
    } on Exception catch (e) {
      LoggingService()
          .severe('$dbLoggerName || box failed to close', 'failure', error: e);
    }
  }

  Future<ResponseWrapper<List<T>, AppDatabaseFailure>> getAllData() async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      var value = box.values.cast<T>();
      LoggingService().info('$dbLoggerName || GetAllData Local DB',
          'List Size:${value.toList().length}');
      await closeBox();
      return ResponseWrapper.success(value.toList(growable: true));
    } on Exception catch (e) {
      LoggingService()
          .severe('$dbLoggerName || GetAllData Local DB', 'failure', error: e);
      await _logFirebase('$dbLoggerName || GetAllData', e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.fetchError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<List<T>, AppDatabaseFailure>> getAllKeys() async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      var keys = box.keys.cast<T>();
      LoggingService().info('$dbLoggerName || GetAllData Local DB',
          'List Size:${keys.toList().length}');
      await closeBox();
      return ResponseWrapper.success(keys.toList(growable: true));
    } on Exception catch (e) {
      LoggingService()
          .severe('$dbLoggerName || GetAllData Local DB', 'failure', error: e);
      await _logFirebase('$dbLoggerName || GetAllData', e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.fetchError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<T, AppDatabaseFailure>> getData(String key) async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      var value = box.get(key);
      LoggingService().info('$dbLoggerName || GetData Local DB', 'Success');
      await closeBox();
      return ResponseWrapper.success(value);
    } on Exception catch (e) {
      LoggingService()
          .severe('$dbLoggerName || GetAllData Local DB', 'failure', error: e);
      await _logFirebase('$dbLoggerName || GetAllData', e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.fetchError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<bool, AppDatabaseFailure>> save(
      String key, T object) async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      await box.delete(key);
      await box.put(key, object);
      LoggingService().info('$dbLoggerName || Save Local DB', 'Success');
      await closeBox();
      return const ResponseWrapper.success(true);
    } on Exception catch (e) {
      await _logFirebase('$dbLoggerName || Save', e);
      LoggingService()
          .severe('$dbLoggerName || Save Local DB', 'Failure', error: e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.saveError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<bool, AppDatabaseFailure>> saveAll(
      Map<String, T> object,
      {bool clearDbFirst = false}) async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      if (clearDbFirst) {
        await box.clear();
      }
      await box.putAll(object);
      await closeBox();
      return const ResponseWrapper.success(true);
    } on Exception catch (e) {
      await _logFirebase('$dbLoggerName || update', e);
      LoggingService()
          .severe('$dbLoggerName || Update Local DB', 'Failure', error: e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.updateError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<bool, AppDatabaseFailure>> delete(String key) async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      box.delete(key);
      LoggingService().info('$dbLoggerName || Delete Local DB', 'Success');
      await closeBox();
      return const ResponseWrapper.success(true);
    } on Exception catch (e) {
      await _logFirebase('$dbLoggerName || delete', e);
      LoggingService()
          .severe('$dbLoggerName || Delete Local DB', 'Failure', error: e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.deleteError,
        exception: e,
      ));
    }
  }

  Future<ResponseWrapper<bool, AppDatabaseFailure>> deleteAll() async {
    try {
      var box = await _getBox();
      if (box == null) {
        return ResponseWrapper.failure(AppDatabaseFailure(
          errorType: AppDatabaseFailureType.boxOpenFailure,
        ));
      }
      await box.deleteAll(box.keys);
      LoggingService().info('$dbLoggerName || DeleteAll Local DB', 'Success');
      await closeBox();
      return const ResponseWrapper.success(true);
    } on Exception catch (e) {
      await _logFirebase('$dbLoggerName || deleteAll', e);
      LoggingService()
          .severe('$dbLoggerName || DeleteAll Local DB', 'Failure', error: e);
      return ResponseWrapper.failure(AppDatabaseFailure(
        errorType: AppDatabaseFailureType.deleteError,
        exception: e,
      ));
    }
  }

  Future<void> _logFirebase(String methodName, Exception exception) async {
    try {
      await LoggingService().recordError(
        exception,
        null,
        reason: 'Exception || HIVE || $methodName',
      );
    } on Exception catch (e) {
      LoggingService().info('Firebase', '_logFirebase', error: e);
    }
  }
}

import 'package:flutter/foundation.dart';

class ResponseWrapper<T, F> {
  final T? value;
  final F? failure;
  final bool isSuccess;

  const ResponseWrapper.success(this.value)
      : failure = null,
        isSuccess = true;

  const ResponseWrapper.failure(this.failure)
      : value = null,
        isSuccess = false;
}

enum AppDatabaseFailureType {
  boxOpenFailure,
  fetchError,
  saveError,
  updateError,
  deleteError,
}

class AppDatabaseFailure {
  final AppDatabaseFailureType errorType;
  final Object? exception;

  AppDatabaseFailure({
    required this.errorType,
    this.exception,
  });
}

class LoggingService {
  static final LoggingService _instance = LoggingService._();

  factory LoggingService() => _instance;

  LoggingService._();

  void severe(String message, String tag, {Object? error}) {
    if (kDebugMode) {
      debugPrint('[SEVERE] $tag: $message ${error ?? ''}');
    }
  }

  void info(String message, String tag, {Object? error}) {
    if (kDebugMode) {
      debugPrint('[INFO] $tag: $message ${error ?? ''}');
    }
  }

  Future<void> recordError(Object exception, Object? stackTrace,
      {required String reason}) async {
    if (kDebugMode) {
      debugPrint('[ERROR] $reason: $exception ${stackTrace ?? ''}');
    }
  }
}

import 'dart:developer';

import '../objectbox.g.dart';
import 'util/objectbox_debug_util.dart';

late final Store objectBoxStore;
Admin? objectBoxAdmin;

Future<void> initObjectBox() async {
  objectBoxStore = await openStore();

  final adminAvailable = Admin.isAvailable();
  print('ObjectBox Admin available: $adminAvailable');

  if (adminAvailable) {
    objectBoxAdmin = Admin(objectBoxStore, bindUri: '0.0.0.0:8090');
    print('ObjectBox Admin enabled at http://127.0.0.1:8090');
  }

  // Log store info
  ObjectBoxDebugUtil.logStoreStatistics(objectBoxStore);
}

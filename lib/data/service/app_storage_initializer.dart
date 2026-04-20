import 'dart:developer';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:product_benchmark_app/data/datasource/product_drift_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_hive_data_source.dart';
import 'package:product_benchmark_app/data/objectbox_store.dart';

class AppStorageInitializer {
  static Future<void> initialize() async {
    print('AppStorageInitializer: Starting initialization');
    
    print('AppStorageInitializer: Initializing Hive');
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(ProductHiveDataSource.boxName);
    await Hive.openBox<dynamic>(ProductHiveDataSource.metadataBoxName);
    print('AppStorageInitializer: Hive initialized');
    
    print('AppStorageInitializer: Initializing Drift');
    await ProductDriftDataSource().initialize();
    print('AppStorageInitializer: Drift initialized');
    
    print('AppStorageInitializer: Initializing ObjectBox');
    await initObjectBox();
    print('AppStorageInitializer: ObjectBox initialized');
    
    print('AppStorageInitializer: All storage systems initialized');
  }
}
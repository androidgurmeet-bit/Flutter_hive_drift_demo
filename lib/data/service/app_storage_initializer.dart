import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:product_benchmark_app/data/datasource/product_drift_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_hive_data_source.dart';

class AppStorageInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(ProductHiveDataSource.boxName);
    await Hive.openBox<dynamic>(ProductHiveDataSource.metadataBoxName);
    await ProductDriftDataSource().initialize();
  }
}
import 'dart:developer';

import 'package:hive_ce/hive.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';

class ProductHiveDataSource {
  static const String boxName = 'products';
  static const String metadataBoxName = 'app_metadata';

  Future<void> saveProducts(List<ProductModel> products) async {
    final box = Hive.box<dynamic>(boxName);
    await box.clear();
    await box.putAll({
      for (final product in products) product.id: product.toJson(),
    });
  }

  Future<List<ProductModel>> getProducts() async {
    final box = Hive.box<dynamic>(boxName);
    return box.values
        .map((value) => ProductModel.fromMap(value as Map<dynamic, dynamic>))
        .toList();
  }

  Future<ProductModel?> getProduct(int productId) async {
    final box = Hive.box<dynamic>(boxName);
    final value = box.get(productId);
    if (value == null) {
      return null;
    }

    return ProductModel.fromMap(value as Map<dynamic, dynamic>);
  }

  Future<void> clearProducts() async {
    final box = Hive.box<dynamic>(boxName);
    await box.clear();
  }

  Future<void> setLastSyncTime(DateTime time) async {
    final box = Hive.box<dynamic>(metadataBoxName);
    await box.put('last_product_sync', time.millisecondsSinceEpoch);
    log('Hive last sync updated', name: 'ProductHiveDataSource');
  }
}
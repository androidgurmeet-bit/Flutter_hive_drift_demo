import 'dart:developer';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';

class ProductHiveDataSource {
  static const String boxName = 'products';
  static const String metadataBoxName = 'app_metadata';

  // Isolate functions - process data without accessing Hive boxes
  static Future<List<String>> _serializeProductsIsolate(
    List<ProductModel> products,
  ) async {
    // Use jsonEncode for efficient string encoding
    return products.map((p) => jsonEncode(p.toJson())).toList();
  }

  static Future<List<ProductModel>> _deserializeProductsIsolate(
    List<dynamic> jsonStrings,
  ) async {
    return jsonStrings
        .cast<String>()
        .map((str) => ProductModel.fromMap(
              jsonDecode(str) as Map<dynamic, dynamic>,
            ))
        .toList();
  }

  // Original methods without isolate
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

  // New methods with isolate - offload heavy serialization/deserialization
  Future<void> saveProductsWithIsolate(List<ProductModel> products) async {
    // Serialize in isolate
    final serialized = await compute(_serializeProductsIsolate, products);
    
    // Write to Hive in main thread
    final box = Hive.box<dynamic>(boxName);
    await box.clear();
    await box.putAll({
      for (int i = 0; i < products.length; i++)
        products[i].id: serialized[i],
    });
  }

  Future<List<ProductModel>> getProductsWithIsolate() async {
    final box = Hive.box<dynamic>(boxName);
    final jsonStrings = box.values.toList();
    
    // Deserialize in isolate
    return await compute(_deserializeProductsIsolate, jsonStrings);
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
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';
import 'package:product_benchmark_app/data/model/product_objectbox_model.dart';
import 'package:product_benchmark_app/data/util/product_objectbox_util.dart';

class ProductObjectBoxDataSource {
  final Box<ProductObjectBox> _box;

  ProductObjectBoxDataSource(Store store)
      : _box = store.box<ProductObjectBox>();

  Future<void> saveProducts(List<ProductModel> products) async {
    _box.removeAll();
    _box.putMany(ProductObjectBoxUtil.toEntities(products));
  }

  Future<void> saveProductsWithIsolate(List<ProductModel> products) async {
    final jsonMaps = ProductObjectBoxUtil.toJsonMaps(products);
    final jsonStrings = await compute(encodeProductMaps, jsonMaps);

    final serializedProductMaps =
        jsonStrings.map((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>);
    final models = ProductObjectBoxUtil.fromJsonMaps(serializedProductMaps.toList());

    _box.removeAll();
    _box.putMany(ProductObjectBoxUtil.toEntities(models));
  }

  Future<List<ProductModel>> getProducts() async {
    final entities = _box.getAll();
    return ProductObjectBoxUtil.toModels(entities);
  }

  Future<List<ProductModel>> getProductsWithIsolate() async {
    final entities = _box.getAll();
    final jsonMaps = ProductObjectBoxUtil.toModels(entities)
        .map((product) => product.toJson())
        .toList();

    return await compute(decodeProductMaps, jsonMaps);
  }

  Future<ProductModel?> getProduct(int productId) async {
    final entity = _box.get(productId);
    return entity?.toModel();
  }

  Future<void> clearProducts() async {
    _box.removeAll();
  }
}

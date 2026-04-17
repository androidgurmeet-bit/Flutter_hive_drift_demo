import 'dart:convert';

import 'package:product_benchmark_app/data/model/product_model.dart';
import 'package:product_benchmark_app/data/model/product_objectbox_model.dart';

class ProductObjectBoxUtil {
  ProductObjectBoxUtil._();

  static List<ProductObjectBox> toEntities(List<ProductModel> products) {
    return products.map(ProductObjectBox.fromModel).toList();
  }

  static List<ProductModel> toModels(List<ProductObjectBox> entities) {
    return entities.map((entity) => entity.toModel()).toList();
  }

  static List<Map<String, dynamic>> toJsonMaps(List<ProductModel> products) {
    return products.map((product) => product.toJson()).toList();
  }

  static List<ProductModel> fromJsonMaps(List<dynamic> jsonMaps) {
    return jsonMaps
        .cast<Map<String, dynamic>>()
        .map(ProductModel.fromMap)
        .toList();
  }
}

List<String> encodeProductMaps(List<Map<String, dynamic>> productMaps) {
  return productMaps.map(jsonEncode).toList();
}

List<ProductModel> decodeProductMaps(List<dynamic> jsonMaps) {
  return jsonMaps
      .cast<Map<String, dynamic>>()
      .map(ProductModel.fromMap)
      .toList();
}

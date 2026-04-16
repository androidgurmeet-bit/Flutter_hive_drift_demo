import 'dart:developer';

import 'package:product_benchmark_app/data/config/api_config.dart';
import 'package:product_benchmark_app/data/model/fetch_products_result.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource();

  Future<FetchProductsResult> fetchProducts({int? largeTestCount}) {
    return _generateProductsLocally(count: largeTestCount);
  }

  Future<FetchProductsResult> _generateProductsLocally({int? count}) async {
    final effectiveCount = count ?? ApiConfig.largeTestProductsCount ?? 50000;
    final generationWatch = Stopwatch()..start();
    final products = List<ProductModel>.generate(
      effectiveCount,
      (index) => _buildDummyProduct(index + 1),
      growable: false,
    );
    generationWatch.stop();

    final estimatedBytes = _estimatePayloadBytes(products);

    log(
      'fetchProducts[local-large-test] estimated payload: ${_formatBytes(estimatedBytes)} '
      '($estimatedBytes bytes), '
      'generation time: ${generationWatch.elapsedMilliseconds} ms, '
      'items: ${products.length}',
      name: 'ProductRemoteDataSource',
    );

    return FetchProductsResult(
      products: products,
      sourceLabel: 'local generator',
      isLocalGeneration: true,
      responseBytes: estimatedBytes,
      requestTimeMs: 0,
      decodeTimeMs: 0,
      generationTimeMs: generationWatch.elapsedMilliseconds,
    );
  }
}

const List<String> _brands = [
  'Lava',
  'Samsung',
  'Motorola',
  'Xiaomi',
  'OnePlus',
  'Apple',
  'Google',
  'Realme',
  'Vivo',
  'Oppo',
];

const List<String> _models = [
  'Edge 50',
  'Note 13',
  'Phone 2a',
  'Nord 4',
  'Pixel 9',
  'iPhone 16',
  'Galaxy A55',
  'X200',
  'Find X8',
  'GT Neo 7',
];

const List<String> _variants = [
  '6GB/128GB',
  '8GB/128GB',
  '8GB/256GB',
  '12GB/256GB',
  '12GB/512GB',
];

const List<String> _colors = [
  'Black',
  'White',
  'Blue',
  'Red',
  'Green',
  'Silver',
  'Titanium',
];

const List<String> _imageUrls = [
  'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
  'https://images.unsplash.com/photo-1580913428706-c311e67898b3?w=400',
  'https://images.unsplash.com/photo-1523206489230-c012c64b2b48?w=400',
  'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=400',
  'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=400',
];

ProductModel _buildDummyProduct(int sequence) {
  final brand = _brands[(sequence - 1) % _brands.length];
  final model = _models[(sequence - 1) % _models.length];
  final variant = _variants[(sequence - 1) % _variants.length];
  final color = _colors[(sequence - 1) % _colors.length];
  final price = 11000 + ((sequence * 137) % 89000) + 0.49;
  final quantity = 5 + (sequence % 75);
  final description = '$brand $model in $color with $variant configuration.';

  return ProductModel(
    id: sequence,
    name: '$brand $model $variant $color Edition #$sequence',
    price: price,
    productUrl: _imageUrls[(sequence - 1) % _imageUrls.length],
    quantity: quantity,
    description: description,
  );
}

int _estimatePayloadBytes(List<ProductModel> products) {
  if (products.isEmpty) {
    return 2;
  }

  var totalBytes = 2;

  for (var index = 0; index < products.length; index++) {
    final product = products[index];
    totalBytes += _estimateProductJsonBytes(product);

    if (index < products.length - 1) {
      totalBytes += 1;
    }
  }

  return totalBytes;
}

int _estimateProductJsonBytes(ProductModel product) {
  final idValue = product.id.toString().length;
  final nameValue = product.name.length;
  final priceValue = product.price.toStringAsFixed(2).length;
  final productUrlValue = product.productUrl.length;
  final quantityValue = product.quantity.toString().length;
  final descriptionValue = product.description?.length ?? 0;

  return 52 +
      idValue +
      nameValue +
      priceValue +
      productUrlValue +
      quantityValue +
      descriptionValue;
}

String _formatBytes(int bytes) {
  const units = ['B', 'KB', 'MB', 'GB'];
  var value = bytes.toDouble();
  var unitIndex = 0;

  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex++;
  }

  return '${value.toStringAsFixed(unitIndex == 0 ? 0 : 2)} ${units[unitIndex]}';
}

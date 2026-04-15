import 'package:product_benchmark_app/data/model/product_model.dart';

class FetchProductsResult {
  final List<ProductModel> products;
  final String sourceLabel;
  final bool isLocalGeneration;
  final int responseBytes;
  final int requestTimeMs;
  final int decodeTimeMs;
  final int generationTimeMs;

  const FetchProductsResult({
    required this.products,
    required this.sourceLabel,
    required this.isLocalGeneration,
    required this.responseBytes,
    required this.requestTimeMs,
    required this.decodeTimeMs,
    required this.generationTimeMs,
  });
}

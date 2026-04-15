import 'package:product_benchmark_app/domain/entity/product.dart';
import 'package:product_benchmark_app/domain/entity/product_benchmark.dart';

class ProductLoadResult {
  final List<Product> products;
  final ProductBenchmark benchmark;

  const ProductLoadResult({
    required this.products,
    required this.benchmark,
  });
}
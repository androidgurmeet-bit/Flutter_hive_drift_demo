import 'package:product_benchmark_app/data/config/product_storage_mode.dart';
import 'package:product_benchmark_app/domain/entity/product_load_result.dart';
import 'package:product_benchmark_app/domain/repository/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<ProductLoadResult> call({
    int? largeTestCount,
    ProductStorageMode storageMode = ProductStorageMode.dualWrite,
  }) {
    return repository.getProducts(
      largeTestCount: largeTestCount,
      storageMode: storageMode,
    );
  }
}

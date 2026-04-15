import 'package:product_benchmark_app/data/config/product_storage_mode.dart';
import 'package:product_benchmark_app/domain/entity/product_load_result.dart';

abstract class ProductRepository {
  Future<ProductLoadResult> getProducts({
    int? largeTestCount,
    ProductStorageMode storageMode = ProductStorageMode.dualWrite,
  });
}

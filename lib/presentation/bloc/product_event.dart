import 'package:product_benchmark_app/data/config/product_storage_mode.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {
  final int? largeTestCount;
  final ProductStorageMode storageMode;

  LoadProductsEvent({
    this.largeTestCount,
    this.storageMode = ProductStorageMode.dualWrite,
  });
}

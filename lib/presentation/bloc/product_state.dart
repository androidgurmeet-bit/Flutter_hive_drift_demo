import 'package:product_benchmark_app/domain/entity/product_load_result.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductLoadResult result;

  ProductLoaded(this.result);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
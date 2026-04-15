import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_benchmark_app/domain/usecase/get_products_use_case.dart';
import 'package:product_benchmark_app/presentation/bloc/product_event.dart';
import 'package:product_benchmark_app/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase useCase;

  ProductBloc(this.useCase) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final result = await useCase(
        largeTestCount: event.largeTestCount,
        storageMode: event.storageMode,
      );
      emit(ProductLoaded(result));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }
}

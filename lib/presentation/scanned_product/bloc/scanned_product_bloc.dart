import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/scanned_product_repository.dart';
import 'scanned_product_event.dart';
import 'scanned_product_state.dart';

class ScannedProductBloc
    extends Bloc<ScannedProductEvent, ScannedProductState> {
  final ScannedProductRepository repository;

  ScannedProductBloc({required this.repository})
    : super(const ScannedProductState()) {
    on<LoadScannedProducts>(_onLoadScannedProducts);
    on<DeleteScannedProduct>(_onDeleteScannedProduct);
  }

  Future<void> _onLoadScannedProducts(
    LoadScannedProducts event,
    Emitter<ScannedProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final products = await repository.getUserScannedProducts(event.userId);
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onDeleteScannedProduct(
    DeleteScannedProduct event,
    Emitter<ScannedProductState> emit,
  ) async {
    try {
      await repository.deleteScannedProduct(event.id);
      final updatedProducts = state.products
          .where((product) => product.id != event.id)
          .toList();
      emit(state.copyWith(products: updatedProducts));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}

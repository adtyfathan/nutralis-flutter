import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/scanned_product_repository.dart';
import '../../../data/models/scanned_product_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final ScannedProductRepository scannedProductRepository;

  ProductBloc({
    required this.productRepository,
    required this.scannedProductRepository,
  }) : super(const ProductState()) {
    on<LoadProductDetails>(_onLoadProductDetails);
    on<SearchProducts>(_onSearchProducts);
    on<SaveScannedProduct>(_onSaveScannedProduct);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetails event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final product = await productRepository.getProductByBarcode(
        event.barcode,
      );
      emit(state.copyWith(product: product, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(searchResults: [], errorMessage: null));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final products = await productRepository.searchProducts(
        query: event.query,
        page: 1,
      );
      emit(state.copyWith(searchResults: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onSaveScannedProduct(
    SaveScannedProduct event,
    Emitter<ProductState> emit,
  ) async {
    if (state.product == null) return;

    try {
      final product = state.product!.product;

      final scannedProduct = ScannedProductModel(
        userId: event.userId,
        code: state.product!.code,
        productName: product.productName,
        imageUrl: product.imageUrl,
        nutriscoreGrade: product.nutriscoreGrade,
        nutriscoreScore: product.nutriscoreScore,
        productType: product.productType ?? product.categoriesTags?.first,
        scannedAt: DateTime.now(),
      );

      await scannedProductRepository.addScannedProduct(scannedProduct);
    } catch (e) {
      // Silent fail - don't interrupt user flow
      print('Failed to save scanned product: $e');
    }
  }
}

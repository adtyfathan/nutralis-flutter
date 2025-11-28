import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

class ProductState extends Equatable {
  final ProductResponse? product;
  final List<ProductResponse> searchResults;
  final bool isLoading;
  final String? errorMessage;

  const ProductState({
    this.product,
    this.searchResults = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ProductState copyWith({
    ProductResponse? product,
    List<ProductResponse>? searchResults,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      product: product ?? this.product,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [product, searchResults, isLoading, errorMessage];
}

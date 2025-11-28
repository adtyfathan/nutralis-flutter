import 'package:equatable/equatable.dart';
import '../../../data/models/scanned_product_model.dart';

class ScannedProductState extends Equatable {
  final List<ScannedProductModel> products;
  final bool isLoading;
  final String? errorMessage;

  const ScannedProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ScannedProductState copyWith({
    List<ScannedProductModel>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ScannedProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, errorMessage];
}

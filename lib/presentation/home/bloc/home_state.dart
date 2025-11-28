import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

class HomeState extends Equatable {
  final List<ProductResponse> products;
  final String selectedCategory;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.products = const [],
    this.selectedCategory = 'All',
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    List<ProductResponse>? products,
    String? selectedCategory,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    products,
    selectedCategory,
    isLoading,
    errorMessage,
  ];
}

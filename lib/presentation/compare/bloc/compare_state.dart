import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

class CompareState extends Equatable {
  final ProductResponse? productOne;
  final ProductResponse? productTwo;

  const CompareState({
    this.productOne,
    this.productTwo,
  });

  bool get canCompare => productOne != null && productTwo != null;

  CompareState copyWith({
    ProductResponse? productOne,
    ProductResponse? productTwo,
    bool clearProductOne = false,
    bool clearProductTwo = false,
  }) {
    return CompareState(
      productOne: clearProductOne ? null : (productOne ?? this.productOne),
      productTwo: clearProductTwo ? null : (productTwo ?? this.productTwo),
    );
  }

  @override
  List<Object?> get props => [productOne, productTwo];
}

class SearchInitial extends CompareState {
  const SearchInitial();
}

class SearchLoading extends CompareState {
  const SearchLoading();
}

class SearchSuccess extends CompareState {
  final List<ProductResponse> products;
  final String query;

  const SearchSuccess({
    required this.products,
    required this.query,
  });

  @override
  List<Object?> get props => [products, query];
}

class SearchError extends CompareState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchEmpty extends CompareState {
  final String query;

  const SearchEmpty(this.query);

  @override
  List<Object?> get props => [query];
}
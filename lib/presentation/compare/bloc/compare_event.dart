import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';

abstract class CompareEvent extends Equatable {
  const CompareEvent();

  @override
  List<Object?> get props => [];
}

class SelectProductOneEvent extends CompareEvent {
  final ProductResponse product;

  const SelectProductOneEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class SearchProductsEvent extends CompareEvent {
  final String query;
  final int page;

  const SearchProductsEvent({
    required this.query,
    this.page = 1,
  });

  @override
  List<Object?> get props => [query, page];
}

class SelectProductTwoEvent extends CompareEvent {
  final ProductResponse product;

  const SelectProductTwoEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearProductOneEvent extends CompareEvent {
  const ClearProductOneEvent();
}

class ClearProductTwoEvent extends CompareEvent {
  const ClearProductTwoEvent();
}

class ResetCompareEvent extends CompareEvent {
  const ResetCompareEvent();
}
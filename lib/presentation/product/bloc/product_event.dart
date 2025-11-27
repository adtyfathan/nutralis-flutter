import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductDetails extends ProductEvent {
  final String barcode;

  const LoadProductDetails(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SaveScannedProduct extends ProductEvent {
  final String userId;
  final String barcode;

  const SaveScannedProduct({required this.userId, required this.barcode});

  @override
  List<Object?> get props => [userId, barcode];
}

import 'package:equatable/equatable.dart';

abstract class ScannedProductEvent extends Equatable {
  const ScannedProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadScannedProducts extends ScannedProductEvent {
  final String userId;

  const LoadScannedProducts(this.userId);

  @override
  List<Object?> get props => [userId];
}

class DeleteScannedProduct extends ScannedProductEvent {
  final int id;

  const DeleteScannedProduct(this.id);

  @override
  List<Object?> get props => [id];
}
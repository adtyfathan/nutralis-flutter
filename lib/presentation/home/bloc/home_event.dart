import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeProducts extends HomeEvent {
  final String category;

  const LoadHomeProducts(this.category);

  @override
  List<Object?> get props => [category];
}

class ChangeCategoryEvent extends HomeEvent {
  final String category;

  const ChangeCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

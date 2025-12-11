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

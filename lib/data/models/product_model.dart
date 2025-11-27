import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String code;
  final String? productName;
  final String? imageUrl;
  final String? nutritionGrade;
  final int? nutritionScore;
  final Map<String, dynamic>? nutriments;
  final List<String>? categories;

  const ProductModel({
    required this.code,
    this.productName,
    this.imageUrl,
    this.nutritionGrade,
    this.nutritionScore,
    this.nutriments,
    this.categories,
  });

  factory ProductModel.fromOpenFoodFacts(Map<String, dynamic> json) {
    final product = json['product'] ?? {};
    return ProductModel(
      code: product['code']?.toString() ?? json['code']?.toString() ?? '',
      productName: product['product_name'] ?? product['product_name_en'],
      imageUrl: product['image_url'] ?? product['image_front_url'],
      nutritionGrade:
          product['nutrition_grades'] ?? product['nutriscore_grade'],
      nutritionScore: product['nutriscore_score'],
      nutriments: product['nutriments'] ?? {},
      categories: (product['categories_tags'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  factory ProductModel.fromSearch(Map<String, dynamic> json) {
    return ProductModel(
      code: json['code']?.toString() ?? '',
      productName: json['product_name'],
      imageUrl: json['image_url'],
      nutritionGrade: json['nutrition_grades'],
      nutritionScore: json['nutriscore_score'],
      nutriments: {},
      categories: (json['categories_tags_en'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    code,
    productName,
    imageUrl,
    nutritionGrade,
    nutritionScore,
    nutriments,
    categories,
  ];
}

import 'package:equatable/equatable.dart';

class ProductResponse extends Equatable {
  final String code;
  final Product product;

  const ProductResponse({required this.code, required this.product});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      code: json['code']?.toString() ?? '',
      product: Product.fromJson(json['product'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [code, product];
}

class Product extends Equatable {
  final String? productName;
  final String? productType;
  final List<String>? allergensHierarchy;
  final List<String>? categoriesTags;
  final String? countries;
  final String? imageUrl;
  final List<Ingredient>? ingredients;
  final NutrientLevels? nutrientLevels;
  final Nutriments? nutriments;
  final String? nutriscoreGrade;
  final int? nutriscoreScore;
  final String? packaging;

  const Product({
    this.productName,
    this.productType,
    this.allergensHierarchy,
    this.categoriesTags,
    this.countries,
    this.imageUrl,
    this.ingredients,
    this.nutrientLevels,
    this.nutriments,
    this.nutriscoreGrade,
    this.nutriscoreScore,
    this.packaging,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      productType: json['product_type'],
      allergensHierarchy: (json['allergens_hierarchy'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      categoriesTags: (json['categories_tags'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      countries: json['countries'],
      imageUrl: json['image_url'] ?? json['image_front_url'],
      ingredients: (json['ingredients'] as List?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      nutrientLevels: json['nutrient_levels'] != null
          ? NutrientLevels.fromJson(json['nutrient_levels'])
          : null,
      nutriments: json['nutriments'] != null
          ? Nutriments.fromJson(json['nutriments'])
          : null,
      nutriscoreGrade: json['nutriscore_grade'] ?? json['nutrition_grades'],
      nutriscoreScore: json['nutriscore_score'],
      packaging: json['packaging'],
    );
  }

  @override
  List<Object?> get props => [
    productName,
    productType,
    allergensHierarchy,
    categoriesTags,
    countries,
    imageUrl,
    ingredients,
    nutrientLevels,
    nutriments,
    nutriscoreGrade,
    nutriscoreScore,
    packaging,
  ];
}

class Ingredient extends Equatable {
  final String? text;
  final double? percentEstimate;

  const Ingredient({this.text, this.percentEstimate});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      text: json['text'],
      percentEstimate: json['percent_estimate']?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [text, percentEstimate];
}

class NutrientLevels extends Equatable {
  final String? fat;
  final String? salt;
  final String? saturatedFat;
  final String? sugars;

  const NutrientLevels({this.fat, this.salt, this.saturatedFat, this.sugars});

  factory NutrientLevels.fromJson(Map<String, dynamic> json) {
    return NutrientLevels(
      fat: json['fat'],
      salt: json['salt'],
      saturatedFat: json['saturated-fat'],
      sugars: json['sugars'],
    );
  }

  @override
  List<Object?> get props => [fat, salt, saturatedFat, sugars];
}

class Nutriments extends Equatable {
  final double? carbohydrates;
  final String? carbohydratesUnit;
  final double? energy;
  final String? energyUnit;
  final double? fat;
  final String? fatUnit;
  final double? proteins;
  final String? proteinsUnit;
  final double? salt;
  final String? saltUnit;
  final double? saturatedFat;
  final String? saturatedFatUnit;
  final double? sodium;
  final String? sodiumUnit;
  final double? sugars;
  final String? sugarsUnit;
  final int? nutritionScoreFr;
  final int? novaGroup;

  const Nutriments({
    this.carbohydrates,
    this.carbohydratesUnit,
    this.energy,
    this.energyUnit,
    this.fat,
    this.fatUnit,
    this.proteins,
    this.proteinsUnit,
    this.salt,
    this.saltUnit,
    this.saturatedFat,
    this.saturatedFatUnit,
    this.sodium,
    this.sodiumUnit,
    this.sugars,
    this.sugarsUnit,
    this.nutritionScoreFr,
    this.novaGroup,
  });

  factory Nutriments.fromJson(Map<String, dynamic> json) {
    return Nutriments(
      carbohydrates: json['carbohydrates']?.toDouble(),
      carbohydratesUnit: json['carbohydrates_unit'],
      energy: json['energy']?.toDouble(),
      energyUnit: json['energy_unit'],
      fat: json['fat']?.toDouble(),
      fatUnit: json['fat_unit'],
      proteins: json['proteins']?.toDouble(),
      proteinsUnit: json['proteins_unit'],
      salt: json['salt']?.toDouble(),
      saltUnit: json['salt_unit'],
      saturatedFat: json['saturated-fat']?.toDouble(),
      saturatedFatUnit: json['saturated-fat_unit'],
      sodium: json['sodium']?.toDouble(),
      sodiumUnit: json['sodium_unit'],
      sugars: json['sugars']?.toDouble(),
      sugarsUnit: json['sugars_unit'],
      nutritionScoreFr: json['nutrition-score-fr'],
      novaGroup: json['nova-group'],
    );
  }

  @override
  List<Object?> get props => [
    carbohydrates,
    carbohydratesUnit,
    energy,
    energyUnit,
    fat,
    fatUnit,
    proteins,
    proteinsUnit,
    salt,
    saltUnit,
    saturatedFat,
    saturatedFatUnit,
    sodium,
    sodiumUnit,
    sugars,
    sugarsUnit,
    nutritionScoreFr,
    novaGroup,
  ];
}

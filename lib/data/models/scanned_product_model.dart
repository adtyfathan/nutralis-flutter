import 'package:equatable/equatable.dart';

class ScannedProductModel extends Equatable {
  final int? id;
  final String userId;
  final String code;
  final String? productName;
  final String? imageUrl;
  final String? nutriscoreGrade;
  final int? nutriscoreScore;
  final String? productType;
  final DateTime scannedAt;
  
  const ScannedProductModel({
    this.id,
    required this.userId,
    required this.code,
    this.productName,
    this.imageUrl,
    this.nutriscoreGrade,
    this.nutriscoreScore,
    this.productType,
    required this.scannedAt,
  });
  
  factory ScannedProductModel.fromJson(Map<String, dynamic> json) {
    return ScannedProductModel(
      id: json['id'],
      userId: json['user_id'] ?? '',
      code: json['code'] ?? '',
      productName: json['product_name'],
      imageUrl: json['image_url'],
      nutriscoreGrade: json['nutriscore_grade'],
      nutriscoreScore: json['nutriscore_score'],
      productType: json['product_type'],
      scannedAt: json['scanned_at'] != null
          ? DateTime.parse(json['scanned_at'])
          : DateTime.now(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'code': code,
      'product_name': productName,
      'image_url': imageUrl,
      'nutriscore_grade': nutriscoreGrade,
      'nutriscore_score': nutriscoreScore,
      'product_type': productType,
      'scanned_at': scannedAt.toIso8601String(),
    };
  }
  
  @override
  List<Object?> get props => [
    id,
    userId,
    code,
    productName,
    imageUrl,
    nutriscoreGrade,
    nutriscoreScore,
    productType,
    scannedAt,
  ];
}
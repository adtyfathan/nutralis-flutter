import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../models/product_model.dart';

class ProductDataSource {
  final Dio dio;

  ProductDataSource(this.dio);

  Future<ProductModel> getProductByBarcode(String barcode) async {
    try {
      final response = await dio.get(
        '${AppConstants.foodFactsBaseUrl}/product/$barcode',
      );

      if (response.statusCode == 200 && response.data['status'] == 1) {
        return ProductModel.fromOpenFoodFacts(response.data);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch product: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> searchProducts({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        '${AppConstants.foodFactsBaseUrl}/search',
        queryParameters: {
          'search_terms': query,
          'page': page,
          'page_size': 20,
          'fields':
              'code,product_name,nutrition_grades,image_url,nutriscore_score,categories_tags',
        },
      );

      if (response.statusCode == 200) {
        final products = (response.data['products'] as List)
            .map((json) => ProductModel.fromSearch(json))
            .toList();
        return products;
      } else {
        throw Exception('Search failed');
      }
    } catch (e) {
      throw Exception('Failed to search products: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int page = 1,
  }) async {
    try {
      final response = await dio.get(
        '${AppConstants.foodFactsBaseUrl}/search',
        queryParameters: {
          'categories_tags': category.toLowerCase(),
          'page': page,
          'page_size': 20,
          'fields':
              'code,product_name,nutrition_grades,image_url,nutriscore_score,categories_tags',
        },
      );

      if (response.statusCode == 200) {
        final products = (response.data['products'] as List)
            .map((json) => ProductModel.fromSearch(json))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch category products: ${e.toString()}');
    }
  }
}

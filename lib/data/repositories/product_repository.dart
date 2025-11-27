import '../datasources/product_datasource.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ProductDataSource dataSource;

  ProductRepository(this.dataSource);

  Future<ProductModel> getProductByBarcode(String barcode) async {
    return await dataSource.getProductByBarcode(barcode);
  }

  Future<List<ProductModel>> searchProducts({
    required String query,
    int page = 1,
  }) async {
    return await dataSource.searchProducts(query: query, page: page);
  }

  Future<List<ProductModel>> getProductsByCategory({
    required String category,
    int page = 1,
  }) async {
    if (category.toLowerCase() == 'all') {
      return await dataSource.searchProducts(query: '', page: page);
    }
    return await dataSource.getProductsByCategory(
      category: category,
      page: page,
    );
  }
}

import '../datasources/scanned_product_datasource.dart';
import '../models/scanned_product_model.dart';

class ScannedProductRepository {
  final ScannedProductDataSource dataSource;

  ScannedProductRepository(this.dataSource);

  Future<List<ScannedProductModel>> getUserScannedProducts(
    String userId,
  ) async {
    return await dataSource.getUserScannedProducts(userId);
  }

  Future<ScannedProductModel> addScannedProduct(
    ScannedProductModel product,
  ) async {
    return await dataSource.addScannedProduct(product);
  }

  Future<void> deleteScannedProduct(int id) async {
    await dataSource.deleteScannedProduct(id);
  }
}

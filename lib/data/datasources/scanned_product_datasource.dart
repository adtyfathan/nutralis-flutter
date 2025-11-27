import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/scanned_product_model.dart';

class ScannedProductDataSource {
  final SupabaseClient supabase;

  ScannedProductDataSource(this.supabase);

  Future<List<ScannedProductModel>> getUserScannedProducts(
    String userId,
  ) async {
    try {
      final response = await supabase
          .from('scanned_products')
          .select()
          .eq('user_id', userId)
          .order('scanned_at', ascending: false);

      return (response as List)
          .map((json) => ScannedProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch scanned products: ${e.toString()}');
    }
  }

  Future<ScannedProductModel> addScannedProduct(
    ScannedProductModel product,
  ) async {
    try {
      final response = await supabase
          .from('scanned_products')
          .insert(product.toJson())
          .select()
          .single();

      return ScannedProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add scanned product: ${e.toString()}');
    }
  }

  Future<void> deleteScannedProduct(int id) async {
    try {
      await supabase.from('scanned_products').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete scanned product: ${e.toString()}');
    }
  }
}

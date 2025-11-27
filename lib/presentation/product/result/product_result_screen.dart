import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../bloc/product_event.dart';

class ProductResultScreen extends StatefulWidget {
  final String barcode;

  const ProductResultScreen({super.key, required this.barcode});

  @override
  State<ProductResultScreen> createState() => _ProductResultScreenState();
}

class _ProductResultScreenState extends State<ProductResultScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductDetails(widget.barcode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: const Text("Product Details"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryGreen),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }

          if (state.product == null) {
            return const Center(child: Text("Product not found"));
          }

          final p = state.product!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildImageCard(p.imageUrl, p.nutritionGrade),
              const SizedBox(height: 16),
              _buildInfoCard(p),
              if (p.categories != null && p.categories!.isNotEmpty)
                _buildCategoriesCard(p.categories!),
              if (p.nutriments != null && p.nutriments!.isNotEmpty)
                _buildNutrimentsCard(p.nutriments!),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  // IMAGE + GRADE
  Widget _buildImageCard(String? url, String? grade) {
    final gradeColor = {
      "a": const Color(0xFF4CAF50),
      "b": const Color(0xFF8BC34A),
      "c": const Color(0xFFFFC107),
      "d": const Color(0xFFFF9800),
      "e": const Color(0xFFF44336),
    }[grade?.toLowerCase()] ?? Colors.grey;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              url ?? "",
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported, size: 60),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: gradeColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                grade?.toUpperCase() ?? "-",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BASIC INFORMATION
  Widget _buildInfoCard(product) {
    return _buildCard(
      "Product Information",
      Column(
        children: [
          _infoRow("Barcode", product.code),
          _infoRow("Name", product.productName),
          _infoRow("Nutrition Grade", product.nutritionGrade?.toUpperCase()),
          _infoRow("Nutrition Score", "${product.nutritionScore ?? "-"} / 100"),
        ],
      ),
    );
  }

  // CATEGORIES
  Widget _buildCategoriesCard(List<String> categories) {
    return _buildCard(
      "Categories",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((c) {
          final formatted =
              c.contains(":") ? c.split(":").last : c;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Text(formatted, style: const TextStyle(fontSize: 14)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // NUTRIMENT MAP
  Widget _buildNutrimentsCard(Map<String, dynamic> nutriments) {
    return _buildCard(
      "Nutriments",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nutriments.entries.map((entry) {
          return _infoRow(entry.key, entry.value.toString());
        }).toList(),
      ),
    );
  }

  // === HELPERS ===
  Widget _buildCard(String title, Widget content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.isNotEmpty == true ? value! : "Unknown",
              style: const TextStyle(fontSize: 14, color: Color(0xFF2E2E2E)),
            ),
          ),
        ],
      ),
    );
  }
}

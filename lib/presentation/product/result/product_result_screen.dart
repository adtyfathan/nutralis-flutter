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
              child: Card(
                margin: const EdgeInsets.all(24),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.errorMessage!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state.product == null) {
            return const Center(child: Text("Product not found"));
          }

          final productResponse = state.product!;
          final product = productResponse.product;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildImageCard(product.imageUrl, product.nutriscoreGrade),
              const SizedBox(height: 16),
              _buildInfoCard(productResponse.code, product),
              const SizedBox(height: 16),
              if (product.categoriesTags != null &&
                  product.categoriesTags!.isNotEmpty)
                _buildCategoriesCard(product.categoriesTags!),
              if (product.nutrientLevels != null &&
                  _hasAnyNutrientLevel(product.nutrientLevels!))
                _buildNutrientLevelsCard(product.nutrientLevels!),
              if (product.nutriments != null &&
                  _hasAnyNutriment(product.nutriments!))
                _buildNutrimentsCard(product.nutriments!),
              if (product.ingredients != null &&
                  product.ingredients!.isNotEmpty)
                _buildIngredientsCard(product.ingredients!),
              if (product.allergensHierarchy != null &&
                  product.allergensHierarchy!.isNotEmpty)
                _buildAllergensCard(product.allergensHierarchy!),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  // IMAGE + GRADE
  Widget _buildImageCard(String? url, String? grade) {
    final gradeColor =
        {
          "a": const Color(0xFF4CAF50),
          "b": const Color(0xFF8BC34A),
          "c": const Color(0xFFFFC107),
          "d": const Color(0xFFFF9800),
          "e": const Color(0xFFF44336),
        }[grade?.toLowerCase()] ??
        Colors.grey;

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
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BASIC INFORMATION
  Widget _buildInfoCard(String barcode, product) {
    return _buildCard(
      "Product Information",
      Column(
        children: [
          _infoRow("Barcode", barcode),
          _infoRow("Product Name", product.productName),
          _infoRow(
            "Nutrition Score",
            product.nutriscoreScore != null
                ? "${product.nutriscoreScore}/100"
                : null,
          ),
          _infoRow("Packaging", product.packaging),
          _infoRow("Manufacturer", product.countries),
        ],
      ),
    );
  }

  // CATEGORIES
  Widget _buildCategoriesCard(List<String> categories) {
    return _buildCard(
      "Product Categories",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((c) {
          final formatted = c.contains(":") ? c.split(":").last : c;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF81C784),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    formatted,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // NUTRIENT LEVELS
  Widget _buildNutrientLevelsCard(nutrientLevels) {
    return _buildCard(
      "Nutrient Levels",
      Column(
        children: [
          if (nutrientLevels.fat != null)
            _nutrientLevelRow("Fat", nutrientLevels.fat),
          if (nutrientLevels.salt != null)
            _nutrientLevelRow("Salt", nutrientLevels.salt),
          if (nutrientLevels.saturatedFat != null)
            _nutrientLevelRow("Saturated Fat", nutrientLevels.saturatedFat),
          if (nutrientLevels.sugars != null)
            _nutrientLevelRow("Sugars", nutrientLevels.sugars),
        ],
      ),
    );
  }

  // NUTRIMENTS
  Widget _buildNutrimentsCard(nutriments) {
    return _buildCard(
      "Nutrients",
      Column(
        children: [
          if (nutriments.carbohydrates != null)
            _infoRow(
              "Carbohydrates",
              "${nutriments.carbohydrates} ${nutriments.carbohydratesUnit ?? ''}",
            ),
          if (nutriments.energy != null)
            _infoRow(
              "Energy",
              "${nutriments.energy} ${nutriments.energyUnit ?? ''}",
            ),
          if (nutriments.fat != null)
            _infoRow("Fat", "${nutriments.fat} ${nutriments.fatUnit ?? ''}"),
          if (nutriments.proteins != null)
            _infoRow(
              "Protein",
              "${nutriments.proteins} ${nutriments.proteinsUnit ?? ''}",
            ),
          if (nutriments.salt != null)
            _infoRow("Salt", "${nutriments.salt} ${nutriments.saltUnit ?? ''}"),
          if (nutriments.saturatedFat != null)
            _infoRow(
              "Saturated Fat",
              "${nutriments.saturatedFat} ${nutriments.saturatedFatUnit ?? ''}",
            ),
          if (nutriments.sodium != null)
            _infoRow(
              "Sodium",
              "${nutriments.sodium} ${nutriments.sodiumUnit ?? ''}",
            ),
          if (nutriments.sugars != null)
            _infoRow(
              "Sugars",
              "${nutriments.sugars} ${nutriments.sugarsUnit ?? ''}",
            ),
        ],
      ),
    );
  }

  // INGREDIENTS
  Widget _buildIngredientsCard(List ingredients) {
    return _buildCard(
      "Ingredients",
      Column(
        children: ingredients.map((ingredient) {
          return _infoRow(
            ingredient.text ?? "Unknown",
            ingredient.percentEstimate != null
                ? "${ingredient.percentEstimate}%"
                : null,
          );
        }).toList(),
      ),
    );
  }

  // ALLERGENS
  Widget _buildAllergensCard(List<String> allergens) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEBA100), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Allergen Warning",
              style: TextStyle(
                color: Color(0xFFEBA100),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...allergens.map((allergen) {
              final formatted = allergen.contains(":")
                  ? allergen.split(":").last
                  : allergen;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBA100),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        formatted,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E2E2E),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
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
    final displayValue = value != null && value.contains(":") ? value.split(":").last : value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              displayValue?.isNotEmpty == true ? displayValue! : "Unknown",
              style: const TextStyle(fontSize: 14, color: Color(0xFF2E2E2E)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutrientLevelRow(String label, String? value) {
    final nutrientLevelColor =
        {
          "low": const Color(0xFF1df705),
          "moderate": const Color(0xFFebf705),
          "high": const Color(0xFFf73105),
        }[value?.toLowerCase()] ??
        const Color(0xFF212121);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              style: TextStyle(
                fontSize: 14,
                color: nutrientLevelColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  bool _hasAnyNutrientLevel(nutrientLevels) {
    return nutrientLevels.fat != null ||
        nutrientLevels.salt != null ||
        nutrientLevels.saturatedFat != null ||
        nutrientLevels.sugars != null;
  }

  bool _hasAnyNutriment(nutriments) {
    return nutriments.carbohydrates != null ||
        nutriments.energy != null ||
        nutriments.fat != null ||
        nutriments.proteins != null ||
        nutriments.salt != null ||
        nutriments.saturatedFat != null ||
        nutriments.sodium != null ||
        nutriments.sugars != null;
  }
}

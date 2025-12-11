import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/comparison_section.dart';
import 'widgets/product_header.dart';
import 'widgets/info_card.dart';
import 'widgets/nutrient_level.dart';
import 'widgets/nutriments_comparison.dart';

class CompareResultPage extends StatelessWidget {
  final ProductResponse productOne;
  final ProductResponse productTwo;
  

  const CompareResultPage({
    super.key,
    required this.productOne,
    required this.productTwo,
  });

  String _getWinner(String? grade1, String? grade2) {
    const gradeOrder = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5};
    final score1 = gradeOrder[grade1?.toLowerCase()] ?? 6;
    final score2 = gradeOrder[grade2?.toLowerCase()] ?? 6;

    if (score1 < score2) return 'left';
    if (score2 < score1) return 'right';
    return 'tie';
  }

  String _getBetterNutrientLevel(String? level1, String? level2) {
    const levelOrder = {'low': 1, 'moderate': 2, 'high': 3};
    final score1 = levelOrder[level1?.toLowerCase()] ?? 4;
    final score2 = levelOrder[level2?.toLowerCase()] ?? 4;

    if (score1 < score2) return 'left';
    if (score2 < score1) return 'right';
    return 'tie';
  }

  Color _getNutrientLevelColor(String? level) {
    if (level == null) return Colors.grey;
    switch (level.toLowerCase()) {
      case 'low':
        return const Color(0xFF4CAF50);
      case 'moderate':
        return const Color(0xFFFFA726);
      case 'high':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final winner = _getWinner(
      productOne.product.nutriscoreGrade,
      productTwo.product.nutriscoreGrade,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Comparison Result',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Products Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Product 1
                  Expanded(
                    child: ProductHeader(
                      product: productOne,
                      nutriScoreColor: AppTheme.getNutriScoreColor(
                        productOne.product.nutriscoreGrade,
                      ),
                      isWinner: winner == 'left',
                    ),
                  ),
                  const SizedBox(width: 20),
                  // VS
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'VS',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Product 2
                  Expanded(
                    child: ProductHeader(
                      product: productTwo,
                      nutriScoreColor: AppTheme.getNutriScoreColor(
                        productTwo.product.nutriscoreGrade,
                      ),
                      isWinner: winner == 'right',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionTitle(title: 'Product Information'),
            InfoCardComparison(
              productOne: productOne,
              productTwo: productTwo,
            ),

            // Nutri-Score Comparison
            ComparisonSection(
              title: 'Nutri-Score',
              leftValue:
                  (productOne.product.nutriscoreGrade ?? '?').toUpperCase(),
              rightValue:
                  (productTwo.product.nutriscoreGrade ?? '?').toUpperCase(),
              leftColor: AppTheme.getNutriScoreColor(
                productOne.product.nutriscoreGrade,
              ),
              rightColor: AppTheme.getNutriScoreColor(
                productTwo.product.nutriscoreGrade,
              ),
              winner: winner,
            ),

            // Categories
            ComparisonSection(
              title: 'Categories',
              leftValue: productOne.product.categoriesTags ?? [],
              rightValue: productTwo.product.categoriesTags ?? [],
              winner: 'tie',
            ),

            // Nutrient Levels
            _SectionTitle(title: 'Nutrient Levels'),
            NutrientLevelsComparison(
              nutrientLevelsOne: productOne.product.nutrientLevels,
              nutrientLevelsTwo: productTwo.product.nutrientLevels,
              getNutrientLevelColor: _getNutrientLevelColor,
              getBetterNutrientLevel: _getBetterNutrientLevel,
            ),

            // Nutriments
            _SectionTitle(title: 'Nutriments (per 100g/100ml)'),
            NutrimentsComparison(
              nutrimentsOne: productOne.product.nutriments,
              nutrimentsTwo: productTwo.product.nutriments,
            ),

            // Ingredients
            ComparisonSection(
              title: 'Ingredients',
              leftValue: productOne.product.ingredients
                      ?.map((e) => e.text ?? '')
                      .where((text) => text.isNotEmpty)
                      .toList() ??
                  [],
              rightValue: productTwo.product.ingredients
                      ?.map((e) => e.text ?? '')
                      .where((text) => text.isNotEmpty)
                      .toList() ??
                  [],
              winner: 'tie',
            ),

            // Allergens
            ComparisonSection(
              title: 'Allergens',
              leftValue: productOne.product.allergensHierarchy ?? [],
              rightValue: productTwo.product.allergensHierarchy ?? [],
              winner: 'tie',
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
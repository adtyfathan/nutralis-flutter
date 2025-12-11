import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';
import '../../../core/theme/app_theme.dart';
import 'widgets/comparison_section.dart';
import 'widgets/product_header.dart';

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
            // Comparison Details
            ComparisonSection(
              title: 'Nutri-Score',
              leftValue: (productOne.product.nutriscoreGrade ?? '?')
                  .toUpperCase(),
              rightValue: (productTwo.product.nutriscoreGrade ?? '?')
                  .toUpperCase(),
              leftColor: AppTheme.getNutriScoreColor(
                productOne.product.nutriscoreGrade,
              ),
              rightColor: AppTheme.getNutriScoreColor(
                productTwo.product.nutriscoreGrade,
              ),
              winner: winner,
            ),
            ComparisonSection(
              title: 'Product Name',
              leftValue: productOne.product.productName ?? 'Unknown',
              rightValue: productTwo.product.productName ?? 'Unknown',
              winner: 'tie',
            ),
            ComparisonSection(
              title: 'Barcode',
              leftValue: productOne.code,
              rightValue: productTwo.code,
              winner: 'tie',
            ),
          ],
        ),
      ),
    );
  }
}
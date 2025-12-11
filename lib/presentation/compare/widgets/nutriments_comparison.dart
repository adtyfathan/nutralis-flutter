import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';

class NutrimentsComparison extends StatelessWidget {
  final Nutriments? nutrimentsOne;
  final Nutriments? nutrimentsTwo;

  const NutrimentsComparison({
    required this.nutrimentsOne,
    required this.nutrimentsTwo,
  });

  Widget _buildNutrimentRow({
    required String label,
    required String valueOne,
    required String valueTwo,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valueOne,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4CAF50),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              valueTwo,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4CAF50),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNutriment(double? value, String? unit) {
    if (value == null) return 'N/A';
    return '${value.toStringAsFixed(1)} ${unit ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildNutrimentRow(
            label: 'Energy',
            valueOne: _formatNutriment(
              nutrimentsOne?.energy,
              nutrimentsOne?.energyUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.energy,
              nutrimentsTwo?.energyUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Fat',
            valueOne: _formatNutriment(
              nutrimentsOne?.fat,
              nutrimentsOne?.fatUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.fat,
              nutrimentsTwo?.fatUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Saturated Fat',
            valueOne: _formatNutriment(
              nutrimentsOne?.saturatedFat,
              nutrimentsOne?.saturatedFatUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.saturatedFat,
              nutrimentsTwo?.saturatedFatUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Carbohydrates',
            valueOne: _formatNutriment(
              nutrimentsOne?.carbohydrates,
              nutrimentsOne?.carbohydratesUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.carbohydrates,
              nutrimentsTwo?.carbohydratesUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Sugars',
            valueOne: _formatNutriment(
              nutrimentsOne?.sugars,
              nutrimentsOne?.sugarsUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.sugars,
              nutrimentsTwo?.sugarsUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Proteins',
            valueOne: _formatNutriment(
              nutrimentsOne?.proteins,
              nutrimentsOne?.proteinsUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.proteins,
              nutrimentsTwo?.proteinsUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Salt',
            valueOne: _formatNutriment(
              nutrimentsOne?.salt,
              nutrimentsOne?.saltUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.salt,
              nutrimentsTwo?.saltUnit,
            ),
          ),
          _buildNutrimentRow(
            label: 'Sodium',
            valueOne: _formatNutriment(
              nutrimentsOne?.sodium,
              nutrimentsOne?.sodiumUnit,
            ),
            valueTwo: _formatNutriment(
              nutrimentsTwo?.sodium,
              nutrimentsTwo?.sodiumUnit,
            ),
          ),
        ],
      ),
    );
  }
}
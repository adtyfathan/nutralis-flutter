import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';

class NutrientLevelsComparison extends StatelessWidget {
  final NutrientLevels? nutrientLevelsOne;
  final NutrientLevels? nutrientLevelsTwo;
  final Color Function(String?) getNutrientLevelColor;
  final String Function(String?, String?) getBetterNutrientLevel;

  const NutrientLevelsComparison({
    required this.nutrientLevelsOne,
    required this.nutrientLevelsTwo,
    required this.getNutrientLevelColor,
    required this.getBetterNutrientLevel,
  });

  Widget _buildNutrientLevelRow({
    required String label,
    required String? levelOne,
    required String? levelTwo,
  }) {
    final winner = getBetterNutrientLevel(levelOne, levelTwo);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: getNutrientLevelColor(levelOne).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: winner == 'left'
                        ? Border.all(
                            color: const Color(0xFF4CAF50),
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (levelOne ?? 'N/A').toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: getNutrientLevelColor(levelOne),
                        ),
                      ),
                      if (winner == 'left') ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: getNutrientLevelColor(levelTwo).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: winner == 'right'
                        ? Border.all(
                            color: const Color(0xFF4CAF50),
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (levelTwo ?? 'N/A').toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: getNutrientLevelColor(levelTwo),
                        ),
                      ),
                      if (winner == 'right') ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildNutrientLevelRow(
            label: 'Fat',
            levelOne: nutrientLevelsOne?.fat,
            levelTwo: nutrientLevelsTwo?.fat,
          ),
          _buildNutrientLevelRow(
            label: 'Saturated Fat',
            levelOne: nutrientLevelsOne?.saturatedFat,
            levelTwo: nutrientLevelsTwo?.saturatedFat,
          ),
          _buildNutrientLevelRow(
            label: 'Sugars',
            levelOne: nutrientLevelsOne?.sugars,
            levelTwo: nutrientLevelsTwo?.sugars,
          ),
          _buildNutrientLevelRow(
            label: 'Salt',
            levelOne: nutrientLevelsOne?.salt,
            levelTwo: nutrientLevelsTwo?.salt,
          ),
        ],
      ),
    );
  }
}
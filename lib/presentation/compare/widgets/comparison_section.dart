import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutralis_flutter/core/theme/app_theme.dart';

class ComparisonSection extends StatelessWidget {
  final String title;
  final dynamic leftValue;
  final dynamic rightValue;
  final Color? leftColor;
  final Color? rightColor;
  final String winner;

  const ComparisonSection({
    required this.title,
    required this.leftValue,
    required this.rightValue,
    this.leftColor,
    this.rightColor,
    required this.winner,
  });

  Widget _buildValue(dynamic value, Color? color) {
    if (value == null) {
      return Text(
        'N/A',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade400,
        ),
        textAlign: TextAlign.center,
      );
    }

    if (value is List) {
      if (value.isEmpty) {
        return Text(
          'No data',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade400,
          ),
          textAlign: TextAlign.center,
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...value.take(5).map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: color ?? Colors.black87,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.toString().replaceAll('en:', ''),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: color ?? Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
          if (value.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '+${value.length - 5} more',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      );
    }

    return Text(
      value.toString(),
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black87,
      ),
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: leftColor?.withOpacity(0.1) ?? Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: winner == 'left'
                          ? Border.all(
                              color: const Color(0xFF4CAF50),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Column(
                      children: [
                        _buildValue(leftValue, leftColor),
                        if (winner == 'left')
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: const Color(0xFF4CAF50),
                              ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          rightColor?.withOpacity(0.1) ?? Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: winner == 'right'
                          ? Border.all(
                              color: const Color(0xFF4CAF50),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Column(
                      children: [
                        _buildValue(rightValue, rightColor),
                        if (winner == 'right')
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: const Color(0xFF4CAF50),
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
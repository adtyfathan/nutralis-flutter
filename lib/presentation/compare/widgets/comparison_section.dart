import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComparisonSection extends StatelessWidget {
  final String title;
  final String leftValue;
  final String rightValue;
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
          // Title
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
          // Values
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Left Value
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
                        Text(
                          leftValue,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: leftColor ?? Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (winner == 'left')
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
                const SizedBox(width: 16),
                // Right Value
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
                        Text(
                          rightValue,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: rightColor ?? Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
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
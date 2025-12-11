import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';

class ProductHeader extends StatelessWidget {
  final ProductResponse product;
  final Color nutriScoreColor;
  final bool isWinner;

  const ProductHeader({
    required this.product,
    required this.nutriScoreColor,
    required this.isWinner,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: isWinner
                    ? Border.all(
                        color: const Color(0xFFFFD700),
                        width: 3,
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: product.product.imageUrl != null &&
                        product.product.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: product.product.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey.shade400,
                          size: 40,
                        ),
                      )
                    : Icon(
                        Icons.fastfood_outlined,
                        color: Colors.grey.shade400,
                        size: 40,
                      ),
              ),
            ),
            if (isWinner)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFD700),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: nutriScoreColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (product.product.nutriscoreGrade ?? '?').toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.product.productName ?? 'Unknown',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
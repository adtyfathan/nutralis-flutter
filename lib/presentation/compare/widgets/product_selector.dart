import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';

class ProductSelector extends StatelessWidget {
  final String title;
  final ProductResponse? product;
  final Color nutriScoreColor;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const ProductSelector({
    required this.title,
    required this.product,
    required this.nutriScoreColor,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final selectedProduct = product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: product == null
                  ? Colors.grey.shade300
                  : const Color(0xFF4CAF50),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: selectedProduct == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey.shade400,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Select Product',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      )
                    : _buildSelectedProduct(selectedProduct),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedProduct(ProductResponse product) {
    return Row(
      children: [
        // Product Image
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade400,
                        size: 30,
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.fastfood_outlined,
                      color: Colors.grey.shade400,
                      size: 30,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        // Product Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.product.productName ?? 'Unknown Product',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: nutriScoreColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Nutri-Score: ${(product.product.nutriscoreGrade ?? '?').toUpperCase()}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: nutriScoreColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Clear Button
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey.shade600,
          ),
          onPressed: onClear,
        ),
      ],
    );
  }
}
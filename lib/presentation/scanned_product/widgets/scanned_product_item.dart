import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../data/models/scanned_product_model.dart';
import '../../../core/theme/app_theme.dart';

class ScannedProductItem extends StatelessWidget {
  final ScannedProductModel scannedProduct;
  final Function(String) onCardClick;
  final VoidCallback? onDelete;

  const ScannedProductItem({
    super.key,
    required this.scannedProduct,
    required this.onCardClick,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final gradeColor =
        {
          "a": AppTheme.gradeA,
          "b": AppTheme.gradeB,
          "c": AppTheme.gradeC,
          "d": AppTheme.gradeD,
          "e": AppTheme.gradeE,
        }[scannedProduct.nutriscoreGrade?.toLowerCase()] ??
        Colors.grey;

    return GestureDetector(
      onTap: () => onCardClick(scannedProduct.code),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: scannedProduct.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: scannedProduct.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.fastfood,
                            size: 40,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scannedProduct.productName ?? 'Unknown Product',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E2E),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (scannedProduct.productType != null)
                      Text(
                        scannedProduct.productType!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat(
                        'MMM dd, yyyy HH:mm',
                      ).format(scannedProduct.scannedAt),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),

              // Nutri-Score Badge
              Column(
                children: [
                  if (scannedProduct.nutriscoreGrade != null)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: gradeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          scannedProduct.nutriscoreGrade!.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  if (onDelete != null) ...[
                    const SizedBox(height: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

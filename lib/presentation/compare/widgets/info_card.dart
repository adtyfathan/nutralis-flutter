import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';

class InfoCardComparison extends StatelessWidget {
  final ProductResponse productOne;
  final ProductResponse productTwo;

  const InfoCardComparison({
    required this.productOne,
    required this.productTwo,
  });

  Widget _buildInfoCard(ProductResponse product, bool isLeft) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            icon: Icons.qr_code,
            label: 'Code',
            value: product.code,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.shopping_bag_outlined,
            label: 'Product',
            value: product.product.productName ?? 'N/A',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.restaurant_menu,
            label: 'Type',
            value: product.product.productType ?? 'N/A',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.inventory_2_outlined,
            label: 'Packaging',
            value: product.product.packaging ?? 'N/A',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.public,
            label: 'Countries',
            value: product.product.countries ?? 'N/A',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildInfoCard(productOne, true)),
          const SizedBox(width: 12),
          Expanded(child: _buildInfoCard(productTwo, false)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF4CAF50)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
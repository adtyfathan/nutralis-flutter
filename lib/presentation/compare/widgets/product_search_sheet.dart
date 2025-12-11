import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';
import '../../../data/datasources/product_datasource.dart';


class ProductSearchSheet extends StatefulWidget {
  final String title;

  const ProductSearchSheet({
    super.key,
    required this.title,
  });

  @override
  State<ProductSearchSheet> createState() => _ProductSearchSheetState();
}

class _ProductSearchSheetState extends State<ProductSearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductResponse> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Call search API
      final results = await GetIt.instance<ProductDataSource>().searchProducts(
        query: _searchController.text.trim(),
      );

      // Demo data
      // await Future.delayed(const Duration(milliseconds: 500));
      // final results = _getDemoResults();

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<ProductResponse> _getDemoResults() {
    return [
      ProductResponse(
        code: '1',
        product: Product(
          productName: 'Coca-Cola Original 330ml',
          imageUrl: 'https://via.placeholder.com/80',
          nutriscoreGrade: 'e',
        ),
      ),
      ProductResponse(
        code: '2',
        product: Product(
          productName: 'Pepsi Cola 330ml',
          imageUrl: 'https://via.placeholder.com/80',
          nutriscoreGrade: 'e',
        ),
      ),
      ProductResponse(
        code: '3',
        product: Product(
          productName: 'Orange Juice 100% Pure',
          imageUrl: 'https://via.placeholder.com/80',
          nutriscoreGrade: 'a',
        ),
      ),
    ];
  }

  Color _getNutriScoreColor(String? grade) {
    if (grade == null) return Colors.grey;
    switch (grade.toLowerCase()) {
      case 'a':
        return const Color(0xFF4CAF50);
      case 'b':
        return const Color(0xFF8BC34A);
      case 'c':
        return const Color(0xFFFFEB3B);
      case 'd':
        return const Color(0xFFFFA726);
      case 'e':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          widget.title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _performSearch(),
              style: GoogleFonts.inter(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Results
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? Center(
                        child: Text(
                          'Search for products',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final product = _searchResults[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pop(product);
                              },
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: product.product.imageUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: product.product.imageUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.fastfood_outlined,
                                        color: Colors.grey.shade400),
                              ),
                              title: Text(
                                product.product.productName ??
                                    'Unknown Product',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _getNutriScoreColor(
                                      product.product.nutriscoreGrade),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    (product.product.nutriscoreGrade ?? '?')
                                        .toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
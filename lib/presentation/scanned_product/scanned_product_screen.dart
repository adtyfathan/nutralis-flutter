import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutralis_flutter/presentation/scanned_product/bloc/scanned_product_bloc.dart';
import 'package:nutralis_flutter/presentation/scanned_product/bloc/scanned_product_event.dart';
import 'package:nutralis_flutter/presentation/scanned_product/bloc/scanned_product_state.dart';
import 'package:nutralis_flutter/presentation/scanned_product/widgets/scanned_product_item.dart';
import '../../../core/theme/app_theme.dart';

class ScannedProductScreen extends StatefulWidget {
  final String userId;

  const ScannedProductScreen({super.key, required this.userId});

  @override
  State<ScannedProductScreen> createState() => _ScannedProductScreenState();
}

class _ScannedProductScreenState extends State<ScannedProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScannedProductBloc>().add(LoadScannedProducts(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: const Text("Scanned Products"),
      ),
      body: BlocBuilder<ScannedProductBloc, ScannedProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryGreen),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_basket_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "There's no product yet",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ScannedProductItem(
                scannedProduct: product,
                onCardClick: (code) {
                  Navigator.pushNamed(
                    context,
                    '/product-result',
                    arguments: code,
                  );
                },
                onDelete: () {
                  if (product.id != null) {
                    context.read<ScannedProductBloc>().add(
                      DeleteScannedProduct(product.id!),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

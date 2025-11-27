import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutralis_flutter/presentation/auth/bloc/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../../../config/routes.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final userId = authState.user?.uid ?? "";

    return Scaffold(
      body: Stack(
        children: [
            MobileScanner(
            onDetect: (capture) async {
              if (isProcessing) return;
              if (capture.barcodes.isEmpty) return;

              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue ?? barcode.displayValue;

              if (code == null || code.isEmpty) return;

              setState(() => isProcessing = true);

              final bloc = context.read<ProductBloc>();
              final repo = bloc.productRepository;

              final product = await repo.getProductByBarcode(code);

              if (!mounted) return;

              bloc.add(LoadProductDetails(code)); 

              bloc.add(SaveScannedProduct(userId: userId, barcode: code));

              Navigator.pushNamed(
                context,
                AppRoutes.productResult,
                arguments: code,
              ).then((_) {
                setState(() => isProcessing = false);
              });
            }

          ),


          // Overlay
          Center(
            child: Container(
              width: 250,
              height: 130,
              decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primaryGreen, width: 3),
              ),
            ),
          ),

          // Back button
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

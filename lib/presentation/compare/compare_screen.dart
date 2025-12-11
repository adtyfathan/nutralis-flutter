import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/product_model.dart';
import 'bloc/compare_bloc.dart';
import 'bloc/compare_event.dart';
import 'bloc/compare_state.dart';
import 'widgets/product_selector.dart';
import 'widgets/product_search_sheet.dart';
import '../../../core/theme/app_theme.dart';
import 'compare_result_screen.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompareBloc(),
      child: const CompareView(),
    );
  }
}

class CompareView extends StatelessWidget {
  const CompareView({super.key});

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
          'Compare Products',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CompareBloc, CompareState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Product 1 Selection
                      ProductSelector(
                        title: 'Product 1',
                        product: state.productOne,
                        nutriScoreColor: AppTheme.getNutriScoreColor(
                          state.productOne?.product.nutriscoreGrade,
                        ),
                        onTap: () async {
                          final result = await Navigator.push<ProductResponse>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductSearchSheet(
                                title: 'Select Product 1',
                              ),
                            ),
                          );
                          if (result != null && context.mounted) {
                            context.read<CompareBloc>().add(
                                  SelectProductOneEvent(result),
                                );
                          }
                        },
                        onClear: () {
                          context.read<CompareBloc>().add(
                                const ClearProductOneEvent(),
                              );
                        },
                      ),
                      const SizedBox(height: 24),
                      // VS Icon
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'VS',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Product 2 Selection
                      ProductSelector(
                        title: 'Product 2',
                        product: state.productTwo,
                        nutriScoreColor: AppTheme.getNutriScoreColor(
                          state.productTwo?.product.nutriscoreGrade,
                        ),
                        onTap: () async {
                          final result = await Navigator.push<ProductResponse>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductSearchSheet(
                                title: 'Select Product 2',
                              ),
                            ),
                          );
                          if (result != null && context.mounted) {
                            context.read<CompareBloc>().add(
                                  SelectProductTwoEvent(result),
                                );
                          }
                        },
                        onClear: () {
                          context.read<CompareBloc>().add(
                                const ClearProductTwoEvent(),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Compare Button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state.canCompare
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompareResultPage(
                                    productOne: state.productOne!,
                                    productTwo: state.productTwo!,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        disabledBackgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.grey.shade500,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'COMPARE',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
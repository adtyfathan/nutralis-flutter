import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/product_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc({required this.productRepository}) : super(const HomeState()) {
    on<LoadHomeProducts>(_onLoadHomeProducts);
    on<ChangeCategoryEvent>(_onChangeCategoryEvent);
  }

  Future<void> _onLoadHomeProducts(
    LoadHomeProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final products = await productRepository.getProductsByCategory(
        category: event.category,
        page: 1,
      );
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onChangeCategoryEvent(
    ChangeCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategory: event.category,
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final products = await productRepository.getProductsByCategory(
        category: event.category,
        page: 1,
      );
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}

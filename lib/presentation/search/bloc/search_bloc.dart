import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/product_datasource.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'dart:async';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductDataSource productDataSource;
  Timer? _debounce;

  SearchBloc({required this.productDataSource}) : super(const SearchInitial()) {
    on<SearchProductsEvent>(_onSearchProducts);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());

    try {
      final products = await productDataSource.searchProducts(
        query: event.query.trim(),
        page: event.page,
      );

      if (products.isEmpty) {
        emit(SearchEmpty(event.query));
      } else {
        emit(SearchSuccess(products: products, query: event.query));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<SearchState> emit,
  ) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(SearchProductsEvent(query: event.query));
    });
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
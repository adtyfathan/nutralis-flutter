import 'package:flutter_bloc/flutter_bloc.dart';
import 'compare_event.dart';
import 'compare_state.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  CompareBloc() : super(const CompareState()) {
    on<SelectProductOneEvent>(_onSelectProductOne);
    on<SelectProductTwoEvent>(_onSelectProductTwo);
    on<ClearProductOneEvent>(_onClearProductOne);
    on<ClearProductTwoEvent>(_onClearProductTwo);
    on<ResetCompareEvent>(_onResetCompare);
  }

  void _onSelectProductOne(
    SelectProductOneEvent event,
    Emitter<CompareState> emit,
  ) {
    emit(state.copyWith(productOne: event.product));
  }

  void _onSelectProductTwo(
    SelectProductTwoEvent event,
    Emitter<CompareState> emit,
  ) {
    emit(state.copyWith(productTwo: event.product));
  }

  void _onClearProductOne(
    ClearProductOneEvent event,
    Emitter<CompareState> emit,
  ) {
    emit(state.copyWith(clearProductOne: true));
  }

  void _onClearProductTwo(
    ClearProductTwoEvent event,
    Emitter<CompareState> emit,
  ) {
    emit(state.copyWith(clearProductTwo: true));
  }

  void _onResetCompare(
    ResetCompareEvent event,
    Emitter<CompareState> emit,
  ) {
    emit(const CompareState());
  }
}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/feeltoday.dart';
import '../repositories/HomeRepository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  final HomeRepository repository = HomeRepository();

  HomeCubit() : super(const HomeState(
    isFeelingLoading: false,
    isOccasionLoading: false,
    feelings: [],
    occasionsReady: [],
    feelingError: null,
  ));

  Future<void> loadTodayFeeling({String? type}) async {
    emit(state.copyWith(isFeelingLoading: true, feelingError: null));

    final response = await repository.getTodayFeeling(type ?? "");

    if (response.isSuccess && response.data != null) {
      final list = response.data!;

      if (list.isEmpty) {
        emit(state.copyWith(
          isFeelingLoading: false,
          feelingError: response.error?.message ?? "Something went wrong",
        ));
        return;
      }

      emit(state.copyWith(
        isFeelingLoading: false,
        feelings: list,
      ));
    } else {
      emit(state.copyWith(
        isFeelingLoading: false,
        feelingError: response.error?.message ?? "Something went wrong",
      ));
    }
  }
  Future<void> loadOccasionForReady({String? type}) async {
    emit(state.copyWith(isOccasionLoading: true, feelingError: null));

    final response = await repository.getTodayFeeling(type ?? "");

    if (response.isSuccess && response.data != null) {
      final list = response.data!;

      if (list.isEmpty) {
        emit(state.copyWith(
          isOccasionLoading: false,
          occasionError: response.error?.message ?? "Something went wrong",
        ));
        return;
      }
      emit(state.copyWith(
        isOccasionLoading: false,
        occasionsReady: list,
      ));
    } else {
      emit(state.copyWith(
        isOccasionLoading: false,
        occasionError: response.error?.message ?? "Something went wrong",
      ));
    }
  }
}

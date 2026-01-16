part of 'home_cubit.dart';

// sealed class HomeState extends Equatable {
//   const HomeState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// final class HomeInitial extends HomeState {}
//
// final class FeelingLoading extends HomeState {}
//
// final class FeelingLoaded extends HomeState {
//   final List<FeelToday> feelings;
//
//   const FeelingLoaded(this.feelings);
//
//   @override
//   List<Object?> get props => [feelings];
// }
//
// final class FeelingEmpty extends HomeState {
//   final String message;
//
//   const FeelingEmpty(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// final class FeelingError extends HomeState {
//   final String message;
//
//   const FeelingError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// final class OccasionLoading extends HomeState {}

// final class OccasionReadyLoaded extends HomeState {
//   final List<FeelToday> occasionsReady;
//
//   const OccasionReadyLoaded(this.occasionsReady);
//
//   @override
//   List<Object?> get props => [occasionsReady];
// }



class HomeState {
  final bool isFeelingLoading;
  final bool isOccasionLoading;

  final List<FeelToday> feelings;
  final List<FeelToday> occasionsReady;

  final String? feelingError;
  final String? occasionError;

  const HomeState({
    this.isFeelingLoading = false,
    this.isOccasionLoading = false,
    this.feelings = const [],
    this.occasionsReady = const [],
    this.feelingError,
    this.occasionError,
  });

  HomeState copyWith({
    bool? isFeelingLoading,
    bool? isOccasionLoading,
    List<FeelToday>? feelings,
    List<FeelToday>? occasionsReady,
    String? feelingError,
    String? occasionError,
  }) {
    return HomeState(
      isFeelingLoading: isFeelingLoading ?? this.isFeelingLoading,
      isOccasionLoading: isOccasionLoading ?? this.isOccasionLoading,
      feelings: feelings ?? this.feelings,
      occasionsReady: occasionsReady ?? this.occasionsReady,
      feelingError: feelingError,
      occasionError: occasionError,
    );
  }
}

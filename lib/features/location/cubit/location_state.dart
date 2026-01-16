part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();
}

final class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

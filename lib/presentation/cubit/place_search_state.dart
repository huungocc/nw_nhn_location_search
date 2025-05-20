import 'package:equatable/equatable.dart';

import '../../domain/entities/place.dart';

abstract class PlaceSearchState extends Equatable {
  const PlaceSearchState();

  @override
  List<Object?> get props => [];
}

class PlaceSearchInitial extends PlaceSearchState {}

class PlaceSearchLoading extends PlaceSearchState {}

class PlaceSearchLoaded extends PlaceSearchState {
  final List<Place> places;
  final String searchQuery;

  const PlaceSearchLoaded({
    required this.places,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [places, searchQuery];
}

class PlaceSearchError extends PlaceSearchState {
  final String message;

  const PlaceSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
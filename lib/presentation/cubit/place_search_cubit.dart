import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/search_places.dart';
import 'place_search_state.dart';

class PlaceSearchCubit extends Cubit<PlaceSearchState> {
  final SearchPlaces searchPlaces;

  Timer? _debounce;

  PlaceSearchCubit({required this.searchPlaces}) : super(PlaceSearchInitial());

  Future<void> searchPlace(String query) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    if (query.isEmpty) {
      emit(PlaceSearchInitial());
      return;
    }

    _debounce = Timer(Duration(seconds: 1), () async {
      emit(PlaceSearchLoading());

      final result = await searchPlaces(query);

      result.fold(
            (failure) => emit(PlaceSearchError(message: failure.message)),
            (places) => emit(PlaceSearchLoaded(places: places, searchQuery: query)),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
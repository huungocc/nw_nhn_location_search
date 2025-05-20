import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class SearchPlaces {
  final PlaceRepository repository;

  SearchPlaces(this.repository);

  Future<Either<Failure, List<Place>>> call(String query) async {
    return await repository.searchPlaces(query);
  }
}
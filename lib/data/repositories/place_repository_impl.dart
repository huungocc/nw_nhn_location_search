import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/place_repository.dart';
import '../datasources/place_remote_data_source.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;

  PlaceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Place>>> searchPlaces(String query) async {
    try {
      final remotePlaces = await remoteDataSource.searchPlaces(query);
      return Right(remotePlaces);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
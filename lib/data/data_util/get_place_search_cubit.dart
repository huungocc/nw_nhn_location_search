import 'package:http/http.dart' as http;
import '../../data/datasources/place_remote_data_source.dart';
import '../../data/repositories/place_repository_impl.dart';
import '../../domain/repositories/place_repository.dart';
import '../../domain/usecases/search_places.dart';
import '../../presentation/cubit/place_search_cubit.dart';

PlaceSearchCubit getPlaceSearchCubit() {
  // Dependencies
  final http.Client httpClient = http.Client();

  // Data sources
  final PlaceRemoteDataSource remoteDataSource = PlaceRemoteDataSourceImpl(
    client: httpClient,
  );

  // Repositories
  final PlaceRepository repository = PlaceRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );

  // Use cases
  final SearchPlaces searchPlaces = SearchPlaces(repository);

  // Cubit
  return PlaceSearchCubit(searchPlaces: searchPlaces);
}
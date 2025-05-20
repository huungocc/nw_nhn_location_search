import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/failures.dart';
import '../../core/util/constants.dart';
import '../models/place_model.dart';

abstract class PlaceRemoteDataSource {
  Future<List<PlaceModel>> searchPlaces(String query);
}

class PlaceRemoteDataSourceImpl implements PlaceRemoteDataSource {
  final http.Client client;

  PlaceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PlaceModel>> searchPlaces(String query) async {
    final url = Uri.parse(
        '${Constants.locationIqSearchBaseUrl}?key=${Constants.locationIqApiKey}&q=$query&format=json');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> decodedJson = json.decode(response.body);
        return decodedJson.map((item) => PlaceModel.fromJson(item)).toList();
      } else {
        throw ServerFailure('Failed to fetch places: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerFailure('Failed to fetch places: ${e.toString()}');
    }
  }
}
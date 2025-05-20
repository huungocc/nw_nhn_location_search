import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    required String title,
    required String id,
    required double latitude,
    required double longitude,
    required String address,
  }) : super(
    title: title,
    id: id,
    latitude: latitude,
    longitude: longitude,
    address: address,
  );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      title: json['display_name']?.split(',')?.first ?? '',
      id: json['place_id'] ?? '',
      latitude: double.tryParse(json['lat'] ?? '0') ?? 0.0,
      longitude: double.tryParse(json['lon'] ?? '0') ?? 0.0,
      address: json['display_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'display_name': address,
      'place_id': id,
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    };
  }
}
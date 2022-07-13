import 'package:dio/dio.dart';
import 'package:google_map/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static String baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  final Dio dio;

  DirectionsRepository(this.dio);

  Future getDirections(
      {required LatLng origion, required LatLng destination}) async {
    final response = await dio.get(baseUrl, queryParameters: {
      "origin": "${origion.latitude} , ${origion.longitude}",
      "destination": "${destination.latitude} , ${destination.longitude}",
      "key": Global.apiKey
    });
    print(response.data);
    return response.data;

    /*if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;*/
  }
}

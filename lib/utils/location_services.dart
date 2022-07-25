import 'dart:convert';

import 'package:google_map/models/get_place_id_model.dart';
import 'package:google_map/utils/utils.dart';
import 'package:http/http.dart' as http;

class LocationServices {
  final String key = "AIzaSyDdUDjPM66c_l5qgkWaxb3psh1b14wQ7xM";
  GetPlaceId? placeIdData;

  Future<List<GetPlaceId>> getLocation(String input) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&inputtype=textquery"));
    print(response.body);
    var data = jsonDecode(response.body);
    getJson(data);
    if (response.statusCode == 200) {
      // placeIdData = L>;
      return List<GetPlaceId>.from(
          data['predictions'].map((e) => GetPlaceId.fromJson(e)));
    }
    return [];
  }

  Future<Map<String, dynamic>> getPlaceById(String placeId) async {
    final respo = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key"));
    print(respo.body);
    var data = jsonDecode(respo.body);
    print(data);

    return data;
  }
}

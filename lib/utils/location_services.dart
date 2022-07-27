import 'dart:convert';

import 'package:google_map/models/get_location_model.dart';
import 'package:google_map/models/get_place_by_id.dart';
import 'package:google_map/utils/utils.dart';
import 'package:http/http.dart' as http;

class LocationServices {
  final String key = "AIzaSyDdUDjPM66c_l5qgkWaxb3psh1b14wQ7xM";
  GetLocation? placeIdData;

  Future<List<GetLocation>> getLocation(String input) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&inputtype=textquery"));
    print(response.body);
    var data = jsonDecode(response.body);
    getJson(data);
    if (response.statusCode == 200) {
      // placeIdData = L>;
      return List<GetLocation>.from(
          data['predictions'].map((e) => GetLocation.fromJson(e)));
    }
    return [];
  }

  Future<GetPlaceById?> getPlaceById(String placeId) async {
    final respo = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key"));
    print((respo.body));
    if (respo != null) {
      var data = jsonDecode(respo.body);
      if (data['status'] == 'OK') {
        return GetPlaceById.fromJson(data['result']);
      }
    }
    return null;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationServices {
  final String key = "AIzaSyA3srhzXpBgyL2XyDMlwr0HC4guF2sQWGY";

  Future<String> getPlace(String input) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&inputtype=textquery"));
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    return "";
  }
}

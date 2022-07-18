import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DirectionsRepository {
  static String baseUrl =
      "https://landingpage.innoventixsolutions.com/wp-json/wp/v2/pages/14";

  final Dio dio;

  DirectionsRepository(this.dio);

  Future getDirections() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      "authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsIm5hbWUiOiJpbm5vdmUiLCJpYXQiOjE2NTc2OTkxNTYsImV4cCI6MTgxNTM3OTE1Nn0.75V2CGaB1cS7VXkloyYaNqAfDJaHC8N9m864vy9TSLo"
    });
    final parsedata = jsonDecode(response.body);
    print(parsedata);
    return null;

    /*if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }


    return null;*/
  }
}

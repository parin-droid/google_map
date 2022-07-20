import 'package:dio/dio.dart';

class DirectionsRepository {
  static String baseUrl =
      "https://landingpage.innoventixsolutions.com/wp-json/wp/v2/pages/14";

  final Dio dio;

  DirectionsRepository(this.dio);
}

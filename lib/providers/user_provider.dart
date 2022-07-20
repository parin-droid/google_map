import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  static final baseUrl =
      "http://traffic-signal.ondemandservicesappinflutter.online/api/";

  Future<bool> createUser(
      {required String name,
      required String email,
      required String password,
      required String type}) async {
    var response = await http.post(Uri.parse(baseUrl + "register"), body: {
      "name": name,
      "email": email,
      "password": password,
      "type": type,
    });
    var parseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (parseData['status'] == 200) {
        print(parseData['message']);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

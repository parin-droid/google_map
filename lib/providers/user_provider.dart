import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_map/models/user_model.dart';
import 'package:google_map/utils/utils.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  static final baseUrl =
      "http://traffic-signal.ondemandservicesappinflutter.online/api/";

  final String key = "AIzaSyBdkKb83W3kygikgmWFqj3F0kE15EkYx_I";

  Future<bool> createUser(
      {required String name,
      required String email,
      required String password,
      required String type}) async {
    loading(show: true);
    var response = await http.post(Uri.parse(baseUrl + "new_register"),
        headers: {
          'Charset': 'utf-8'
        },
        body: {
          "name": name,
          "email": email,
          "password": password,
          "type": type
        });
    print(response.body);
    //String data = response.body.toString();
    var parseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // var parseData = jsonDecode(response.body);
      loading(show: false);
      if (parseData['status'] == 200) {
        print(parseData['message']);
        return true;
      } else {
        loading(show: false);
        return false;
      }
    }
    loading(show: false);
    return false;
  }

  Future<UserModel?> userLogin(
      {required String email, required String password}) async {
    loading(show: true);
    final data = {
      "email": email,
      "password": password,
    };
    getJson(data);
    print("URL: ${baseUrl}login");
    final response = await http
        .post(Uri.parse(baseUrl + "login"), body: jsonEncode(data), headers: {
      "content-type": "application/json",
    });
    var parseData = jsonDecode(response.body);
    print(parseData);
    print(response.statusCode);
    final UserModel userModel;
    if (response.statusCode == 201) {
      loading(show: false);
      userModel = UserModel.fromJson(parseData['data']);
      return userModel;
    } else if (response.statusCode == 404) {
      loading(show: false);
      Fluttertoast.showToast(msg: "Account does not exists");
    } else {
      loading(show: false);
      return null;
    }
  }
}

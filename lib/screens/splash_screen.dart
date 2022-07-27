import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_map/models/user_model.dart';
import 'package:google_map/providers/user_provider.dart';
import 'package:google_map/screens/admin_screens/main_screen.dart';
import 'package:google_map/screens/login_screen.dart';
import 'package:google_map/screens/user_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  SharedPreferences? prefs;

  navigationPage() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs!.get("loadingData"));
    String? details = prefs!.getString("loadingData");

    if (details == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print(jsonDecode(details));
      var parseData = jsonDecode(details);
      final userData = Provider.of<User>(context, listen: false);
      userData.userModel = UserModel.fromJson(parseData['data']);
      print(userData.userModel!.type);
      if (userData.userModel!.type == "admin") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHomeScreen()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
          "assets/images/splash.jpeg",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map/screens/login_screen.dart';

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

  navigationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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

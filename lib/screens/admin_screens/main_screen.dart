import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_map/screens/admin_screens/admin_profile.dart';
import 'package:google_map/screens/admin_screens/home_screen.dart';
import 'package:google_map/screens/admin_screens/signal_list.dart';
import 'package:google_map/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> _pages = [HomeScreen(), AdminProfile(), SignalList()];
  Future<bool> popping() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Alert"),
                  content: const Text("Are you want Sign Out?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        child: Text("Yes")),
                  ],
                ))) ??
        false;
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* final CameraPosition _kGooglePlex =
        CameraPosition(target: LatLng(latlong, longlat), zoom: 7.4746);*/
    return WillPopScope(
      onWillPop: popping,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              currentIndex: selectedIndex,
              onTap: onTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home"
                        ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Signal List"
                        ""),
              ]),
          body: _pages.elementAt(selectedIndex),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Future<bool> popping() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Alert"),
                  content: Text("Are you want Sign Out?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Yes")),
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popping,
      child: Scaffold(
        body: Center(
          child: Text("User"),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignalList extends StatefulWidget {
  const SignalList({Key? key}) : super(key: key);

  @override
  State<SignalList> createState() => _SignalListState();
}

class _SignalListState extends State<SignalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            centerTitle: true,
            title: Text("Signal List"),
            automaticallyImplyLeading: false,
          )
        ],
      ),
    );
  }
}

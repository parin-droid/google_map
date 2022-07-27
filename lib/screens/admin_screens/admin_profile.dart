import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  bool isVisible = false;
  UserModel? _userModel;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? details = pref.getString("loadingData");
    print(jsonDecode(details!));
    var parseData = jsonDecode(details);
    if (mounted) {
      _userModel = UserModel.fromJson(parseData["data"]);
    }
  }

  getProfileData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getData();
      if (_userModel != null) {
        setState(() {
          name.text = _userModel!.name.toString();
          email.text = _userModel!.email.toString();
        });
      }
    });
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            centerTitle: true,
            title: Text("Profile"),
            automaticallyImplyLeading: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: "Enter Your Name",
                        contentPadding: const EdgeInsets.only(left: 20),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      RegExp rex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value!.isEmpty) {
                        return "Email Required";
                      } else if (!rex.hasMatch(value)) {
                        return "Enter Valid Email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.alternate_email),
                        hintText: "Enter Your Email",
                        contentPadding: const EdgeInsets.only(left: 20),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  /* TextFormField(
                    controller: password,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Password Required";
                      } else if (val.length < 6) {
                        return "Password more than 6 character";
                      }
                      return null;
                    },
                    obscureText: isVisible == true ? false : true,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "Enter Your Password",
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(isVisible == true
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        contentPadding: const EdgeInsets.only(left: 20),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),*/
                  /*Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20),
              width:
              MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey),
                  borderRadius:
                  BorderRadius.circular(30)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: const Text(
                        "Please Select Option"),
                    items: dropValue
                        .map(
                            (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                        .toList(),
                    value: selectedValues,
                    onChanged: (value) {
                      setState(() {
                        selectedValues =
                            value.toString();

                        debugPrint(selectedValues!
                            .toLowerCase()
                            .toString());
                      });
                    }),
              ),
            ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: const Text("Update")),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_map/models/user_model.dart';
import 'package:google_map/providers/user_provider.dart';
import 'package:google_map/screens/home_screen.dart';
import 'package:google_map/screens/user_home_screen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;
  List dropValue = ['User', 'Admin'];
  String? selectedValue;
  String? selectedValues;
  UserModel? model;
  TabController? tabController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController lEmail = TextEditingController();
  TextEditingController lPassword = TextEditingController();
  TextEditingController sName = TextEditingController();
  TextEditingController sEmail = TextEditingController();
  TextEditingController sPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final sprovider = context.read<User>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                bottom: 300,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/splash.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black45,
              ),
              Positioned(
                top: 300,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Text(
                              "Traffic Notify",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TabBar(
                              controller: tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Colors.blueGrey,
                              tabs: [
                                Tab(
                                  text: "Login",
                                ),
                                Tab(
                                  text: "Sign Up",
                                )
                              ],
                            ),
                            Expanded(
                                child: TabBarView(
                              controller: tabController,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: lEmail,
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
                                              prefixIcon:
                                                  Icon(Icons.alternate_email),
                                              hintText: "Enter Your Email",
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: lPassword,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Password Required";
                                            } else if (val.length < 6) {
                                              return "Password more than 6 character";
                                            } else {}
                                          },
                                          obscureText:
                                              isVisible == true ? false : true,
                                          decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.lock_outline),
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
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(150, 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                final res =
                                                    await sprovider.userLogin(
                                                        email: lEmail.text,
                                                        password:
                                                            lPassword.text);
                                                setState(() {
                                                  model = res;
                                                });
                                                if (model!.type == "user") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Login user Successfully");
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserHomeScreen()));
                                                } else if (model!.type ==
                                                    "admin") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Login Admin Successfully");
                                                  await Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()));
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "user does not exists");
                                                }
                                              }
                                            },
                                            child: Text("Login")),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Create An Account ?",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                tabController!.animateTo(1);
                                              },
                                              child: Text("Sign UP",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: sName,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintText: "Enter Your Name",
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: sEmail,
                                          decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.alternate_email),
                                              hintText: "Enter Your Email",
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: sPassword,
                                          obscureText:
                                              isVisible == true ? false : true,
                                          decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.lock_outline),
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
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
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
                                                hint: Text(
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

                                                    print(selectedValues!
                                                        .toLowerCase()
                                                        .toString());
                                                  });
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(150, 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () async {
                                              print(sName.text);
                                              print(sEmail.text);
                                              print(sPassword.text);
                                              print(selectedValues!
                                                  .toLowerCase()
                                                  .toString());
                                              final res =
                                                  await sprovider.createUser(
                                                      name: sName.text,
                                                      email: sEmail.text,
                                                      password: sPassword.text,
                                                      type: selectedValues!
                                                          .toLowerCase()
                                                          .toString());
                                              if (res) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Account Created Successfully");
                                                tabController!.animateTo(0);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Something Wrong");
                                              }
                                            },
                                            child: Text("Sign Up")),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

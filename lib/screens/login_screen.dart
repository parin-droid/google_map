import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 30.0,
                  ),
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
                          children: [
                            Container(
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {}, child: Text("Login"))
                                  ],
                                ),
                              ),
                            ),
                            Container(color: Colors.orange)
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

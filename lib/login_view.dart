import 'package:fantasy_football/controller/internet_async.dart';

import 'package:fantasy_football/model/user.dart';
import 'package:fantasy_football/register_view.dart';
import 'package:flutter/material.dart';




class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String username = "", password = "";

  Widget signIn = Text("Sign In");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
          body: Scrollbar(
              child: SingleChildScrollView(
                  child: Builder(
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Form(
                        autovalidate: true,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            Text("Fantasy League TN"),
                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            Image.asset("assets/tn.png", height: 100.0, alignment: Alignment.center,),
                            new TextField(
                              decoration: new InputDecoration(
                                  hintText: "Username", fillColor: Colors.white
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (String value) {username = value;},
                            ),
                            new TextField(
                              decoration: new InputDecoration(
                                  hintText: "Password", fillColor: Colors.white),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              onChanged: (String value) {password = value;},
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),

                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            new MaterialButton(
                                height: 50.0,
                                minWidth: 200.0,
                                color: Colors.redAccent,
                                splashColor: Colors.teal,
                                textColor: Colors.white,
                                child: signIn,
                                onPressed: () {
                                  setState(() {
                                    signIn = FutureBuilder<User>(

                                      future: InternetAsync().fetchUser(context, username, password),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return Text("Sign In");
                                        }

                                        // By default, show a loading spinner
                                        return CircularProgressIndicator();
                                      },
                                    );
                                  });
                                }
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new MaterialButton(
                              height: 50.0,
                              minWidth: 200.0,
                              color: Colors.redAccent,
                              splashColor: Colors.teal,
                              textColor: Colors.white,
                              child: Text("Register"),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return RegisterView();}));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              )
          )
      ),
    );
  }
}


import 'package:fantasy_football/login_view.dart';
import 'package:flutter/material.dart';




/// The function that is called when main.dart is run.
void main() {
  runApp(MyApp());
}

/// This widget is the root of our application.
///
/// The first screen we see is a list [Categories], each of which
/// has a list of [Unit]s.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fantasy Football',
      home: LoginView(),
    );
  }
}
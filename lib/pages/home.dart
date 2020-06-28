import 'package:corona/pages/initial.dart';
import 'package:corona/widget/sidebar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Initial(),
          Sidebar(),
        ],
      ),
    );
  }
}

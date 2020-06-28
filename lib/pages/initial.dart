import 'package:corona/nav/blocnav.dart';
import 'package:flutter/material.dart';
class Initial extends StatefulWidget with NavigationState {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'first page',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
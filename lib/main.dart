import 'package:corona/data.dart';
import 'package:corona/pages/home.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Home(),
      theme: ThemeData(
        primaryColor: primaryBlack,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


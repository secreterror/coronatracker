import 'dart:async';

import 'package:corona/data.dart';
import 'package:corona/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 4),()=>Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context)=>Home()
    ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: Center(
        child: SvgPicture.asset('assets/images/sport.svg'),
      ),

    );
  }
}

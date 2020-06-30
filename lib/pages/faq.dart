import 'package:corona/nav/blocnav.dart';
import 'package:flutter/material.dart';
import 'package:corona/widget/chart.dart';
class Faq extends StatelessWidget with NavigationState{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Container(child: WeeklyChart())))
    );
  }
}

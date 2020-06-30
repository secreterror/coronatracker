import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class WeeklyChart extends StatelessWidget {
  final List<double> barChartData;
  WeeklyChart({this.barChartData});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(BarChartData(
          barGroups: getBarGroups(barChartData),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false
            )
          )

        )),
      ),
    );
  }
}

getBarGroups(barChartData){

  List<BarChartGroupData> barChartGroups=[];
  barChartData.asMap().forEach((key, value)=>barChartGroups.add(
    BarChartGroupData(
      x:key,
      barRods:[
        BarChartRodData(
          y: value,
          width: 16,
          color: key==4?Colors.green:Colors.grey

        )
        ]
    )
  ));
  return barChartGroups;
}

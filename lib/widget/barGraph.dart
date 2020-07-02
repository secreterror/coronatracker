import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data.dart';
class BarGraph extends StatefulWidget {
  final String country;
  final List covidCases;
  final List date;
  BarGraph({this.country,this.covidCases,this.date});

  @override
  _BarGraphState createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: primaryBlack,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('New  Cases',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white
              )),
           Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Center(
              child: Container(
                child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                              margin: 10.0,
                              showTitles: true,
                              textStyle: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14

                              ),
                              rotateAngle: 35.0,
                              getTitles: (double val) {
                                return (widget.date[val.toInt()+1]);


                              }
                          ),
                          leftTitles: SideTitles(
                            margin: 15,
                            reservedSize: 30,
                            showTitles: true,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            getTitles: (val){
                              if(val==0){
                                return '0';
                              }
                              else if(val%3==0){
                                return NumberFormat.compact().format(val).toString();
                              }
                              else return '';
                            }
                          ),
                        ),
                        gridData: FlGridData(
                          show: false,
                          checkToShowHorizontalLine: (val)=>val%3==0,
                          getDrawingHorizontalLine: (val)=>FlLine(
                            color: Colors.black12,
                            strokeWidth: 1.0,
                            dashArray: [5]
                          )
                        ),
                        borderData: FlBorderData(show:false),
                        barGroups: widget.covidCases
                            .asMap()
                            .map((key, value) =>MapEntry(
                            key,
                            BarChartGroupData(x:key,
                                barRods: [
                                  BarChartRodData(
                                      y: value,
                                      color: Colors.red
                                  )
                                ])

                        )).values.toList()
                    )
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}




import 'package:corona/pages/detailPageWorld.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_display/number_display.dart';
import 'package:intl/intl.dart';


class WorldWide extends StatelessWidget {
  final display=createDisplay(separator: ',');
  final Map worldData;
  final Map history;
  final int prevDay;
  WorldWide({this.worldData,this.history,this.prevDay});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2, // this is the ratio of width and the height
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Template(
              panelColor: Colors.red[100],
              title: 'Confirmed',
              count: NumberFormat.compactLong().format(worldData['cases']).toString(),
              todayInc: worldData['todayCases'].toString(),
              history: history['cases'],
            ),
          ),
          Template(
            panelColor: Colors.blue[100],
            title: 'Active',
            count: NumberFormat.compactLong().format(worldData['active']).toString(),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Template(
              panelColor: Colors.green[100],
              title: 'Recovered',
              count: NumberFormat.compactLong().format(worldData['recovered']).toString(),
              history: history['recovered'],
            ),
          ),
          Template(
            panelColor: Colors.grey[100],
            title: 'Deaths',
            count: NumberFormat.compact().format(worldData['deaths']).toString(),
            todayDeath: (worldData['todayDeaths']).toString(),
            history: history['deaths'],
          )

        ],

      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  final String todayInc;
  final String todayDeath;
  StatusPanel({this.panelColor,this.textColor,this.title,this.count,this.todayDeath,this.todayInc});
  @override
  Widget build(BuildContext context) {


    double width =MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      color: panelColor,
      height: 80,
      width: width/2-10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor
            ),
          ),
          Text(count,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor
            ),
          ),
          title=='Deaths'||title=='Confirmed'?Padding(
            padding: const EdgeInsets.only(right:8.0,),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                 Text(
                   title=='Deaths'?todayDeath:todayInc,
                   style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.bold,
                       color: textColor
                   ),
                 ),


               ],
             ),
          ):Text(''),

        ],
      ),
    );
  }
}

class Template extends StatelessWidget {
  final Color panelColor;
  final String title;
  final String count;
  final String todayInc;
  final String todayDeath;
  final Map history;
  Template({this.panelColor,this.title,this.count,this.todayDeath,this.todayInc,this.history});

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    return title=='Confirmed'||title=='Deaths'?GestureDetector(
      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreenWorld(title: title,nayaInc: todayInc,nayaDeath: todayDeath,total: count,history: history,lis: getSpot(history),))),
      child: Card(width)
    ):Card(width);
  }
  Card(width){
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        elevation: 2,
        color: panelColor,
        child: Container(
          width: width/2-10,
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Color(0xFFFF9C00).withOpacity(0.12),
                          shape: BoxShape.circle
                      ),
                      child:SvgPicture.asset('assets/images/sport.svg',
                        height: 12,
                        width: 12,) ,
                    ),
                    SizedBox(width: 5),
                    Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ],
                ),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          RichText(
                            text:TextSpan(
                                children: [
                                  TextSpan(
                                    text: count,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),

                                  ),
                                ]

                            ),

                          ),
                          Text(
                              'People',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  height: 2,
                                  color: Colors.black.withOpacity(0.4)
                              )
                          ),
                          title=='Confirmed'||title=='Deaths'?Row(

                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:3.0),
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                              Text(
                                title=='Confirmed'?todayInc:todayDeath,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 2,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ):Container()



                        ],
                      ),
                    ),

                  ),Padding(
                    padding: const EdgeInsets.only(right:20.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle
                      ),
                      child:SvgPicture.asset('assets/images/search.svg',
                        height:40,
                        width: 40,) ,
                    ),
                  )

                ],
              ),


            ],
          ),
        ),
      ),
    );

  }
}
class LineReportChart extends StatelessWidget {
  final String title;
  final Map hist;
  LineReportChart({this.title,this.hist});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: getflSpot(hist),
              isCurved: true,
              dotData: FlDotData(show:false),
              belowBarData: BarAreaData(show:false),
              barWidth: 5,
              colors: [

                Colors.green[400],

              ]


            )
          ],

        ),

      ),
    );
  }
}

List<double> getSpot(Map history){

  List<double> list=[];
  for(int cnt in history.values ){
    list.add(cnt.toDouble());
    if(list.length==5){
      break;
    }
  }
  return list;
}
List<FlSpot> getflSpot(Map history){

  List<FlSpot> list=[];
  int i=1;
  for(int cnt in history.values ){
    list.add(FlSpot(i.toDouble(),cnt.toDouble()));
    i++;
    if(i==5){
      break;
    }
  }
  return list;
}




import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:number_display/number_display.dart';
import 'package:intl/intl.dart';


class WorldWide extends StatelessWidget {
  final display=createDisplay(separator: ',');
  final Map worldData;
  WorldWide({this.worldData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2, // this is the ratio of width and the height
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: StatusPanel(
              panelColor: Colors.red[100],
              textColor: Colors.red,
              title: 'Confirmed',
              count: NumberFormat.compactLong().format(worldData['cases']).toString(),
              todayInc: worldData['todayCases'].toString(),
            ),
          ),
          StatusPanel(
            panelColor: Colors.blue[100],
            textColor: Colors.blue,
            title: 'Active',
            count: NumberFormat.compactLong().format(worldData['active']).toString(),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: StatusPanel(
              panelColor: Colors.green[100],
              textColor: Colors.green,
              title: 'Recovered',
              count: NumberFormat.compactLong().format(worldData['recovered']).toString(),
            ),
          ),
          StatusPanel(
            panelColor: Colors.grey[100],
            textColor: Colors.grey,
            title: 'Deaths',
            count: NumberFormat.compact().format(worldData['deaths']).toString(),
            todayDeath: NumberFormat.compactLong().format(worldData['todayDeaths']).toString(),
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
      width: width/2,
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
                 Icon(
                   Icons.arrow_upward,
                   color: textColor,
                 ),

               ],
             ),
          ):Text(''),

        ],
      ),
    );
  }
}


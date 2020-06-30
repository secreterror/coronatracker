import 'package:corona/data.dart';
import 'package:corona/panel/worldwide.dart';
import 'package:corona/widget/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreenWorld extends StatelessWidget {
  final String title;
  final String total;
  final String nayaInc;
  final String nayaDeath;
  final List<double> lis;
  final Map history;
  DetailScreenWorld({this.title,this.total,this.nayaInc,this.nayaDeath,this.lis,this.history});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryBlack,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height:20),
            buildTitle(),
            Row(
              children: <Widget>[


              ],
            )

          ],
        ),
      ),
    );
  }

  buildTitle(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0,21),
                blurRadius: 50,
                color: Colors.black.withOpacity(0.3)

            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(title=='Confirmed'?'New Cases':'Todays Deaths',style:
              TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              ),
              ),

            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              Text(
                title=='Confirmed'?nayaInc:nayaDeath,
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                ),
              ),
              Text('0.6',
                style: TextStyle(
                    color: Colors.green
                ),
                
              ),
              SvgPicture.asset('assets/images/arrow.svg',height: 15,
              width: 15,
              color: Colors.red,)
            ],
          ),
          WeeklyChart(barChartData: lis,)
//          LineReportChart(hist: history,)
        ],
      ),
    );
  }
}


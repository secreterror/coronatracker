import 'dart:convert';

import 'package:corona/config.dart';
import 'package:corona/data.dart';
import 'package:corona/widget/barGraph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Regional extends StatefulWidget {
  final String country;
  Regional({this.country});

  @override
  _RegionalState createState() => _RegionalState();
}

class _RegionalState extends State<Regional> {


  Map history;
  List covidCase;
  List covidCasess;
  List covidCases=[];
  List<String> date;
  fetchHistory()async {
    print('inthe grid');
    http.Response response= await http.get('https://corona.lmao.ninja/v2/historical/'+widget.country+'?lastdays=6');
    setState(() {
      history=json.decode(response.body);
      print(history.length);
      if(history.length!=1){
        print(history['timeline']['cases']);
        date=history['timeline']['cases'].keys.toList();
        covidCase=history['timeline']['cases'].values.toList();
        print(covidCase);
        history.forEach((key, value) =>print("key :$key, value: $value"));
        covidCasess=covidCase.map((i) => i.toDouble()).toList();

        for(int i=1;i<covidCasess.length;i++){
          covidCases.insert(i-1,covidCasess[i]-covidCasess[i-1]);

        }
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHistory();
  }
  @override
  Widget build(BuildContext context) {
    return history==null?Scaffold(appBar:AppBar(),body: Center(child: CircularProgressIndicator())):
    history.length==1?Scaffold(
      appBar: AppBar(title: (Center(child: Text(widget.country))) ,),
      body: Center(
        child: Text('sorry no info is available'),
      ),
    ):Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.country)),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BarGraph(country: widget.country,covidCases: covidCases,date: date,)
                ],
              )
            ),


          ],
        ),
      ),
    );
  }
}

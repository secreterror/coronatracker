import 'dart:convert';

import 'package:corona/config.dart';
import 'package:corona/data.dart';
import 'package:corona/nav/blocnav.dart';
import 'package:corona/panel/worldwide.dart';
import 'package:corona/panel/mostAffected.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class Initial extends StatefulWidget with NavigationState {
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial>  {
  Map worldData;
  Map history;
  List mostAffected;
  fetchWorldData()async {
    http.Response response= await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData=json.decode(response.body);
    });

  }
  fetchMostAffected()async {
    http.Response response= await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      mostAffected=json.decode(response.body);
    });

  }
  fetchHistory()async {
    print('in');
    http.Response response= await http.get('https://corona.lmao.ninja/v2/historical/all?lastdays=10');
    setState(() {
      history=json.decode(response.body);
    });

  }
  @override
  void initState(){
    super.initState();
    fetchWorldData();
    fetchMostAffected();
    fetchHistory();
  }

  fetchData()async{
    await fetchMostAffected();
    await fetchWorldData();
    await fetchHistory();
    print('here');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: ()=>fetchData(),
        child: SingleChildScrollView(
          child:
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left :10.0,right:0,bottom:80),
                   child: Material(
                    elevation: 35,
                    shadowColor: Colors.red[100],
                    child: Container(
                      height: MediaQuery.of(context).size.height/7,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5)
                        ),
                        color: primaryBlack,
                      ),
                    ),
                  ),
                ),
                worldData==null||history==null?CircularProgressIndicator():WorldWide(worldData: worldData,history: history,),
                worldData==null||history==null?Container(height: MediaQuery.of(context).size.height/2,):Material(
                  child: PieChart(dataMap:{
                    'Active':worldData['active'].toDouble(),
                    'Recovered':worldData['recovered'].toDouble(),
                    'Deaths':worldData['deaths'].toDouble(),
                  },
                    colorList: [
                      Colors.red[700],
                      Colors.green[400],
                      Colors.yellow
                    ],

                    chartType: ChartType.ring,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,top:15),
                  child: Row(
                    children: <Widget>[
                      Container(
                          alignment: AlignmentDirectional.topStart,
                          child: Text('Most Affected Countries',style:
                              Config.titleStyle
                            )
                      ),

                    ],
                  ),
                ),
              mostAffected==null?Container():MostAffected(countryData: mostAffected,)
              ],
            ),
        ),
      )
    );
  }
}

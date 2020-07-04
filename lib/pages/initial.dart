import 'dart:convert';

import 'package:corona/config.dart';
import 'package:corona/data.dart';
import 'package:corona/nav/blocnav.dart';
import 'package:corona/panel/worldwide.dart';
import 'package:corona/panel/mostAffected.dart';
import 'package:corona/panel/prevention.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:corona/pages/country.dart';
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
  List prevCountryData;
  fetchWorldData()async {
    http.Response response= await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData=json.decode(response.body);
    });

  }
  fetchYesterday()async {

    http.Response response=await http.get('https://disease.sh/v3/covid-19/countries?yesterday=true&sort=cases');

    setState((){
      prevCountryData=json.decode(response.body);

    });
  }
  fetchMostAffected()async {
    http.Response response= await http.get('https://disease.sh/v3/covid-19/countries?sort=cases');
    mostAffected=json.decode(response.body);

//    for(int i=0;i<5;i++){
//      await fetchYesterday(mostAffected[i]['country'],i);
//    }
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

    fetchWorldData();
    fetchMostAffected();
    fetchHistory();
    fetchYesterday();
    super.initState();
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
      appBar: AppBar(
        title: Center(
          child: Text('World Stats',
            style: GoogleFonts.poppins(
                color: Colors.white),
          ),

        ),
      ),
      body:RefreshIndicator(
        onRefresh: ()=>fetchData(),
        child: SingleChildScrollView(
          child:
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:10.0,left:15,bottom:0),
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         mainTitle(),
                          regionalButton()
                        ],
                      ),
                    ),
                  ),
                ),
                worldData==null||history==null?Center(
                  child: SpinKitFadingCircle(
                    color: primaryBlack,
                  ),
                ):WorldWide(worldData: worldData,history: history,),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,top:15,bottom:0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          alignment: AlignmentDirectional.topStart,
                          child: Text('Preventive Measures',style:
                          Config.titleStyle
                          )
                      ),

                    ],
                  ),
                ),
                PreventionCard(),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,top:15,bottom:0),
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

              mostAffected==null||prevCountryData==null?Container():MostAffected(countryData: mostAffected,prevDay: prevCountryData,),

              ],
            ),
        ),
      )
    );
  }

  mainTitle(){
    return RichText(
      text: TextSpan(
        text: 'Covid-19',
        style: GoogleFonts.poppins(
          color: Config.primaryColor,
          fontSize: 35,
          fontWeight: FontWeight.bold
        )

      ),
    );
  }
  regionalButton(){
    return GestureDetector(
      onTap: (){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()))
        BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.RegionalClick);
      },
      child: Container(
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Config.primaryColor
        ),
        child: Center(
          child: Text(
            'Regional',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}

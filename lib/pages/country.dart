import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:corona/nav/blocnav.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:corona/pages/regional.dart';
import 'package:corona/widget/barGraph.dart';

import '../config.dart';

class CountryPage extends StatefulWidget with NavigationState {

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData()async {
    http.Response response= await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData=json.decode(response.body);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.HomePageClick);
            },
          )
        ],
        title: Center(
          child: Text('Country Status',
          style: GoogleFonts.poppins(
            color: Colors.white),
          ),

        ),

      ),
      body: countryData==null?CircularProgressIndicator():
      RefreshIndicator(
        onRefresh: ()=>fetchCountryData(),
        child: ListView.builder(itemBuilder:(context,idx){
          return Container(
            margin: EdgeInsets.all(8),
            child: GestureDetector(
              onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>Regional(imageUrl:countryData[idx]['countryInfo']['flag'],country: countryData[idx]['country'],countryData: countryData[idx]))),
              child: Material(
                elevation: 2,
                color: Colors.white,
                shadowColor: Colors.black45,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 5,
                            child: Text(countryData[idx]['country'],
                                style: GoogleFonts.poppins(
                                color: Config.primaryColor.withOpacity(.8),
                                fontSize:17,
                                fontWeight: FontWeight.w600)
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle ,
                              ),
                              child: Image(
                                image: CachedNetworkImageProvider(countryData[idx]['countryInfo']['flag'],),
                                height: 20,
                                width: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8,10,8,8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Total',
                                    style: GoogleFonts.poppins(
                                    color: Config.redColor.withOpacity(.8),
                                    fontSize:13,
                                    fontWeight: FontWeight.w600)
                                ),
                                Text(NumberFormat.compact().format(countryData[idx]['cases']).toString(),
                                    style: GoogleFonts.poppins(
                                        color: Config.primaryColor.withOpacity(.8),
                                        fontSize:13,
                                        fontWeight: FontWeight.w600)
                                ),
                              ],

                            ),
                            Text('|'),
                            Column(
                              children: <Widget>[
                                Text('Active',
                                style: GoogleFonts.poppins(
                                color: Config.blueColor.withOpacity(.8),
                                fontSize:13,
                                fontWeight: FontWeight.w600)
                                ),
                                Text(countryData[idx]['active'].toString(),
                                    style: GoogleFonts.poppins(
                                        color: Config.primaryColor.withOpacity(.8),
                                        fontSize:13,
                                        fontWeight: FontWeight.w600)
                                ),
                              ],

                            ),
                            Text('|'),
                            Column(
                              children: <Widget>[
                                Text('Recovered',
                                    style: GoogleFonts.poppins(
                                        color: Config.greenColor.withOpacity(.9),
                                        fontSize:13,
                                        fontWeight: FontWeight.w600)
                                ),
                                Text(countryData[idx]['recovered'].toString(),
                                    style: GoogleFonts.poppins(
                                        color: Config.primaryColor.withOpacity(.8),
                                        fontSize:13,
                                        fontWeight: FontWeight.w600)
                                ),
                              ],

                            ),
                            Text('|'),
                            Column(
                              children: <Widget>[
                                Text('Deaths',
                                    style: GoogleFonts.poppins(
                                    color: Colors.grey.withOpacity(.9),
                                    fontSize:13,
                                    fontWeight: FontWeight.w600)
                                ),
                                Text(countryData[idx]['deaths'].toString(),
                                    style: GoogleFonts.poppins(
                                        color: Config.primaryColor.withOpacity(.8),
                                        fontSize:13,
                                        fontWeight: FontWeight.w600)
                                ),

                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                ),
              ),
            ),
          );

        },
        itemCount: countryData==null?0:countryData.length,),
      ),
    );
  }
}

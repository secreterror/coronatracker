import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona/config.dart';
import 'package:corona/data.dart';
import 'package:corona/widget/barGraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Regional extends StatefulWidget {
  final String imageUrl;
  final String country;
  Map countryData;
  Regional({this.country,this.imageUrl,this.countryData});

  @override
  _RegionalState createState() => _RegionalState();
}

class _RegionalState extends State<Regional> with TickerProviderStateMixin{

  TabController _tabController;




  Map history;
  List covidCaseInt;
  List covidCaseDoub;
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
        covidCaseInt=history['timeline']['cases'].values.toList();
        print(covidCaseInt);
        history.forEach((key, value) =>print("key :$key, value: $value"));
        covidCaseDoub=covidCaseInt.map((i) => i.toDouble()).toList();

        for(int i=1;i<covidCaseDoub.length;i++){
          covidCases.insert(i-1,covidCaseDoub[i]-covidCaseDoub[i-1]);

        }
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHistory();
    _tabController = new TabController(vsync: this, length:
    3,initialIndex: 0);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return history==null?Scaffold(appBar:AppBar(),body: Center(child: CircularProgressIndicator()),backgroundColor: primaryBlack,):
    Scaffold(
      backgroundColor: primaryBlack,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor:primaryBlack,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.height*0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top:35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Flexible(
                      child: Text(widget.country,style:GoogleFonts.poppins(
                        fontSize:50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,


                      ),
                      overflow: TextOverflow.ellipsis,),
                    ),
                    Image(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                    ),
                  ],
                ),
              )
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 8),
            sliver: SliverToBoxAdapter(
              child: Text('Statistics',style:GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),
            ),
          ),
          statusHeader(),
//          SliverPadding(padding: EdgeInsets.symmetric(horizontal: 10),
//            sliver: SliverToBoxAdapter(
////            child:BarGraph(country: widget.country,covidCases: covidCases,date: date,)
//               child: statusHeader()
//          ),
//
//        ),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
             child:history.length==1?Container(
               color: primaryBlack,
               child: Center(
                 child: Text('No Historical Data Are Present',style:GoogleFonts.poppins(
                     fontSize: 30,
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                 )),
               ),

             ):BarGraph(country: widget.country,covidCases: covidCases,date: date,)
//          child: StatusGrid(),
            ),

          ),


        ],
      ),


//      body: Container(
//        margin: EdgeInsets.all(8),
//        child: Column(
//          children: <Widget>[
//            Container(
//              child:Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  SliverPadding(padding: EdgeInsets.symmetric(horizontal: 10),
//                  sliver: SliverToBoxAdapter(
//                    child: statusHeader(),
//                  ),
//                  ),
//                  BarGraph(country: widget.country,covidCases: covidCases,date: date,)
//                ],
//              )
//            ),
//
//
//          ],
//        ),
//      ),
    );
  }
  int selectedIndex=0;


  SliverPadding statusHeader(){
    return SliverPadding(
      padding: EdgeInsets.only(top:2),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: primaryBlack,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
          ),
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: ListView(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              children:<Widget>[
                TabBar(
                  controller:_tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor:Colors.white,

                  tabs: <Widget>[
                    Text('Total'),
                    Text('Yesterday'),
                    Text('Today')
                  ],
                ),
                Container(
                  height:MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:primaryBlack,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      StatusGrid(
                        total: widget.countryData['cases'].toString(),
                        recover: widget.countryData['recovered'].toString(),
                        death: widget.countryData['deaths'].toString(),
                        critical: widget.countryData['critical'].toString(),
                        active: widget.countryData['active'].toString(),
                      ),
                      history.length==1?StatusGrid(
                        total: 'N/A',
                        recover: 'N/A',
                        critical: 'N/A',
                        death: 'N/A',
                        active: 'N/A',

                      ):StatusGrid(
                        total:'[' +(history['timeline']['cases'].values.elementAt(5)-history['timeline']['cases'].values.elementAt(4)).toString()+']+',
                        recover: (history['timeline']['deaths'].values.elementAt(5)-history['timeline']['deaths'].values.elementAt(4)).toString(),
                        death: (history['timeline']['recovered'].values.elementAt(5)-history['timeline']['recovered'].values.elementAt(4)).toString(),
                        active: (widget.countryData['active']-widget.countryData['todayRecovered']).toString(),
                        critical: 'N/A',

                      ),
                      StatusGrid(
                        total:'['+ widget.countryData['todayCases'].toString()+']+',
                        recover:'[' +widget.countryData['todayRecovered'].toString()+']+',
                        death:'['+ widget.countryData['todayDeaths'].toString()+']+',
                        critical:widget.countryData['critical'] .toString(),
                        active: widget.countryData['active'].toString(),
                      )
                    ],
                  ),
                )
              ]
            ),

          ),
        ),


      ),



    );

  }


}
class StatusGrid extends StatelessWidget {
  final Map hisData;
  final String total;
  final String recover;
  final String critical;
  final String active;

  final String death;

  StatusGrid({this.hisData,this.total,this.death,this.active,this.critical,this.recover});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Row(
            children: <Widget>[
              statCard(Colors.red[800].withOpacity(0.9),total,'Cases'),
              statCard(Colors.teal.withOpacity(0.8),recover,'Recovered')

            ],
          ),
        ),
        Flexible(
          child: Row(
            children: <Widget>[
              statCard(Colors.amberAccent[700].withOpacity(0.9),active,'Active'),
              statCard(Colors.grey,death,'Deaths'),
              statCard(Colors.cyan,critical,'Critcial')

            ],
          ),
        ),

      ],
    );
  }

  Expanded statCard(Color color,String count,String title){
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color:color,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
            Text(count,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
          ],
        ),
      ),
    );
  }
}

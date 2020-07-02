import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona/pages/regional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona/config.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class MostAffected extends StatelessWidget {
  final List countryData;
  final List prevDay;
  MostAffected({this.countryData,this.prevDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,idx){
          return MostAffectedTile(countryData: countryData,idx: idx,);
        },
        itemCount: 5,
      ),
    );
  }
}



class MostAffectedTile extends StatelessWidget {
  final List countryData;
  final int idx;
  final int prevDay;
  MostAffectedTile({this.countryData,this.idx,this.prevDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: GestureDetector(
        onDoubleTap:() => Navigator.push(context,MaterialPageRoute(builder: (context)=>Regional(imageUrl:countryData[idx]['countryInfo']['flag'],country: countryData[idx]['country'],countryData: countryData[idx]))),
        child: Material(
          elevation: 2,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          shadowColor: Colors.black45,
          child: Container(
            width: MediaQuery.of(context).size.width*0.72,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(countryData[idx]['country'],style: Config.statsTitleStyle,),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle ,
                      ),
                      child: Image(
                        image: CachedNetworkImageProvider(countryData[idx]['countryInfo']['flag'],),
                        height: 30,
                        width: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                SizedBox(height: 4,),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                    margin: EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Config.redColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(4),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Flexible(flex:7,child: Text('Infected: '+NumberFormat.compact().format(countryData[idx]['cases']).toString(),style: Config.infectedStyle,)),
                        Padding(
                          padding: const EdgeInsets.only(top:3.0),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(countryData[idx]['todayCases'].toString(),
                          style: TextStyle(
                            color: Config.redColor
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                 child:Container(
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                  margin: EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Config.blueColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(4),

                  ),
                  child: Text('Active: '+countryData[idx]['active'].toString(),style: Config.activeStyle,),
                ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                    margin: EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Config.primaryColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(4),

                    ),
                    child: Text('Death: '+countryData[idx]['deaths'].toString(),style: Config.deadStyle,),
                  ),
                )
              ],
            ),



          ),
        ),
      ),

    );
  }
}

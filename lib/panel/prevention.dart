
import 'package:corona/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data.dart';
class PreventionCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/6,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PreventionCardTile(url: 'assets/images/handwash.svg',measures: 'Wash Hand Regularly',),
          PreventionCardTile(url: 'assets/images/distance.svg',measures: 'Social Distancing',),
          PreventionCardTile(url: 'assets/images/face-mask.svg',measures: 'Put On Face Mask',),
          PreventionCardTile(url: 'assets/images/house.svg',measures: 'Stay At Home',),

        ],
      ),
    );
  }
}



class PreventionCardTile extends StatelessWidget {

  final String url;
  final String measures;
  PreventionCardTile({this.url,this.measures});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width*0.7,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                flex:1,
                  child: SvgPicture.asset(url)),
              Flexible(
                flex: 2,
                child: Text(measures,
                style:GoogleFonts.arvo(
                  fontSize: 18,
                  color:primaryBlack,
                  fontWeight: FontWeight.w600,
                )),
              )


            ],
          ),
        ),
      ),
    );
  }
}

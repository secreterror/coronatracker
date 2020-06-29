import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MostAffectedCountries extends StatefulWidget {
  final List countryData;
  MostAffectedCountries({this.countryData});
  @override
  _MostAffectedCountriesState createState() => _MostAffectedCountriesState();
}

class _MostAffectedCountriesState extends State<MostAffectedCountries> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder:(context,idx){
            return Padding(
              padding: const EdgeInsets.only(bottom:2.0),
              child: Material(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       Image(
                         image:  CachedNetworkImageProvider(widget.countryData[idx]['countryInfo']['flag']),
                         height: 50,
                         width: 70,
                       ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: <Widget>[
                            Text(widget.countryData[idx]['country'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              ),
                            ),

                            Column(
                              children: <Widget>[
                                Text('Total  ',
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 20
                                ),
                                ),
                                Text(widget.countryData[idx]['cases'].toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('Deaths',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                                Text(widget.countryData[idx]['deaths'].toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)
                                  ),
                                ),
                              ],
                            ),

                            Column(
                              children: <Widget>[
                                Text('Active',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                                Text(widget.countryData[idx]['active'].toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                ),
              ),
            );
            },itemCount:5,),
    );
  }
}

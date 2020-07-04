import 'dart:async';

import 'package:corona/data.dart';
import 'package:corona/nav/blocnav.dart';
import 'package:corona/widget/menuitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin<Sidebar> {

  AnimationController animationController;

  StreamController<bool>isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

//  final bool isOpened=false;
  final _animationDuration= const Duration(milliseconds: 400);

  @override
  void initState(){
    super.initState();
    animationController=AnimationController(
      vsync: this,
      duration: _animationDuration
    );
    isSideBarOpenedStreamController=PublishSubject<bool>();
    isSideBarOpenedStream =isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink=isSideBarOpenedStreamController.sink;
    super.initState();
  }

  @override
  void dispose(){



    animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }
  void onIconPressed(){
    final status=animationController.status;
    final isAnimationCompleted=status==AnimationStatus.completed;

    if(isAnimationCompleted){
      isSideBarOpenedSink.add(false);
      animationController.reverse();
    }else{
      isSideBarOpenedSink.add(true);
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context,isOpened){
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom:0,
          left:isOpened.data?0:-screenWidth,
          right:isOpened.data?0:screenWidth-40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: primaryBlack,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100,),
                      ListTile(
                        title: Text('Covid-19-Tracker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                        subtitle: Text(
                          'by secreterror',
                          style: TextStyle(
//                            color: Colors.white.withAlpha(1),
                            fontWeight:FontWeight.w200,
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.5)

                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(

                            Icons.perm_identity,
                            color: Colors.black,

                          ),
                        ),

                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(.4),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: 'Home',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.HomePageClick);
                        },
                      ),
                      MenuItem(
                        icon: Icons.phone,
                        title: 'Contact Us',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.ContactClick);
                        },
                      ),
                      MenuItem(
                        icon: Icons.question_answer,
                        title: 'FAQS',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.FaqClick);
                        },
                      ),
                      MenuItem(
                        icon: Icons.question_answer,
                        title: 'Regional',
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvent.RegionalClick);
                        },
                      ),

                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:(){
                  onIconPressed();
                },
                child: Padding(
                  padding:EdgeInsets.only(top: 50),
                  child: Align(
                    alignment:Alignment.topLeft,
                    child: Container(
                      width: 30,
                      height: screenHeight/20,
                      color: Colors.amber,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: animationController,
                        icon:  AnimatedIcons.menu_close,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        );
      }

    );

  }
}

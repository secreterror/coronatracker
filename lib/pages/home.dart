import 'package:corona/nav/blocnav.dart';
import 'package:corona/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider<NavigationBloc>(
        create: (context)=>NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc,NavigationState>(
              builder: (context,currState){
                return currState as Widget;
              },
            ),
            Sidebar()

          ],
        ),
      ),
    );
  }
}

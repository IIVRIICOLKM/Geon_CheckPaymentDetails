import 'package:flutter/material.dart';
import 'package:payment_app/Widgets/appFrame.dart';

class HomeView extends StatelessWidget{
  HomeView(){}

  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  mainAppBar(name: appName),
                ]
            )
        ),
        bottomNavigationBar: mainBottomBar()
    );

  }
}


import 'dart:async';

import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/landing_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/quiz/certicate_screen.dart';
import 'package:airtel_lms/views/quiz/view_file_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_dashboard_screen.dart';

class SplashScreen extends StatefulWidget
{
  final String token;
  SplashScreen(this.token);
  SplashState createState()=>SplashState();
}
class SplashState extends State<SplashScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset("assets/payment_bank_ic.png"),
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateUser();

  }

  navigateUser(){
   // PdftronFlutter.openDocument("https://view.officeapps.live.com/op/embed.aspx?src=https://fieldlms.qdegrees.com/training_document/JUL2024/1721117404-document.pptx");

    if(widget.token!='')
      {
        Timer(
            Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => NewDashboardScreen())));
      }
    else{
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen())));
    }



  }


}

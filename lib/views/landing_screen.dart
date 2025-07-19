
import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/dashboard_screen.dart';
import 'package:airtel_lms/views/profile_screen.dart';
import 'package:airtel_lms/views/search_screen.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class LandingScreen extends StatefulWidget
{
  LandingState createState()=>LandingState();
}

class LandingState extends State<LandingScreen>
{
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: AppTheme.redColor,
                width: 0.2,
              ),
              right: BorderSide(
                color: AppTheme.redColor,
                width: 0.2,
              ),
              top: BorderSide(
                color: AppTheme.redColor,
                width: 1,
              ),
              bottom: BorderSide(
                color: AppTheme.redColor,
                width: 1,
              ),
            ),
        ),

        child: Container(
          height: 70,
          padding: const EdgeInsets.only(
              left: 0, top: 9, bottom: 5),
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  selectedIndex = 0;
                  setState(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Image.asset(
                        'assets/dashboard_nav.png',
                        width: 22,
                        height: 22,
                        color: selectedIndex == 0
                            ? AppTheme.redColor
                            : Colors.white.withOpacity(0.60)),
                    SizedBox(height: 5),
                    Text('Dashboard',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                          selectedIndex == 0?FontWeight.w700:
                          FontWeight.w500,
                          color:  selectedIndex == 0
                              ? AppTheme.redColor
                              : Colors.white.withOpacity(0.60)),
                    )],
                ),
              ),

              GestureDetector(
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Image.asset(
                        'assets/home_nav.png',
                        width: 22,
                        height: 22,
                        color: selectedIndex == 1
                            ? AppTheme.redColor
                            : Colors.white.withOpacity(0.60)),
                    SizedBox(height: 5),
                    Text('Home',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                          selectedIndex == 1?FontWeight.w700:
                          FontWeight.w500,
                          color:  selectedIndex == 1
                              ? AppTheme.redColor
                              : Colors.white.withOpacity(0.60)),
                    )],
                ),
              ),

              GestureDetector(
                onTap: () {
                  selectedIndex = 2;
                  setState(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    Image.asset(
                        'assets/search_nav.png',
                        width: 22,
                        height: 22,
                        color: selectedIndex == 2
                            ? AppTheme.redColor
                            : Colors.white.withOpacity(0.60)),
                    SizedBox(height: 5),
                    Text('Search',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                          selectedIndex == 2?FontWeight.w700:
                          FontWeight.w500,
                          color:  selectedIndex == 2
                              ? AppTheme.redColor
                              : Colors.white.withOpacity(0.60)),
                    )],
                ),
              ),

              GestureDetector(
                onTap: () {
                  selectedIndex = 3;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 5),
                      Image.asset(
                          'assets/profile_nav.png',
                          width: 22,
                          height: 22,
                          color: selectedIndex == 3
                              ? AppTheme.redColor
                              : Colors.white.withOpacity(0.60)),
                      SizedBox(height: 5),
                      Text('Profile',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                            selectedIndex == 3?FontWeight.w700:
                            FontWeight.w500,
                            color:  selectedIndex == 3
                                ? AppTheme.redColor
                                : Colors.white.withOpacity(0.60)),
                      )],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: selectedIndex==0?DashboardScreen():

      selectedIndex==1? HomeScreen(false):

       selectedIndex==2?
       SearchScreen(false):

       ProfileScreen()


      ,

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}


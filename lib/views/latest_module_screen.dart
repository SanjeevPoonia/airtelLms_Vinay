

import 'dart:async';

import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/pending_module_tab.dart';
import 'package:airtel_lms/views/search_screen.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:airtel_lms/widgets/tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_theme.dart';
import 'completed_module_tab.dart';

class LatestModuleScreen extends StatefulWidget
{
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<LatestModuleScreen> with TickerProviderStateMixin
{
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 27),

          Container(
            height: 57,
            color: Colors.black,
            child: Row(
              children: [
                SizedBox(width: 8),

                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white)),


                Expanded(child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Latest Modules',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),

                Image.asset("assets/filter_ic.png",width:18.5,height: 18.5),

                SizedBox(width: 12),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                    },

                    child: Image.asset("assets/search_ic.png",width:20,height: 20)),

                SizedBox(width: 17),




              ],
            ),
          ),



          Container(
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(bottom: 5),
            child: TabBar(
              //isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
              indicatorColor: AppTheme.redColor,
              indicatorWeight: 4,
              dividerColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                fontWeight: FontWeight.w400
              ),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: TabBarIndicator(color: AppTheme.redColor, radius: 2),
              labelColor: Colors.black87,
              labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'Pending Modules',
                ),
                Tab(
                  text: 'Completed Modules',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [


                PendingModuleTab(),

                CompletedModuleTab(),


              ],
            ),
          ),

        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }




}

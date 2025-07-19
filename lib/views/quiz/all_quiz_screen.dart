

import 'dart:async';

import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/pending_module_tab.dart';
import 'package:airtel_lms/views/quiz/pending_quiz_tab.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:airtel_lms/widgets/tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/app_theme.dart';
import '../completed_module_tab.dart';
import '../search_screen.dart';
import 'completed_quiz_tab.dart';

class AllQuizScreen extends StatefulWidget
{
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<AllQuizScreen> with TickerProviderStateMixin
{
  List<String> filterTypeList=[
    "By Due Date (Earliest To Oldest)",
    "By Published Date (Earliest To Oldest)",
    "Not Started",
    "In Progress",
    "Completed",
    "Expired"
  ];

  List<bool> filterCheckIndex=[
    false,
    false,
    false,
    false,
    false,
    false,


  ];
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
                      'Quiz',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),

                GestureDetector(
                    onTap: (){
                      selectFilterBottomSheet(context);
                    },

                    child: Image.asset("assets/filter_ic.png",width:18.5,height: 18.5)),

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
                  text: 'Pending Quiz',
                ),
                Tab(
                  text: 'Completed Quiz',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [


                PendingQuizScreen(),

                CompletedQuizTab(),


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


  void selectFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context,bottomSheetState)
        {
          return Container(
            padding: EdgeInsets.all(10),
            // height: 600,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)), // Set the corner radius here
              color: Colors.white, // Example color for the container
            ),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),

                Center(
                  child: Container(
                    height: 6,
                    width: 62,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                SizedBox(height: 10),

                Row(


                  children: [
                    SizedBox(width: 10),

                    Text("Filter",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),

                    Spacer(),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38,color: Colors.grey)),
                    SizedBox(width: 4),
                  ],
                ),

                SizedBox(height: 10),

                SizedBox(
                  height: 240,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filterTypeList.length,
                      itemBuilder: (BuildContext context,int pos)
                      {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                         //   crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: (){

                                  if(filterCheckIndex[pos])
                                    {
                                      filterCheckIndex[pos]=false;
                                    }
                                  else
                                    {

                                      filterCheckIndex[pos]=true;


                                    }

                                  setState(() {

                                  });

                                  bottomSheetState(() {

                                  });


                                },
                                child: Container(


                                    child:filterCheckIndex[pos]? Icon(Icons.check_box,color: AppTheme.redColor):Icon(

                                      Icons.check_box_outline_blank,color: Color(0xFFACACAC),


                                    )),
                              ),

                              SizedBox(width: 7),

                              Expanded(
                                child: Container(
                                  height: 45,
                                  color: Colors.white,
                                  child: Row(
                                    children: [

                                      Expanded(
                                        child: Text(filterTypeList[pos],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }


                  ),
                ),

                SizedBox(height: 15),


                Padding(padding: EdgeInsets.symmetric(horizontal: 13),

                child: Row(
                  children: [

                    Expanded(child: Card(
                      elevation: 4,
                      shadowColor:Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 53,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white), // background
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.black), // fore
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ))),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {

                            });

                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),flex: 1,),

                    SizedBox(width: 7),





                    Expanded(child: Card(
                      elevation: 4,
                      shadowColor:Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 53,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.white), // background
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  AppTheme.redColor), // fore
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ))),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {

                            });

                          },
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),flex: 1,),

                  ],
                ),


                ),


                SizedBox(height: 15),



              ],
            ),
          );
        }

        );

      },
    );
  }

}

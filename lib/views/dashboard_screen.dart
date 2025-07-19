

import 'dart:async';
import 'dart:convert';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/quiz/all_quiz_screen.dart';
import 'package:airtel_lms/views/all_shops_screen.dart';
import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/quiz/unattempt_quizes_screen.dart';
import 'package:airtel_lms/views/vendor_training/view_reports_screen.dart';
import 'package:airtel_lms/views/view_artifacts_screen.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'assigned_training/given_training_screen.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget
{
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<DashboardScreen>
{
  bool isLoading=false;
  Map<String,dynamic> dashboardData={};

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
                Image.asset("assets/payment_bank_ic.png"),

                Spacer(),

                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                    },

                    child: Image.asset("assets/bell_ic.png",width:30,height: 30)),

                SizedBox(width: 12),




              ],
            ),
          ),
          SizedBox(height: 14),



          Expanded(child:

          isLoading || dashboardData.isEmpty?

              Center(
                child: Loader(),
              ):



          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: Text("Quick Links",style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500
                  )),
                ),

                SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(true)));
                          },

                          child: DashboardWidget3("My Training","assets/tiles_1.png",dashboardData["my_training"]["total"].toString(),dashboardData["my_training"]["pending"].toString(),dashboardData["my_training"]["complete"].toString()))),

                      SizedBox(width: 8),
                      Expanded(flex: 1, child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UnAttemptQuizScreen()));
                          },

                          child: DashboardWidget("My Quiz","assets/tiles_3.png",dashboardData["my_quiz"]["total"].toString(),dashboardData["my_quiz"]["pending"].toString(),dashboardData["my_quiz"]["complete"].toString()))),
                    ],
                  ),
                ),


                SizedBox(height: 12),





                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: InkWell(

                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewArtifactScreen()));
                          },

                          child: DashboardWidget2("My Certificate","assets/tiles_5.png",dashboardData["my_certificate"].toString()))),

                      SizedBox(width: 8),
                      Expanded(flex: 1, child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>GivenTrainingScreen()));
                          },

                          child: DashboardWidget2("Store/ Shop","assets/tiles_7.png",dashboardData["store_shop"].toString()))),
                    ],
                  ),
                ),




                SizedBox(height: 12),




                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFfF9F9F9),
                  ),
                  height: 106,
                  child: Stack(
                    children: [

                      Row(
                        children: [


                          Spacer(),
                          Container(
                              transform: Matrix4.translationValues(15.0, -10.0, 0.0),
                              child: Image.asset("assets/report_ic.png",width: 93,height: 111,))
                        ],
                      ),



































                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 9),


                          Padding(
                            padding:  EdgeInsets.only(left: 15),
                            child: Text("Overall Report",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child:Container(
                              height: 30,
                              width: 90,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppTheme.redColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            /*   side: BorderSide(
                                                    color: AppTheme.blueColor)*/))),
                                  onPressed: () {





                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewReportsScreen()));
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalResultScreen(quizList[index]["id"].toString())));




                                  },
                                  child: const Text("View", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))),
                            ),
                          ),










                        ],
                      ),
                    ],
                  ),
                )





              ],
            ),
          ))




        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDashboardData(context);

  }


  fetchDashboardData(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('quick-link', data, context);
    setState(() {
      isLoading=false;
    });
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    dashboardData=responseJSON["data"];
    setState(() {

    });


  }

}



import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:airtel_lms/utils/app_modal.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:airtel_lms/views/quiz/all_quiz_screen.dart';
import 'package:airtel_lms/views/courses/courses_names_screen.dart';
import 'package:airtel_lms/views/quiz/unattempt_quizes_screen.dart';
import 'package:airtel_lms/views/search_screen.dart';
import 'package:airtel_lms/views/training/completed_module_screen.dart';
import 'package:airtel_lms/views/training/expired_module_screen.dart';
import 'package:airtel_lms/views/training/full_video_screen.dart';
import 'package:airtel_lms/views/training/inprogrees_module_screen.dart';
import 'package:airtel_lms/views/notification_screen.dart';
import 'package:airtel_lms/views/quiz/final_result_screen.dart';
import 'package:airtel_lms/views/training/latest_module2_screen.dart';
import 'package:airtel_lms/views/training/training_step4.dart';
import 'package:airtel_lms/views/training/view_pdf_screen.dart';
import 'package:airtel_lms/views/quiz/attempted_quizes_screen.dart';
import 'package:airtel_lms/views/training/yet_to_start_module_screen.dart';
import 'package:airtel_lms/views/webview_screen.dart';
import 'package:airtel_lms/widgets/dashboard_module_widget.dart';
import 'package:airtel_lms/widgets/image_view_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../network/constants.dart';
import '../network/loader.dart';
import 'courses/all_courses_screen.dart';
import 'courses/course_detail_screen.dart';
import 'courses/home_courses_screen.dart';
import 'latest_module_screen.dart';
import 'quiz/terms_screen.dart';
import 'training/start_training_screen.dart';
List<String> items=[
  "Item 1",
  "Item 2",
  "Item 3",
  "Item 4",
  "Item 5",
];
class HomeScreen extends StatefulWidget
{
  final showBack;
  HomeScreen(this.showBack);
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<HomeScreen>
{
  bool isLoading=false;
  List<dynamic> latestModulesList=[];
  List<dynamic> inProgressModulesList=[];
  List<dynamic> completedModulesList=[];
  List<dynamic> quizList=[];
  List<dynamic> newsList=[];
  List<dynamic> inProgressList=[];
  Map<String,dynamic> quickLinkData={};
  Map<String,dynamic> courseData={};
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Column(
        children: [

          SizedBox(height: 27),


          widget.showBack?
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
                      'My Training',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                    },

                    child: Image.asset("assets/search_ic.png",width:20,height: 20)),

                SizedBox(width: 17),




              ],
            ),
          ):


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
          SizedBox(height: 13),


          Expanded(child:

          isLoading?

              Center(
                child: Loader(),
              ):



          ListView(
            padding: EdgeInsets.zero,
            children: [


              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Module Quick Links",style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w500
                )),
              ),


              SizedBox(height:18),



              quickLinkData.isEmpty?

                  Container():


              Row(
                children: [

                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CompletedModulesScreen()));


                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(left: 10),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF00B90C).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("Completed\n Module",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["completed_module"].toString(),style: TextStyle(
                              color: Color(0xFF00B90C),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),
                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>YetToStartModule2Screen()));


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFF2A20B).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("Yet to Start\n Module",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["yet_to_start_module"].toString(),style: TextStyle(
                              color: Color(0xFFF2A20B),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),


                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ModuleInProgressScreen()));


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFFB1F1F).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("In Progress\n Module",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["in_progress_module"].toString(),style: TextStyle(
                              color: Color(0xFFFB1F1F),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),

                  SizedBox(width: 10),
                ],
              ),

              SizedBox(height:5),
              quickLinkData.isEmpty?

              Container():
              Row(
                children: [
                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ExpiredModulesScreen()));


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF02B48A).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("Expired \nModule",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["expired_module"].toString(),style: TextStyle(
                              color: Color(0xFF02B48A),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),

                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AttemptedQuizScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(left: 5),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF1F56AE).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("Completed \nQuiz",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["completed_quiz"].toString(),style: TextStyle(
                              color: Color(0xFF1F56AE),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),




                  Expanded(child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UnAttemptQuizScreen()));


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFFB1F1F).withOpacity(0.19)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7),

                          Text("Unattempt\n Quiz",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                          ),textAlign: TextAlign.center),

                          Spacer(),

                          Text(quickLinkData["unattempted_quiz"].toString(),style: TextStyle(
                              color: Color(0xFFFB1F1F),
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          )),

                          SizedBox(height: 9),
                        ],
                      ),
                    ),
                  ),flex: 1,),

                  SizedBox(width: 10),
                ],
              ),


              SizedBox(height:32),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Newly Added Module",style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500
                    )),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LatestModule2Screen(latestModulesList)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                              width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),

              SizedBox(height:18),

                Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child:

               latestModulesList.length==0?

                   Container(
                     height: 250,
                     child: Center(
                       child: Text("No modules found!"),
                     ),
                   ):


               Row(
                 children: [

                   Expanded(child: GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(latestModulesList[0]["training_id"].toString(),0.0,"self")));

                     },
                     child: DashboardModuleWidget(
                       parseServerFormatDate(latestModulesList[0]["start_date_time"].toString()),
                       latestModulesList[0]["title"],
                       latestModulesList[0]["thumbnail"]
                     ),
                   ),flex: 1),
                   SizedBox(width: 12),





                   Expanded(child:

                   latestModulesList.length>1?

                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(latestModulesList[1]["training_id"].toString(),0.0,"self")));

                     },
                     child: DashboardModuleWidget(
                         parseServerFormatDate(latestModulesList[1]["start_date_time"].toString()),
                         latestModulesList[1]["title"],
                         latestModulesList[1]["thumbnail"]
                     ),
                   ):




                   Container(),flex: 1),

                 ],
               ),
             ),

            /*  SizedBox(height:12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    Expanded(child:  DashboardModuleWidget2(1),flex: 1),
                    SizedBox(width: 12),
                    Expanded(child:  DashboardModuleWidget2(2),flex: 1),

                  ],
                ),
              ),
*/
              SizedBox(height:32),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Module In Progress",style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                    )),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ModuleInProgressScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                            width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),

              SizedBox(height:18),



              inProgressModulesList.length==0?



              Container(
                height: 250,
                child: Center(
                  child: Text("No inprogress modules found!"),
                ),
              ):


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [


                    Expanded(child:



                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(inProgressModulesList[0]["training_id"].toString(),double.parse(inProgressModulesList[0]["completion_percentage"].toString()),"self")));
                      },
                      child: DashboardInProgressWidget(
                        parseServerFormatDate(inProgressModulesList[0]["start_date_time"].toString()),

                          inProgressModulesList[0]["title"],
                          inProgressModulesList[0]["thumbnail"]!=null?


                        AppConstant.imageBaseURL+inProgressModulesList[0]["thumbnail"]:"",
                          double.parse(inProgressModulesList[0]["completion_percentage"].toString())

                      ),
                    ),flex: 1),
                    SizedBox(width: 12),
                    Expanded(child:

                    inProgressModulesList.length>1?



                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(inProgressModulesList[1]["training_id"].toString(),inProgressModulesList[1]["completion_percentage"],"self")));
                      },
                      child: DashboardInProgressWidget(

                          parseServerFormatDate(inProgressModulesList[1]["start_date_time"].toString()),

                          inProgressModulesList[1]["title"],
                          inProgressModulesList[1]["thumbnail"]!=null?
                          AppConstant.imageBaseURL+inProgressModulesList[1]["thumbnail"]:"",
                          double.parse(inProgressModulesList[1]["completion_percentage"].toString())


                      ),
                    ):Container(),flex: 1),

                  ],
                ),
              ),


           /*   SizedBox(height:32),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Yet To Start Module",style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                    )),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ModuleInProgressScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                            width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),

              SizedBox(height:18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    Expanded(child:  DashboardCompletedWidget(1),flex: 1),
                    SizedBox(width: 12),
                    Expanded(child:  DashboardCompletedWidget(2),flex: 1),

                  ],
                ),
              ),

*/

              SizedBox(height:32),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Completed Module",style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                    )),
                  ),


                  GestureDetector(
                    onTap: (){



                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CompletedModulesScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                            width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),

              SizedBox(height:18),


              completedModulesList.length==0?



              Container(
                height: 250,
                child: Center(
                  child: Text("No completed modules found!"),
                ),
              ):


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    Expanded(child:  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(completedModulesList[0]["training_id"].toString(),double.parse(completedModulesList[0]["completion_percentage"].toString()),"self")));

                      },

                      child: DashboardCompletedWidget(

                          parseServerFormatDate(completedModulesList[0]["start_date_time"].toString()),

                        completedModulesList[0]["title"],
                        completedModulesList[0]["thumbnail"]!=null?
                          AppConstant.imageBaseURL+completedModulesList[0]["thumbnail"]:"",




                      ),
                    ),flex: 1),
                    SizedBox(width: 12),
                    Expanded(child:

                    completedModulesList.length>1?



                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(completedModulesList[1]["training_id"].toString(),double.parse(completedModulesList[1]["completion_percentage"].toString()),"self")));

                      },

                      child: DashboardCompletedWidget(

                        parseServerFormatDate(completedModulesList[1]["start_date_time"].toString()),

                        completedModulesList[1]["title"],
                        completedModulesList[1]["thumbnail"]!=null?
                        AppConstant.imageBaseURL+completedModulesList[1]["thumbnail"]:"",




                      ),
                    ):Container(),flex: 1),

                  ],
                ),
              ),




              SizedBox(height:25),


              Stack(
                children: [





                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(width: 30),

                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Courses",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600
                                )),

                                SizedBox(height: 10),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeCoursesScreen()));
                                  },
                                  child: Stack(
                                    children: [
                                      Image.asset("assets/view_all_ic.png",width:94,height: 29),
                                      Container(
                                        padding: EdgeInsets.only(left: 5,top: 5),
                                        width:94,height: 29,
                                        child: Text("View All",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500
                                        )),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),

                          Spacer(),

                          Image.asset("assets/courses_ic.png",width: 171.62,height: 189.89)

                        ],
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseDetail(courseData["training_id"].toString())));

                        },
                        child: Container(
                          height: 216,
                          transform: Matrix4.translationValues(0.0, -1.0, 0.0),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: AppTheme.redColor,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                          ),

                          child:

                          courseData.isNotEmpty?

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 105),

                              Padding(
                                padding: const EdgeInsets.only(right: 13,left: 30),
                                child: Text(courseData["title"],style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700
                                )),
                              ),
                              SizedBox(height: 15),

                              Padding(
                                  padding: const EdgeInsets.only(right: 20,left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [


                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Published On",style: TextStyle(
                                            color: Colors.white.withOpacity(0.78),
                                            fontSize: 12,
                                          )),



                                          Text(courseData["published_on"].toString(),style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          )),

                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Total Module",style: TextStyle(
                                            color: Colors.white.withOpacity(0.78),
                                            fontSize: 12,
                                          )),



                                          Text(courseData["total_module"].toString(),style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          )),

                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Pending Module",style: TextStyle(
                                            color: Colors.white.withOpacity(0.78),
                                            fontSize: 12,
                                          )),



                                          Text(courseData["pending_module"].toString(),style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          )),

                                        ],
                                      ),

                                    ],
                                  )
                              ),


                            ],
                          ):Container(),
                        ),
                      ),
                    ],
                  ),

                GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseDetail(courseData["training_id"].toString())));


                  },
                  child: Stack(
                    children: [

                      Container(
                        height: 170,
                        margin: EdgeInsets.only(left: 30,right: 65,top: 110),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/dummy7.jpg")
                            )
                        ),


                      ),






                      Container(
                        height: 170,
                        margin: EdgeInsets.only(left: 30,right: 65,top: 110),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.10)
                        ),


                      ),



                      Container(

                        height: 190,
                        margin: EdgeInsets.only(left: 30,top: 110),

                        child: Column(
                          children: [
                            Row(
                              children: [

                                Container(
                                  width: 116,
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color: AppTheme.redColor,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8))
                                  ),

                                  child: Row(
                                    children: [

                                      Text(
                                        'Due In',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white),
                                      ),


                                      SizedBox(width: 8),
                                      Column(
                                        children: [

                                          Text(
                                            courseData["time_left"]!=null?
                                            fetchDays(courseData["time_left"]):"",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Days',
                                            style: TextStyle(
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),


                                      SizedBox(width: 5),
                                      Column(
                                        children: [

                                          Text(
                                            courseData["time_left"]!=null?
                                            fetchHours(courseData["time_left"]):"",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Hours',
                                            style: TextStyle(
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),


                                      SizedBox(width: 5),
                                      Column(
                                        children: [

                                          Text(
                                            courseData["time_left"]!=null?
                                            fetchMints(courseData["time_left"]):"",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Mins',
                                            style: TextStyle(
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )


                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),







                    ],
                  ),
                )

                ],
              ),

              SizedBox(height:30),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Quiz",style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                    )),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UnAttemptQuizScreen()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                            width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),

              SizedBox(height:22),




             /* Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                  //  autoPlay: true,
                    aspectRatio: 0.9,
                    viewportFraction: 0.60,
                    enlargeCenterPage: true,
                  ),
                  items: quizList
                      .map((item) => Container(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Column(
                            children: [

                              //Image.network(item["thumbnail"]),
                              Image.asset("assets/bulb_ic.png"),

                              SizedBox(height: 8),

                              Text(item["title"],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),textAlign: TextAlign.center),
                              SizedBox(height: 4),




                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item["number_of_questions"].toString()+" Questions ",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                  )),

                                  Image.asset("assets/pending_ic.png",width: 12,height: 12),

                                  Text(" "+item["time_of_test"].toString()+" Mins",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  )),





                                ],
                              ),

                              SizedBox(height: 10),

                              Container(
                                height: 45,
                                width: 135,
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
                                                    Radius.circular(4)),
                                             *//*   side: BorderSide(
                                                    color: AppTheme.blueColor)*//*))),
                                    onPressed: () {





                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(item["id"].toString())));




                                    },
                                    child: const Text("Start Quiz", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))),
                              ),
                            ],
                          )),
                    ),
                  ))
                      .toList()
                ),
              ),*/


        CarouselSlider.builder(
            itemCount: quizList.length,
            itemBuilder: (context, index, pageViewIndex) => Center(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Column(
                      children: [

                        //Image.network(item["thumbnail"]),


                        Stack(

                          children: [
                            CachedNetworkImage(
                              imageUrl: quizList[index]["thumbnail"],
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Container(),
                              errorWidget: (context, url, error) => Image.asset("assets/bulb_ic.png"),
                            ),


                            Container(
                              width: 88,
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              height: 22,
                              decoration: BoxDecoration(
                                  color: AppTheme.redColor,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                              ),

                              child: Row(
                                children: [

                                  Text(
                                    quizList[index]["test_type"]=="regular_test"?
                                    'Regular Quiz':"Training Quiz",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),


                                ],
                              ),
                            )

                          ],
                        ),


                        SizedBox(height: 8),

                        Text(quizList[index]["title"],style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),textAlign: TextAlign.center),
                        SizedBox(height: 4),




                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(quizList[index]["number_of_questions"].toString()+" Questions ",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            )),

                            Image.asset("assets/pending_ic.png",width: 12,height: 12),

                            Text(" "+quizList[index]["time_of_test"].toString()+" Mins",style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            )),





                          ],
                        ),

                        SizedBox(height: 10),

                        Container(
                          height: 45,
                          width: 135,
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
                                            Radius.circular(4)),
                                        /*   side: BorderSide(
                                                    color: AppTheme.blueColor)*/))),
                              onPressed: () {

                                if(quizList[index]["is_attempt"]=="yes")
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(quizList[index]["id"].toString())));

                                }
                                else
                                {
                                  Toast.show("Please read all the documents for course before attempting the test.",
                                      duration: Toast.lengthLong,
                                      gravity: Toast.bottom,
                                      backgroundColor: Colors.red);
                                }




                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalResultScreen(quizList[index]["id"].toString())));




                              },
                              child: const Text("Start Quiz", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))),
                        ),
                      ],
                    )),
              ),
            ),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 0.9,
              enableInfiniteScroll: false,
              reverse: false,
              viewportFraction: 0.60,
              enlargeCenterPage: true,
            )
        ),




              Row(

                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("News",style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      )),
                    ),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AllCoursesScreen()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.asset("assets/view_all_ic.png",width:94,height: 29),
                          Container(
                            padding: EdgeInsets.only(left: 5,top: 5),
                            width:94,height: 29,
                            child: Text("View All",style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              SizedBox(height:12),


              newsList.length==0?Container():


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    Expanded(child:  GestureDetector(
                      onTap: (){

                        if(newsList[0]["document_type"]=="pdf")
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFScreen(newsList[0]["news_document"])));
                          }
                        else if(newsList[0]["document_type"]=="png" || newsList[0]["document_type"]=="jpg" || newsList[0]["document_type"]=="jpeg")
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(newsList[0]["news_document"])));

                          }
                        else if(newsList[0]["type"]=="video")
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullVideoScreen(newsList[0]["news_document"],false)));

                          }



                      },
                      child: DashboardModuleWidget22(

                          newsList[0]["start_date"]??"",
                          newsList[0]["news_title"]??"",
                          newsList[0]["news_document"]??"",
                          newsList[0]["document_type"]??"",
                          newsList[0]["type"]??"",

                      ),
                    ),flex: 1),
                    SizedBox(width: 12),
                    Expanded(child:

                    newsList.length>1?

                    GestureDetector(

                      onTap: (){


                        if(newsList[1]["document_type"]=="pdf")
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFScreen(newsList[1]["news_document"])));
                        }
                        else if(newsList[1]["document_type"]=="png" || newsList[1]["document_type"]=="jpg" || newsList[1]["document_type"]=="jpeg")
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(newsList[1]["news_document"])));

                        }
                        else if(newsList[1]["type"]=="video")
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FullVideoScreen(newsList[1]["news_document"],false)));

                        }


                      },
                      child: DashboardModuleWidget22(
                          newsList[1]["start_date"]??"",
                          newsList[1]["news_title"]??"",
                          newsList[1]["news_document"]??"",
                          newsList[1]["document_type"]??"",
                          newsList[1]["type"]??""


                      ),
                    ):Container(),flex: 1),

                  ],
                ),
              ),


              SizedBox(height:27),
            ],
          ))





        ],
      ),
    );
  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }

  fetchMyTrainings(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-training-details', data, context);
    setState(() {
      isLoading=false;
    });
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    latestModulesList=responseJSON["latest_modules"];
    quickLinkData=responseJSON["module_counts"];
    courseData=responseJSON["module_counts"];
  //  inProgressModulesList=responseJSON["ongoing_training"];
    quizList=responseJSON["quizzes"];
    courseData=responseJSON["courses"];

    setState(() {

    });


  }

  fetchNews(BuildContext context) async {

    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('news', data, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    newsList=responseJSON["data"];


    setState(() {

    });


  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyTrainings(context);
    fetchNews(context);
    fetchModules(context);
    fetchCompletedModules(context);
  }

  fetchModules(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('pending-module', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    List<dynamic> coursesList=responseJSON["data"];
    if(coursesList.length!=0)
      {
        for(int i=0;i<coursesList.length;i++)
          {

            for(int j=0;j<coursesList[i]["courses"].length;j++)
              {
                if(coursesList[i]["courses"][j]["completion_percentage"]!=0)
                  {
                    inProgressModulesList.add(coursesList[i]["courses"][j]);
                  }


              }


          }
      }


    print("Progress Data");


    log(inProgressModulesList.toString());




    setState(() {

    });


  }

  fetchCompletedModules(BuildContext context) async {

    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('completed-module', data, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    List<dynamic> coursesList=responseJSON["data"];
    if(coursesList.length!=0)
    {
      for(int i=0;i<coursesList.length;i++)
      {

        for(int j=0;j<coursesList[i]["courses"].length;j++)
        {
          completedModulesList.add(coursesList[i]["courses"][j]);
        }


      }
    }


    print("Progress Data Complete");


    log(completedModulesList.toString());




    setState(() {

    });


  }

  String fetchDays(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[0]+aStr[1];
  }
  String fetchHours(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[2]+aStr[3];
  }


  String fetchMints(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[4]+aStr[5];
  }
}


import 'dart:async';
import 'dart:convert';

import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/pending_module_tab.dart';
import 'package:airtel_lms/views/quiz/pending_quiz_tab.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:airtel_lms/widgets/tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../search_screen.dart';
import 'course_detail_screen.dart';
import 'courses_names_screen.dart';



class HomeCoursesScreen extends StatefulWidget
{
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<HomeCoursesScreen> with TickerProviderStateMixin
{
  TabController? tabController;
  List<dynamic> courseList=[];
  bool isLoading=false;
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
                        'Courses',
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
            ),

            SizedBox(height: 7),

            Expanded(child:

            isLoading?
            Center(
              child: Loader(),
            ):

            courseList.length==0?

            Center(
              child: Text("No courses found!"),
            ):


            ListView.builder(
                itemCount: courseList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context,int pos)
                {
                  return Column(
                    children: [


                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseDetail(courseList[pos]["id"].toString())));

                        },
                        child: Stack(
                          children: [

                            Container(
                              height: 190,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                 /* image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/dummy7.jpg")
                                  )*/
                              ),

                              child: CachedNetworkImage(
                                imageUrl: courseList[pos]["thumbnail"],
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Container(),
                                errorWidget: (context, url, error) => Image.asset("assets/air_dummy.png",fit: BoxFit.cover),
                              ),
                            ),






                            Container(
                              height: 190,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black.withOpacity(0.3)
                              ),


                            ),

                            Container(

                              height: 190,
                              margin: EdgeInsets.symmetric(horizontal: 12),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 118,
                                        padding: EdgeInsets.symmetric(horizontal: 6),
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: AppTheme.redColor,
                                            border: Border.all(color: Colors.white,width: 1.5),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))
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
                                                SizedBox(height: 1),

                                                Text(
                                                  courseList[pos]["time_left"]!=null?

                                                      fetchDays(courseList[pos]["time_left"]):
                                                  '',
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
                                                SizedBox(height: 1),
                                                Text(
                                                  courseList[pos]["time_left"]!=null?

                                                  fetchHours(courseList[pos]["time_left"]):
                                                  '',
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
                                                SizedBox(height: 1),
                                                Text(
                                                  courseList[pos]["time_left"]!=null?

                                                  fetchMints(courseList[pos]["time_left"]):
                                                  '',
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
                                      ),
                                    ],
                                  ),

                                  Spacer(),

                                  Padding(
                                      padding: const EdgeInsets.only(right: 20,left: 20),
                                      child: Row(

                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Text("Course",style: TextStyle(
                                                  color: Colors.white.withOpacity(0.78),
                                                  fontSize: 12,
                                                )),



                                                Text(courseList[pos]["title"].toString(),style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500
                                                )),

                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 12),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text("Published On",style: TextStyle(
                                                color: Colors.white.withOpacity(0.78),
                                                fontSize: 12,
                                              )),



                                              Text(parseServerFormatDate(courseList[pos]["start_date_time"].toString()),style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500
                                              )),

                                            ],
                                          ),




                                        ],
                                      )
                                  ),

                                  SizedBox(height: 10)

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  );
                }


            ))





          ],
        )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    fetchPendingTasks(context);
  }

  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }

  fetchPendingTasks(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token

    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-courses-list', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    courseList=responseJSON["data"];
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
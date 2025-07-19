import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/api_dialog.dart';
import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/training/training_step2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import 'artifact_screen.dart';

class SelfTrainingScreen extends StatefulWidget {
  String trainingID;
  final double progress;
  final String trainingType;
  SelfTrainingScreen(this.trainingID,this.progress,this.trainingType);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<SelfTrainingScreen> {
  int selectedRadioIndex=9999;
  bool isLoading=false;
  List<dynamic> trainingDataList=[];
  Map<String,dynamic> trainingData={};
  List<dynamic> contentList=[];
  int totalCoursesCount = 0;
  int completedCoursesCount = 0;
  int remainingCoursesCount = 0;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        body: Column(
          children: [


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
                        'Modules',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                  ),





                  SizedBox(width: 36),




                ],
              ),
            ),



            Expanded(
              child:

                  isLoading?
                      Center(
                        child: Loader(),
                      ):

              ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 15),
                  SizedBox(
                    height: 150,
                    child: OverflowBox(
                        minHeight: 220,
                        maxHeight: 220,
                        child:   Lottie.asset("assets/tutorial_anim.json")
                    ),
                  ),


                  SizedBox(height: 17),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      trainingDataList[0]["title"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),


                  SizedBox(height: 5),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [



                        Text(
                          "Published On",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.redColor,
                          ),
                        ),


                        SizedBox(width: 5),



                        Text(
                          parseServerFormatDate(trainingDataList[0]["start_date_time"].toString()),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),



                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainingStep2Screen(widget.trainingID,trainingDataList[0]["training_courses"][0]["training_contents"][0]["id"].toString(),widget.trainingType,trainingDataList[0]["title"])));
                    },
                    child: Container(
                      height: 61,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [

                          SizedBox(width: 25),

                          SizedBox(
                              width:47,
                              height: 47,
                              child: Lottie.asset("assets/play_anim.json",repeat: false)),




                          SizedBox(width: 35),



                          Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [



                              Text(

                                widget.trainingType=="given"?

                                    "Start Training":

                                completedCoursesCount!=0?
                                    "Resume Training":

                                'Start Training',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),

                              ),








                                  Text(
                                'Total Chapters ' +totalCoursesCount.toString(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFB5B6B7),
                                ),

                              ),



                            ],
                          )


                        ],
                      ),
                    ),
                  ),



                  SizedBox(height: 14),



                  Container(
                    color: Color(0xFFF9F9F9),
                    padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),

                        ),

                        SizedBox(height: 12),


                        Row(
                          children: [
                            Expanded(
                              child: LinearPercentIndicator(
                                barRadius: const Radius.circular(6),
                                padding: EdgeInsets.zero,
                                lineHeight: 6.0,
                                percent: widget.trainingType=="given"?0.0:  ((completedCoursesCount * 100) /
                                    totalCoursesCount) /
                                    100,
                                progressColor: Colors.green,
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 12),


                        Row(
                          children: [
                            Text(
                              widget.trainingType=="given"?"0% Completed":
                              (((completedCoursesCount * 100) /
                                  totalCoursesCount))
                                  .toStringAsFixed(0) +
                                  '% Completed',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),

                            ),






                          ],
                        ),

                        SizedBox(height: 5),
                        Divider(
                          color: Color(0xFF707070).withOpacity(0.20),
                        ),


                        SizedBox(height: 5),





                        GestureDetector(
                          onTap: (){
                            courseContentBottomSheet(context);
                       //   fetchCourseContent(context, trainingDataList[0]["training_courses"][0]["training_contents"][0]["id"].toString());

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [

                                Image.asset("assets/tr_ic1.png",width: 28,height: 26),

                                SizedBox(width: 10),



                                Text(
                                  'Course content',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),

                                ),

                                Spacer(),


                                Image.asset("assets/navigat_ic.png",width: 10.1,height:10.1),


                              ],
                            ),
                          ),
                        ),


                     /*   GestureDetector(
                          onTap: (){
                         //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtifactScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [

                                Image.asset("assets/tr_ic2.png",width: 25,height: 20),

                                SizedBox(width: 17),



                                Text(
                                  'Add Artifacts',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),

                                ),

                                Spacer(),


                                Image.asset("assets/navigat_ic.png",width: 10.1,height:10.1),


                              ],
                            ),
                          ),
                        ),*/


                      ],
                    ),

                  )





                ],
              )

            ),













          ],
        )
      ),
    );
  }

  void certificateBottomSheet(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [

                    SizedBox(width: 15),


                    Text("Certificate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),

                    Spacer(),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38)),
                    SizedBox(width: 4),
                  ],
                ),



                SizedBox(
                  height: 160,
                  child: OverflowBox(
                    minHeight: 240,
                    maxHeight: 240,
                    child:  Lottie.asset("assets/cloud_anim.json"),
                  ),
                ),




                Text("Complete training to view or download certificate",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),textAlign: TextAlign.center),


                SizedBox(height: 25),



                Card(
                  elevation: 4,
                  shadowColor:Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 48,
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


                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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


  void aboutTrainingBottomSheet(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [

                    SizedBox(width: 5),


                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("About Training",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ),

                    Spacer(),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38)),
                    SizedBox(width: 4),
                  ],
                ),


                SizedBox(height: 20),



                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5),
                  child: Text("Certification attempts(Maximum "+trainingData["user_certify_detail"]["max_attempt_allowed"].toString()+" attempts are allowed",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),textAlign: TextAlign.center),
                ),


                SizedBox(height: 25),



                Card(
                  elevation: 4,
                  shadowColor:Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 48,
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


                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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


  void courseContentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    SizedBox(width: 100),

                    Text("Course Content",
                        style: TextStyle(
                          fontSize: 16,
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


               Container(
                 height: 250,
                 child: ListView.builder(
                      itemCount:trainingDataList[0]["training_courses"].length,
                     padding: EdgeInsets.symmetric(horizontal: 5),
                     itemBuilder: (BuildContext context,int pos)

                 {
                   return GestureDetector(
                     onTap: (){

                     },
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Row(
                           children: [
                             Icon(Icons.check_circle,color: Color(0xFfFF7C00),size: 16),

                             SizedBox(width: 5),

                             Text("Chapter "+(pos+1).toString(),
                                 style: TextStyle(
                                   fontSize: 11,
                                   fontWeight: FontWeight.w700,
                                   color: Color(0xFF00407E),
                                 )),

                             Spacer(),




                           ],
                         ),



                         Row(
                           children: [
                             Expanded(
                               child: Text(trainingDataList[0]["training_courses"][pos]["title"],
                                   style: TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black,
                                   )),
                             ),


                             SizedBox(
                               width: 60,
                               height: 60,
                               child: OverflowBox(
                                   minHeight: 60,
                                   maxHeight: 60,
                                   child:   Lottie.asset("assets/download_anim.json")
                               ),
                             ),





                           ],
                         ),



                         Text(trainingDataList[0]["training_courses"][pos]["training_contents"][0]["document_type"].toString().toUpperCase(),
                             style: TextStyle(
                               fontSize: 11,
                               fontWeight: FontWeight.w400,
                               color: Colors.black,
                             )),

                         SizedBox(height: 15)

                       ],
                     ),
                   );
                 }


                 ),
               ),






                SizedBox(height: 25),







              ],
            ),
          );
        }

        );

      },
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTrainingData(context);
    fetchCourseContent(context,"2");

  }
  fetchTrainingData(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {"Authorization": AppModel.token,"training_id":widget.trainingID};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-training-modules', data, context);

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    setState(() {
      isLoading = false;
    });
    trainingDataList = responseJSON["data"];
    if(responseJSON.toString().contains("totalCoursesCount"))
      {
        totalCoursesCount = responseJSON["totalCoursesCount"];
        completedCoursesCount = responseJSON["completedCoursesCount"];
        remainingCoursesCount = responseJSON["remainingCoursesCount"];
      }
    else{


      totalCoursesCount= trainingDataList[0]["training_courses"].length;


    }



    setState(() {});
  }


  fetchCourseContent(BuildContext context,String contentID) async {


    var data = {"Authorization": AppModel.token,"training_id":widget.trainingID,"training_content_id":contentID};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-training-modules-content', data, context);



    var responseJSON = json.decode(response.body);
    print(responseJSON);
    contentList = responseJSON["training_contents"];
    totalCoursesCount = responseJSON["totalCoursesCount"];
    completedCoursesCount = responseJSON["completedCoursesCount"];
    remainingCoursesCount = responseJSON["remainingCoursesCount"];
    setState(() {});
    //courseContentBottomSheet(context);
  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }

}

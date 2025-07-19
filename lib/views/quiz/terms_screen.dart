import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/quiz/test_mcq1.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';

import 'package:intl/intl.dart';

import 'final_result_screen.dart';


class MCQTermsScreen extends StatefulWidget {
  final String quizID;
  MCQTermsScreen(this.quizID);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<MCQTermsScreen> {
  int selectedRadioIndex=9999;
 Map<String,dynamic> quizData={};
  late final chewieController;
  bool isLoading=false;
  Map<String,dynamic> trainingData={};
  bool pageNavigator=false;
  bool check=false;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

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

                  isLoading || quizData.isEmpty?


                      Center(
                        child: Loader(),
                      ):




              ListView(
                padding: EdgeInsets.symmetric(horizontal: 13),
                children: [

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Question',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),

                          ),


                          Text(
                            quizData["question_count"].toString()+" Questions",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.redColor,
                            ),

                          ),



                        ],
                      ),

                      Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text(
                            'Quiz Time',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),

                          ),


                          Text(
                            quizData["quize_time"].toString()+" Mins",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.redColor,
                            ),

                          ),



                        ],
                      ),
                    ],
                  ),


                  SizedBox(height: 5),


                  SizedBox(
                    height: 210,
                    child:  Center(
                      child:Lottie.asset("assets/test_anim.json") ,
                    ),
                  ),

                  SizedBox(height: 25),
                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Expanded(child: Text(
                        "Maximum "+quizData["attempts"].toString()+ " attempts are allowed to complete the test",
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ))


                    ],
                  ),


                  SizedBox(height: 7),

                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Expanded(child: Text(
                        "Attempts Remaining : "+quizData["remaining_attempts"].toString(),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ))


                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Text(
                        'Valid from : ',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ),


                      Text(
                          parseServerFormatDate(quizData["valid_from"].toString()),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),

                      )



                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Text(
                        'Valid up to : ',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ),


                      Text(
                        parseServerFormatDate(quizData["valid_up_to"].toString()),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),

                      )



                    ],
                  ),




                  SizedBox(height: 12),

                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Text(
                        'Last attempted : ',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ),


                      Text(
                        parseServerFormatDate(quizData["last_attemted"].toString()),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),

                      )



                    ],
                  ),


                  SizedBox(height: 15),



                  Text(
                    "Total Questions : "+quizData["question_count"].toString(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),

                  ),
                  SizedBox(height: 15),

                  Text(
                    'Please Confirm',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.redColor,
                    ),

                  ),
                  SizedBox(height: 15),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        margin: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Expanded(child: Text(
                        'Make sure you have a good internet connectivity (Test might included images and videos)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ))


                    ],
                  ),


                  SizedBox(height: 7),

                  Row(
                    children: [

                      Container(
                        width: 35.22,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.redColor,width: 2)
                        ),

                        child: Row(

                          children: [

                            Expanded(child: Center(
                              child:   Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            )),



                            Container(
                                height: 21,
                                width: 2,
                                color:AppTheme.redColor,
                            ),



                            Expanded(child: Center(
                              child:   Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.redColor,
                                ),

                              ),
                            ))



                          ],
                        ),

                      ),


                      SizedBox(width: 15),

                      Expanded(child: Text(
                        'Submit test before closing app',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),

                      ))


                    ],
                  ),

                  SizedBox(height: 18),




                  Container(
                    height: 47,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF00407E).withOpacity(0.10)
                    ),

                    child: Row(
                      children: [

                        InkWell(
                          onTap:(){

                            setState(() {
                              check=!check;
                            });
                          },
                          child: Container(

                              child:

                              check?
                              Icon(Icons.check_box,color: Color(0xFF00376A)):

                              Icon(Icons.check_box_outline_blank)),
                        ),

                        SizedBox(width: 12),


                        Expanded(child: Text(
                          'I\'ve read all instructions carefully',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),

                        ))




                      ],
                    ),



                  ),

                  SizedBox(height: 16),

                  InkWell(
                    onTap: (){

                      if(quizData["question_count"].toString()=="0")
                        {
                          Toast.show("Sorry there are no questions in this test!",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red);
                        }
                      else if(quizData["remaining_attempts"].toString()=="0" || quizData["remaining_attempts"].toString().contains("-"))
                        {

                          Toast.show("Sorry no attempts are remaining!",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.black);

                        }


                    /*  else if( quizData["test_result"].toString()=="1")
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalResultScreen(widget.quizID)));

                        }
                      */

                      else
                        {
                          if(check)
                          {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => MCQTest1Screen(widget.quizID)));

                          }
                        }







                    },
                    child: Container(
                      height: 57,
                      color: AppTheme.redColor,
                      child: Center(child:   Text(
                        'Start Test',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),

                      ))
                    ),
                  ),

                  SizedBox(height: 16),
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text("It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38)),
                    SizedBox(width: 4),
                  ],
                ),


               Container(
                 height: 360,
                 child: ListView.builder(
                      itemCount: 4,
                     itemBuilder: (BuildContext context,int pos)

                 {
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Row(
                         children: [
                           Icon(Icons.check_circle,color: Color(0xFfFF7C00),size: 16),

                           SizedBox(width: 5),

                           Text("Chapter 1",
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
                             child: Text("Lorem Ipsum is simply dummy text of",
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



                       Text("PDF",
                           style: TextStyle(
                             fontSize: 11,
                             fontWeight: FontWeight.w400,
                             color: Colors.black,
                           )),

                       SizedBox(height: 15)

                     ],
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
    print("QUIZ ID "+widget.quizID);
    fetchQuizDetails(context);


  }

  fetchQuizDetails(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {
      "Authorization": AppModel.token,
      "test_id": widget.quizID,

    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('my-test', data, context);

    setState(() {
      isLoading = false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    quizData = responseJSON["test"];
    setState(() {});
  }


  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
}



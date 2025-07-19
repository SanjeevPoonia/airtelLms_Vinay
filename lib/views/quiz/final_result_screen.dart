import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:airtel_lms/views/quiz/certicate_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';


class FinalResultScreen extends StatefulWidget {
  final String quizID;
  FinalResultScreen(this.quizID);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<FinalResultScreen> {
  int selectedRadioIndex=9999;
  bool pageNavigator=false;
  bool check=false;
  bool freeTextQuiz=false;
  String remainingAttempts="";
  bool isLoading=false;
  String message="";
  Map<String,dynamic> testResultData={};
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
                      padding: const EdgeInsets.only(left: 0),
                      child: Text(
                        'Test',
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
              isLoading || testResultData.isEmpty?

                  Center(
                    child: Loader(),
                  ):




                  freeTextQuiz?


                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                           message,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),textAlign: TextAlign.center,

                          ),
                        ),
                        SizedBox(height: 25),

                        InkWell(
                          onTap: (){

                            Navigator.pop(context);

                          },
                          child: Container(
                              height: 57,
                              margin: EdgeInsets.symmetric(horizontal: 65),
                              color: AppTheme.redColor,
                              child: Center(child:   Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),

                              ))
                          ),
                        ),


                      ],
                    ):







              ListView(
                padding: EdgeInsets.symmetric(horizontal: 13),
                children: [

                  SizedBox(height: 5),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Test',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),

                          ),


                          Text(
                            testResultData["test"]["type"],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),

                          ),



                        ],
                      ),

                      Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text(
                            'Result',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),

                          ),


                          Text(
                            testResultData["result"]=="Passed"?
                            'Passed':"Failed",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: testResultData["result"]=="Passed"?Color(0xFF2FAE67):Colors.red
                            ),

                          ),



                        ],
                      ),
                    ],
                  ),


                  SizedBox(height: 5),

                 Divider(
                   thickness: 1.5,
                 ),




                 SizedBox(
                   height: 240,
                   child:  Center(
                     child:Lottie.asset(
                         testResultData["result"]=="Passed"?


                         "assets/pass_anim.json":"assets/fail_anim.json") ,
                   ),
                 ),


                  Row(
                    children: [
                     Expanded(child:  Padding(
                       padding: const EdgeInsets.only(right: 10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [

                           Text(
                             'Questions Attempted',
                             style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.w600,
                               color: Color(0xFF708096),
                             ),

                           ),

                           SizedBox(height: 7),


                           Text(
                             testResultData["total_attemted_questions"].toString(),
                             style: TextStyle(
                               fontSize: 17,
                               fontWeight: FontWeight.w700,
                               color: Colors.black,
                             ),

                           ),



                         ],
                       ),
                     ),flex: 1),



                    Container(
                      width: 1.5,
                      height: 55,
                      color: Color(0x1F000000),
                    ),

                    

                    Expanded(child:   Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Unanswered Questions',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF708096),
                            ),

                          ),
                          SizedBox(height: 7),

                          Text(
                            "0",
                              //(int.parse(testResultData["total_attemted_questions"])-int.parse(testResultData["total_questions"])).toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),

                          ),



                        ],
                      ),
                    ),flex: 1)
                    ],
                  ),

                  Container(
                    height: 1.5,
                    color: Color(0x1F000000),
                  ),



                  SizedBox(height: 17),





                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                         TextSpan(
                            text:  testResultData["result"]=="Passed"?'Congrats!! you have scored ':'Oops!! you have scored '),
                         TextSpan(
                            text:
                            testResultData["percentage"].toString().contains(".")?


                            (double.parse( testResultData["percentage"].toString())).toStringAsFixed(2)+'% ':testResultData["percentage"].toString()+'%',
                            style: TextStyle(
                              color:testResultData["result"]=="Passed"? Color(0xFF2FAE67):Colors.red
                            )

                        ),


                        const TextSpan(
                            text: 'marks'),
                      ],
                    ),
                  ),

                  SizedBox(height: 13),


                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                         TextSpan(
                            text: testResultData["result"]=="Passed"?'Now you are eligible for certification':'Now you are not eligible for certification'),

                      ],
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(
                    'You can score more percentage by re-attempting the centification',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,

                  ),



                  SizedBox(height: 13),
                  Text(
                    'Attempt remaining : '+remainingAttempts+' (Questions will change in each attempt)',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(height: 15),




                  testResultData["result"]=="Passed"?

                  InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CertificateScreen(widget.quizID,"quiz")));
                   //   downloadCertificate(context);

                    },
                    child: Container(
                      height: 57,
                      color: Colors.black,
                      child: Center(child:   Text(
                        'Download Certificate',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),

                      ))
                    ),
                  ):Container(),

                  testResultData["result"]=="Passed"?
                  SizedBox(height: 13):Container(),


                  InkWell(
                    onTap: (){

                      Navigator.pop(context);

                    },
                    child: Container(
                        height: 57,
                        color: AppTheme.redColor,
                        child: Center(child:   Text(
                          'Back',
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








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    await helper.postAPI('my-test-result', data, context);

    setState(() {
      isLoading = false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);

    if(responseJSON["message"]=="Test result retrieved")
      {
        testResultData = responseJSON["result"];
      }
    else
      {
        freeTextQuiz=true;
        message=responseJSON["message"];
        testResultData = responseJSON["test_details"];
      }



    remainingAttempts = responseJSON["remaining_attempts"].toString();

    setState(() {});
  }
}

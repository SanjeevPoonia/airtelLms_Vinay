import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/quiz/test_mcq_type2.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/profile_textfield.dart';
import 'final_result_screen.dart';



class MCQTest1Screen extends StatefulWidget {
  final String quizID;
  MCQTest1Screen(this.quizID);
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<MCQTest1Screen> {
  int selectedRadioIndex=9999;
  bool pageNavigator=false;
  bool check=false;
  int _start = 0;
  Timer? _timer;
  List<int> checkList=[];
  List<dynamic> answerList=[];
  var remarkController=TextEditingController();
  String totalTime="";
  int selectedOption=9999;
  bool isLoading=false;
  Map<String,dynamic> trainingData={};
  int currentQuestionIndex=0;
  List<dynamic> quizList=[];
  List<int> checkBoxList=[];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return SafeArea(
      child: Scaffold(

        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

           Expanded(child:


               isLoading?

                   Center(
                     child: Loader(),
                   ):




           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               SizedBox(height: 12),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 13),
                 child:    Row(
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
                           quizList.length.toString()+" Questions",
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
                           formattedTime(timeInSecond: _start),
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
               ),


               Padding(padding: EdgeInsets.symmetric(horizontal: 13),

                 child: Divider(
                   thickness: 1.4,

                 ),

               ),



               SizedBox(height: 3),
               Padding(
                 padding: const EdgeInsets.only(left: 13),
                 child: Text(
                   'Question '+ (currentQuestionIndex+1).toString(),
                   style: TextStyle(
                     fontSize: 11,
                     fontWeight: FontWeight.w600,
                     color: Colors.black,
                   ),

                 ),
               ),
               SizedBox(height: 3),

               Padding(
                 padding: const EdgeInsets.only(left: 13,right: 10),
                 child: Text(
                   quizList[currentQuestionIndex]["question"],
                   style: TextStyle(
                     fontSize: 13.5,
                     fontWeight: FontWeight.w600,
                     color: Colors.black,
                   ),

                 ),
               ),

               SizedBox(height: 12),


               quizList[currentQuestionIndex]["question_type"]=="MCQ"?

               ListView.builder(
                   shrinkWrap: true,
                   itemCount: quizList[currentQuestionIndex]["attributes"].length,
                   itemBuilder: (BuildContext context,int pos)
               {
                 return Column(
                   children: [





                   GestureDetector(
                     onTap:(){
                       setState(() {
                         selectedOption = pos;
                       });
                 },
                     child: Container(
                     margin: EdgeInsets.symmetric(horizontal: 13),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4),
                         color:selectedOption==pos?AppTheme.redColor.withOpacity(0.20):Color(0xFFF2F2F2),
                         border: Border.all(color: Color(0xFF707070),width: 0.3)
                     ),

                     child: Row(
                       children: [


                         SizedBox(width: 10),

                         GestureDetector(
                             onTap: () {
                               
                               if(checkBoxList.contains(quizList[currentQuestionIndex]["attributes"][pos]["id"]))
                                 {
                                   checkBoxList.remove(quizList[currentQuestionIndex]["attributes"][pos]["id"]);
                                 }
                               else
                                 {
                                   checkBoxList.add(quizList[currentQuestionIndex]["attributes"][pos]["id"]);
                                 }
                               
                               
                               setState(() {

                              



                               });
                             },
                             child: checkBoxList.contains(quizList[currentQuestionIndex]["attributes"][pos]["id"])
                                 ? Icon(Icons.check_box,
                                 color: AppTheme.redColor,
                                 size: 23)
                                 : Icon(Icons.check_box_outline_blank,
                                 color: Color(0xFFC6C6C6),
                                 size: 23)),


                         SizedBox(width: 10),

                         Expanded(child: Text(

                           quizList[currentQuestionIndex]["attributes"][pos]["option"],
                           style: TextStyle(
                             fontSize: 14,
                             fontWeight:FontWeight.w500,
                             color:selectedOption==pos?Colors.black:Color(0xFF708096),
                           ),

                         )),

                         SizedBox(width: 6),


                       ],
                     ),


                       padding: EdgeInsets.symmetric(vertical: 10),


                                      ),
                   ),




                     SizedBox(height: 10)

                   ],
                 );
               }


               ):
                   //T\/F

               quizList[currentQuestionIndex]["question_type"]=="SCQ" || quizList[currentQuestionIndex]["question_type"]=="T\/F"?

               ListView.builder(
                   shrinkWrap: true,
                   itemCount:quizList[currentQuestionIndex]["attributes"].length,
                   itemBuilder: (BuildContext context,int pos)
                   {
                     return Column(
                       children: [





                         Container(
                           padding: EdgeInsets.symmetric(vertical: 10),
                           margin: EdgeInsets.symmetric(horizontal: 13),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(4),
                               color:selectedOption==pos?AppTheme.redColor.withOpacity(0.20):Color(0xFFF2F2F2),
                               border: Border.all(color: Color(0xFF707070),width: 0.3)
                           ),

                           child: Row(
                             children: [

                               SizedBox(width: 10),

                               GestureDetector(
                                   onTap: () {
                                     setState(() {
                                       selectedOption = pos;
                                     });
                                   },
                                   child: selectedOption == pos
                                       ? Icon(Icons.radio_button_checked,
                                       color: AppTheme.redColor,
                                       size: 23)
                                       : Icon(Icons.radio_button_off,
                                       color: Color(0xFFC6C6C6),
                                       size: 23)),




                               SizedBox(width: 10),

                               Expanded(child: Text(

                                 quizList[currentQuestionIndex]["attributes"][pos]["option"],
                                 style: TextStyle(
                                   fontSize: 14,
                                   fontWeight:FontWeight.w500,
                                   color:selectedOption==pos?Colors.black:Color(0xFF708096),
                                 ),

                               )),

                               SizedBox(width: 6),


                             ],
                           ),
                         ),




                         SizedBox(height: 10)

                       ],
                     );
                   }


               ):


               quizList[currentQuestionIndex]["question_type"]=="FreeText"?



               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Padding(
                     padding: const EdgeInsets.only(left: 14),
                     child: Text('Remarks',
                         style: TextStyle(
                           fontSize: 13.0,
                           fontWeight: FontWeight.w500,
                           color: AppTheme.redColor,
                         )),
                   ),
                   SizedBox(height: 5),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 14),
                     child: TextFieldWithBorder(
                       labeltext: 'Enter remark here',
                       controller: remarkController,
                       validator: null,
                       enabled: true,
                     ),
                   ),
                 ],
               )



                   :Container()
               ,


               SizedBox(height: 10),





               Spacer(),

               InkWell(
                 onTap: (){

                   if(quizList[currentQuestionIndex]["question_type"]=="MCQ")
                     {
                       if(checkBoxList.length==0)
                       {
                         Toast.show("Please select at least one option to continue!",
                             duration: Toast.lengthLong,
                             gravity: Toast.bottom,
                             backgroundColor: Colors.red);
                       }
                       else
                       {


                         String selectedIDs=checkBoxList.toString();
                         selectedIDs=selectedIDs.substring(1,selectedIDs.length-1);
                         print(selectedIDs.trim());



                         submitSingleAnswer(context, quizList[currentQuestionIndex]["id"].toString(), selectedIDs);
                       }

                     }


                  else if(quizList[currentQuestionIndex]["question_type"]=="SCQ" || quizList[currentQuestionIndex]["question_type"]=="T\/F")
                     {

                       if(selectedOption==9999)
                         {
                           Toast.show("Please select an option to continue!",
                               duration: Toast.lengthLong,
                               gravity: Toast.bottom,
                               backgroundColor: Colors.red);
                         }
                       else
                         {
                           submitSingleAnswer(context, quizList[currentQuestionIndex]["id"].toString(), quizList[currentQuestionIndex]["attributes"][selectedOption]["id"].toString());
                         }


                     }

                   else if(quizList[currentQuestionIndex]["question_type"]=="FreeText")
                     {


                       if(remarkController.text=="")
                       {
                         Toast.show("Please enter remarks to continue!",
                             duration: Toast.lengthLong,
                             gravity: Toast.bottom,
                             backgroundColor: Colors.red);
                       }
                       else
                       {

                       /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                             builder: (BuildContext context) => FinalResultScreen(widget.quizID)));*/



                         submitFreeTextAnswer(context, quizList[currentQuestionIndex]["id"].toString(), remarkController.text.toString());
                       }





                     }

















                   //     Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: MCQTestType2Screen()));

                 },
                 child: Container(
                     height: 57,
                     margin: const EdgeInsets.symmetric(horizontal: 13),
                     color: AppTheme.redColor,
                     child: Center(child:   Text(

                       currentQuestionIndex==quizList.length-1?"Submit":

                       'Next',
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
           ))














          ],
        ),
      ),
    );
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuizDetails(context);


  }


  submitSingleAnswer(BuildContext context,String questionID,String answerID) async {
    APIDialog.showAlertDialog(context, "Please wait...");
    var data = {
      "Authorization": AppModel.token,
      "test_id": widget.quizID,
      "question_id": questionID,
      "answer_id":  answerID
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('my-test-submit-answer', data, context);

    Navigator.pop(context);

    var responseJSON = json.decode(response.body);
    print(responseJSON);


    if(responseJSON["status"]=="success")
    {
      Toast.show("Submitted successfully!",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);



      if(currentQuestionIndex==quizList.length-1)
        {


          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => FinalResultScreen(widget.quizID)));







        }
      else
        {
          selectedOption=9999;
          remarkController.text="";
          currentQuestionIndex=currentQuestionIndex+1;
          checkBoxList.clear();
          setState(() {

          });
        }













    }
    else
    {
      Toast.show(responseJSON["message"],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }







  }



  submitFreeTextAnswer(BuildContext context,String questionID,String answer) async {
    APIDialog.showAlertDialog(context, "Please wait...");
    var data = {
      "Authorization": AppModel.token,
      "test_id": widget.quizID,
      "question_id": questionID,
      "free_text":  answer
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('my-test-submit-answer', data, context);

    Navigator.pop(context);

    var responseJSON = json.decode(response.body);
    print(responseJSON);


    if(responseJSON["status"]=="success")
    {
      Toast.show("Submitted successfully!",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);



      if(currentQuestionIndex==quizList.length-1)
      {


        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => FinalResultScreen(widget.quizID)));







      }
      else
      {
        selectedOption=9999;
        remarkController.text="";
        currentQuestionIndex=currentQuestionIndex+1;
        setState(() {

        });
      }













    }
    else
    {
      Toast.show(responseJSON["message"],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }







  }
  void startTimer(int totalSeconds) {
    print("Time Calklked");
    _start = totalSeconds;
    const oneSec = const Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {


          Toast.show('Sorry the time has completed!',
              duration: Toast.lengthShort,
              gravity: Toast.bottom,
              backgroundColor: Colors.blue);


          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => FinalResultScreen(widget.quizID)));




        } else {
          setState(() {
            _start--;
          });

          print("Start "+_start.toString());
        }
      },
    );
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
    await helper.postAPI('my-test-details', data, context);

    setState(() {
      isLoading = false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    quizList = responseJSON["test"]["questions"];
    totalTime=responseJSON["test"]["time_of_test"].toString();

    int totalTimeAsInt=int.parse(totalTime);
    startTimer(totalTimeAsInt*60);
    setState(() {});
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}

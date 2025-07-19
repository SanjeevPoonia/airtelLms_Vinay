import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';


class ViewFilesScreen extends StatefulWidget {
  final String quizID;
  ViewFilesScreen(this.quizID);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<ViewFilesScreen> {
  int selectedRadioIndex=9999;
  bool pageNavigator=false;
  bool check=false;
  String remainingAttempts="";
  bool isLoading=false;
  Map<String,dynamic> testResultData={};
 // FileViewController? controller;
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

















          ],
        )
      ),
    );
  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // controller= FileViewController.network("https://fieldlms.qdegrees.com/training_document/JUL2024/1721117404-document.pptx");
    //fetchQuizDetails(context);

  }

  downloadCertificate(BuildContext context) async {
    APIDialog.showAlertDialog(context, "Please wait...");
    var data = {
      "Authorization": AppModel.token,
      "test_id": widget.quizID,
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('my-test-certificate', data, context);

    Navigator.pop(context);

    var responseJSON = json.decode(response.body);
    print(responseJSON);


    if(responseJSON["message"]!="Your result is failed, so the certificate is not generated")
    {
    // launch url
    }
    else
    {
      Toast.show(responseJSON["message"],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }







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
    testResultData = responseJSON["test_details"];
    remainingAttempts = responseJSON["remaining_attempts"].toString();

    setState(() {});
  }
}

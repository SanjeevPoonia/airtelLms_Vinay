import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as html;
import 'package:image_picker/image_picker.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../quiz/terms_screen.dart';
import '../vendor_training/add_store_screen.dart';
import 'artifact_screen.dart';

class TrainingStep4Screen extends StatefulWidget {
  String trainingID;
  String contentID;
  String totalCorses;
  String title;
  String desc;
  final String quizID;
  final String type;

  TrainingStep4Screen(
      this.trainingID, this.totalCorses, this.title, this.desc, this.contentID,this.quizID,this.type);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<TrainingStep4Screen> {
  int selectedRadioIndex = 9999;
  File? capturedImage;
  List<dynamic> contentList = [];
  bool isLoading=false;

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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                Expanded(
                  child: Center(
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child:

                widget.desc!="" || widget.desc!=null?

                html.HtmlWidget(widget.desc,textStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )):

               Container()
              ),
              widget.desc == "" ? Container() : SizedBox(height: 35),

              widget.type=="self"?Container():
              InkWell(
                onTap: () {


                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStoreScreen(widget.trainingID)));

                //  _fetchImage(context, 1);
                },
                child: Container(
                  height: 61,
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      SizedBox(
                          width: 42,
                          height: 42,
                          child: Lottie.asset("assets/error_anim.json")),
                      SizedBox(width: 5),
                      Text(
                        'Add Artifacts To Complete Training',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /* InkWell(
                    onTap: (){
                      // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: MCQTermsScreen()));

                    },
                    child: Container(
                      height: 61,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [

                          SizedBox(width: 5),

                          SizedBox(
                              width:47,
                              height: 47,
                              child: Lottie.asset("assets/play_anim.json")),




                          SizedBox(width: 35),



                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [



                              Text(
                                'Final Chapter',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),

                              ),








                              Text(
                                'Begin Test',
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
                  ),*/

              Container(
                color: Color(0xFFF9F9F9),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      color: Color(0xFFF9F9F9),
                      //  padding: EdgeInsets.all(12),
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
                                  percent: 1.0,
                                  progressColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                '100% Completed',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.totalCorses +
                                    "/" +
                                    widget.totalCorses +
                                    ' Chapters',
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
                          GestureDetector(
                            onTap: () {
                             courseContentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Image.asset("assets/tr_ic1.png",
                                      width: 28, height: 26),
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
                                  Image.asset("assets/navigat_ic.png",
                                      width: 10.1, height: 10.1),
                                ],
                              ),
                            ),
                          ),



                         SizedBox(height: 25),


                          widget.quizID!="9999" && widget.type!="given"?

                          Card(
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(widget.quizID)));


                                },
                                child: const Text(
                                  'Take Quiz',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ):Container()
                         /* GestureDetector(
                            onTap: () {
                              _fetchImage(context, 1);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Image.asset("assets/tr_ic2.png",
                                      width: 25, height: 20),
                                  SizedBox(width: 17),
                                  Text(
                                    'View Report & Certiﬁcate',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),


                                  Image.asset("assets/eye_ic.png",
                                      width: 21.1, height: 14.5),

                                  SizedBox(width: 12),

                                  Image.asset("assets/navigat_ic.png",
                                      width: 10.1, height: 10.1),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      )),
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
                      itemCount:contentList[0]["training_courses"].length,
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
                                    child: Text(contentList[0]["training_courses"][pos]["title"],
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



                              Text(contentList[0]["training_courses"][pos]["training_contents"][0]["document_type"].toString().toUpperCase(),
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
    print(widget.type);
    fetchTrainingData(context);
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
    contentList = responseJSON["data"];
    setState(() {});
  }
  _fetchImage(BuildContext context22, int pos) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera,preferredCameraDevice:CameraDevice.front);
    print('Image File From Android' + (image?.path).toString());
    if (image != null) {
      capturedImage = File(image.path);
      setState(() {});

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ArtifactScreen(capturedImage!.path.toString(),widget.trainingID)));
    }
  }
}

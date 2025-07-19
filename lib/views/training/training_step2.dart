import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/training/training_step4.dart';
import 'package:airtel_lms/views/training/view_pdf_screen.dart';
import 'package:airtel_lms/views/webview_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/image_view_screen.dart';
import 'artifact_screen.dart';
import 'full_video_screen.dart';

class TrainingStep2Screen extends StatefulWidget {
  final String trainingID;
  final String contentID;
  final String type;
  final String title;

  TrainingStep2Screen(this.trainingID, this.contentID,this.type,this.title);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<TrainingStep2Screen> {
  int selectedRadioIndex = 9999;
  VideoPlayerController? _controller;
  late final chewieController;
  int totalCoursesCount = 0;
  int completedCoursesCount = 0;
  int remainingCoursesCount = 0;
  double percentage=0.0;
  List<dynamic> coursesList = [];
  List<bool> coursesDoneList=[];
  List<dynamic> contentList = [];
  int currentCourseIndex=0;
  String title = "";
  String desc = "";
  bool pageNavigator = false;
  bool nextPressed=false;
  bool isLoading = false;
  VideoPlayerOptions videoPlayerOptions =
      VideoPlayerOptions(mixWithOthers: true);

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
              child: isLoading
                  ? Center(
                      child: Loader(),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            coursesList[currentCourseIndex]["title"],
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
                          coursesList[currentCourseIndex]["description"]!="" && coursesList[currentCourseIndex]["description"]!=null?
                          HtmlWidget(coursesList[currentCourseIndex]["description"],textStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )):



                          Container()
                        ),





                        coursesList[currentCourseIndex]["description"]==""?Container():
                        SizedBox(height: 35),


                        !nextPressed?



                        InkWell(
                          onTap: () {

                         if(percentage==100)
                           {
                             completeTraining();
                           }
                         else
                           {
                             if(coursesDoneList.contains(false))
                             {

                               Toast.show("Please complete all documents!",
                                   duration: Toast.lengthLong,
                                   gravity: Toast.bottom,
                                   backgroundColor: Colors.red);


                             }
                             else
                             {
                               if(currentCourseIndex==coursesList.length-1)
                               {

                                 if(widget.type=="given")
                                   {
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainingStep4Screen(widget.trainingID,totalCoursesCount.toString(),widget.title,coursesList[currentCourseIndex]["description"],widget.contentID,"9999",widget.type)));

                                   }
                                 else
                                   {
                                     completeTraining();
                                   }





                               }
                               else{



                                 currentCourseIndex=currentCourseIndex+1;
                                 setState(() {

                                 });
                                 if(completedCoursesCount!=totalCoursesCount)
                                 {
                                   completedCoursesCount=completedCoursesCount+1;
                                 }
                                 coursesDoneList.clear();
                                 int totalDocs=coursesList[currentCourseIndex]["training_contents"].length;
                                 for(int i=0;i<totalDocs;i++)
                                 {
                                   coursesDoneList.add(false);
                                 }
                                 setState(() {

                                 });
                               }


                             }

                           }














                          },
                          child: Container(
                            height: 61,
                            color: Colors.black,
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                SizedBox(width: 25),
                                SizedBox(
                                    width: 47,
                                    height: 47,
                                    child:
                                        Lottie.asset("assets/play_anim.json",repeat: false)),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(

                                     currentCourseIndex==coursesList.length-1?
                                     'Complete Training':
                                      'Next Chapter',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),

                                    coursesList.length>1 && currentCourseIndex!=coursesList.length-1?

                                    Text(
                                      coursesList[currentCourseIndex+1]["title"],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFB5B6B7),
                                      ),
                                    ):Container(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ):

                        InkWell(
                          onTap: (){

                            //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: ArtifactScreen()));

                          },
                          child: Container(
                            height: 61,
                            color: Colors.black,
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [

                                SizedBox(width: 5),

                                SizedBox(
                                    width:42,
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
                        SizedBox(height: 10),
                        Container(
                          color: Color(0xFFF9F9F9),
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Resources',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: coursesList[currentCourseIndex]["training_contents"].length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int pos) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {


                                            if(coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="mp4")
                                              {
                                                bool isSkip=false;
                                                print(coursesList[currentCourseIndex]["skip"].toString()+"888888");
                                                if(coursesList[currentCourseIndex]["skip"].toString()=="1")
                                                //No skip
                                                  {
                                                    isSkip=true;
                                                    print(coursesList[currentCourseIndex]["skip"].toString());
                                                  }

                                                coursesDoneList[pos]=true;
                                                if(widget.type!="given")
                                                  {
                                                    completeCourse(context,coursesList[currentCourseIndex]["training_contents"][pos]["id"].toString(),coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]);

                                                  }
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FullVideoScreen(coursesList[currentCourseIndex]["training_contents"][pos]["document"],isSkip)));
                                              }
                                            else if(coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="pptx" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="ppt")
                                              {
                                                coursesDoneList[pos]=true;

                                                if(widget.type!="given")
                                                {
                                                  completeCourse(context,coursesList[currentCourseIndex]["training_contents"][pos]["id"].toString(),coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]);

                                                }

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPPT("https://view.officeapps.live.com/op/embed.aspx?src="+coursesList[currentCourseIndex]["training_contents"][pos]["document"].toString())));
                                              }
                                            else if(coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="pdf")
                                              {

                                                coursesDoneList[pos]=true;
                                                if(widget.type!="given")
                                                {
                                                  completeCourse(context,coursesList[currentCourseIndex]["training_contents"][pos]["id"].toString(),coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]);

                                                }

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFScreen(coursesList[currentCourseIndex]["training_contents"][pos]["document"])));


                                              }
                                            else if(coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="jpg" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="bmp" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="png" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="jpeg")
                                              {
                                                coursesDoneList[pos]=true;

                                                if(widget.type!="given")
                                                {
                                                  completeCourse(context,coursesList[currentCourseIndex]["training_contents"][pos]["id"].toString(),coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]);

                                                }

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(coursesList[currentCourseIndex]["training_contents"][pos]["document"])));

                                              }



                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: AppTheme.redColor,
                                                    width: 1)),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 12),
                                                Image.asset(
                                                    coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="pdf"?
                                                    "assets/pdf_ic.png":
                                                    coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="pptx" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="ppt"?
                                                    "assets/ppt_ic.png":
                                                    coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="jpg" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="bmp" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="png" || coursesList[currentCourseIndex]["training_contents"][pos]["document_type"]=="jpeg"?
                                                     "assets/gallery_ic.png":
                                                    "assets/video_ic.png"


                                                    ,
                                                    width: 28, height: 38),
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Text(
                                                      coursesList[currentCourseIndex]["training_contents"][pos]
                                                              ["document"]
                                                          .toString()
                                                          .split('/')
                                                          .last,
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF00407E),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 55,
                                                  height: 55,
                                                  child: OverflowBox(
                                                      minHeight: 60,
                                                      maxHeight: 60,
                                                      child: Lottie.asset(
                                                          "assets/download_anim.json")),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    );
                                  }),
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
                                            percent:
                                                ((completedCoursesCount * 100) /
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
                                        Spacer(),
                                        Text(
                                          completedCoursesCount.toString() +
                                              "/" +
                                              totalCoursesCount.toString() +
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
                                      color:
                                          Color(0xFF707070).withOpacity(0.20),
                                    ),
                                   /* GestureDetector(
                                      onTap: () {
                                        courseContentBottomSheet(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ArtifactScreen()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/tr_ic2.png",
                                                width: 25, height: 20),
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

  completeCourse(BuildContext context,String docID,String docType) async {

    var data = {
      "Authorization": AppModel.token,
      "training_id": widget.trainingID,
      "document_id": docID,
      "type": docType
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPI('my-training-modules-content-progress', data, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);

/*
    if(responseJSON["status"]=="success")
      {
        Toast.show("Course completed successfully!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.green);

        setState(() {
          currentCourseIndex=currentCourseIndex+1;
        });

      }
    else
      {
        Toast.show("Something went wrong!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
      }*/







  }

  void courseContentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, bottomSheetState) {
          return Container(
            padding: EdgeInsets.all(10),
            // height: 600,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              // Set the corner radius here
              color: Colors.white, // Example color for the container
            ),
            child: Column(
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/cross_ic.png",
                            width: 38, height: 38)),
                    SizedBox(width: 4),
                  ],
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                      itemCount: 6,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (BuildContext context, int pos) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      color: Color(0xFfFF7C00), size: 16),
                                  SizedBox(width: 5),
                                  Text("Chapter " + (pos + 1).toString(),
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
                                    child: Text(
                                        "Lorem Ipsum is simply dummy text of",
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
                                        child: Lottie.asset(
                                            "assets/download_anim.json")),
                                  ),
                                ],
                              ),
                              Text(pos == 0 ? "Video - 01:12 mins" : "PDF",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  )),
                              SizedBox(height: 15)
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 25),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourseContent(context);
  }

  fetchCourseContent(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {
      "Authorization": AppModel.token,
      "training_id": widget.trainingID,
      "training_content_id": widget.contentID
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPI('my-training-modules-content', data, context);

    setState(() {
      isLoading = false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    coursesList = responseJSON["training_courses"];








    contentList = responseJSON["training_contents"];
    totalCoursesCount = responseJSON["totalCoursesCount"];
    if(widget.type=="self")
      {
        completedCoursesCount = responseJSON["completedCoursesCount"];
        remainingCoursesCount = responseJSON["remainingCoursesCount"];
      }
    percentage=(completedCoursesCount * 100) /
    totalCoursesCount;
    print("Percentager "+percentage.toString());
    if(completedCoursesCount!=0 && widget.type=="self")
      {
        currentCourseIndex=completedCoursesCount-1;
      }


    int totalDocs=coursesList[currentCourseIndex]["training_contents"].length;


    for(int i=0;i<totalDocs;i++)
    {
      coursesDoneList.add(false);
    }

    print("Courses Length "+coursesDoneList.length.toString());
    print("Courses Length "+totalDocs.toString());

    setState(() {});
  }

  completeTraining() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var requestModel = {"Authorization": AppModel.token,"training_id":widget.trainingID};

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-training-modules-complated', requestModel, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);

    if (responseJSON['test'] !=null) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainingStep4Screen(widget.trainingID,totalCoursesCount.toString(),widget.title,coursesList[currentCourseIndex]["description"],widget.contentID,responseJSON['test']['test_id'].toString(),widget.type)));



    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainingStep4Screen(widget.trainingID,totalCoursesCount.toString(),widget.title,coursesList[currentCourseIndex]["description"],widget.contentID,"9999",widget.type)));

    }
  }


  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
}

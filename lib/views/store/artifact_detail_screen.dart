

import 'dart:async';
import 'dart:convert';

import 'package:airtel_lms/views/quiz/all_quiz_screen.dart';
import 'package:airtel_lms/views/all_shops_screen.dart';
import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/dashboard_module_widget.dart';
import '../../widgets/image_view_screen.dart';
import '../courses/all_courses_screen.dart';
import '../courses/courses_names_screen.dart';
import '../training/inprogrees_module_screen.dart';
import '../latest_module_screen.dart';



class ArtifactDetailScreen extends StatefulWidget
{
  final String artifactID;
  final String imageUrl;
  ArtifactDetailScreen(this.artifactID,this.imageUrl);
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<ArtifactDetailScreen>
{
  Map<String,dynamic> artifactData={};
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:



      isLoading || artifactData.isEmpty?
      Center(
        child: Loader(),
      ):

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 27),


        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(widget.imageUrl)));

          },
          child: Container(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [



                Container(
                    height: 200,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.imageUrl)
                      ),
                    )

                ),
                Padding(padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [

                    SizedBox(width: 8),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new,color: Colors.white)),

                    Spacer(),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },

                        child: Image.asset("assets/cross_ic.png",width: 33,height: 33)),

                    SizedBox(width: 8),

                  ],
                ),


                )



              ],
            ),
          ),
        ),

          SizedBox(height: 26),




          Expanded(child: ListView(
            padding: EdgeInsets.zero,
            children: [


              Container(

                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xFFF0F0F0)
                ),

                child: Column(
                  children: [
                    SizedBox(height: 10),

                    Row(
                      children: [

                        Text("Store/ Shop Name :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(artifactData["store_name"],style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),


                      ],
                    ),


                    SizedBox(height: 10),

                    Row(
                      children: [

                        Text("Latitude :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(artifactData["latitude"].toString(),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),





                      ],
                    ),

                    SizedBox(height: 10),


                    Row(
                      children: [

                        Text("Longitude :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(artifactData["longitude"].toString(),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),

                      ],
                    ),



                    SizedBox(height: 10),

                    Row(
                      children: [

                        Text("Date & Time :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(parseServerFormatDate(artifactData["date_time"].toString()),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),


                      ],
                    ),
                  ],
                ),


              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Training",style: TextStyle(
                    color: AppTheme.redColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                )),
              ),


              SizedBox(height: 4),


              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text(artifactData["training_name"],style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700
                )),
              ),


              SizedBox(height: 4),

              Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child:

                  artifactData["training_description"]!=null?


                  HtmlWidget(artifactData["training_description"],textStyle: TextStyle(
                    fontSize: 11,

                    color: Colors.black,
                  )):



                  Container()
              ),

              SizedBox(height: 25),

            ],
          ))
        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchArtifactsDetails(context);

  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final timeformat = DateFormat('hh:mm a');
    final clockString = dateformat.format(date);
    final clockString2 = timeformat.format(date);
    return clockString.toString() + " "+ clockString2.toString();
  }
  fetchArtifactsDetails(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token,
      "artifact_id":widget.artifactID

    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('give-training/view-training-artifect', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    artifactData=responseJSON["data"];
    setState(() {

    });


  }




}

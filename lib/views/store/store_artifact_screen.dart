

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
import 'package:intl/intl.dart';
import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/dashboard_module_widget.dart';
import '../courses/all_courses_screen.dart';
import '../courses/courses_names_screen.dart';
import '../search_screen.dart';
import '../training/inprogrees_module_screen.dart';
import '../latest_module_screen.dart';
import 'artifact_detail_screen.dart';



class StoreArtifactScreen extends StatefulWidget
{
  final String storeID;
  final String trainingID;
  StoreArtifactScreen(this.storeID,this.trainingID);
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<StoreArtifactScreen>
{
  List<dynamic> artifactList=[];
  List<String> imageList=[];
  Map<String,dynamic> trainingData={};
  Map<String,dynamic> vendorData={};
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
                    padding: const EdgeInsets.only(right:10),
                    child: Text(
                      'Artifacts',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),



           /*     GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                    },

                    child: Image.asset("assets/search_ic.png",width:20,height: 20)),

                SizedBox(width: 17),
*/



              ],
            ),
          ),
          SizedBox(height: 10),



          Expanded(child:

          isLoading || vendorData.isEmpty?
          Center(
            child: Loader(),
          ):

          artifactList.length==0?

          Center(
            child: Text("No artifacts found!"),
          ):


          ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Training Details',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.5,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 7),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xFFF0F0F0)
                ),

                child: Column(
                  children: [


                    SizedBox(height: 5),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Training Name :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Expanded(
                          child: Text(trainingData["title"],style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.5,
                          )),
                        ),





                      ],
                    ),
                    SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Store/Shop Name :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Expanded(
                          child: Text(vendorData["fullname"],style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.5,
                          )),
                        ),





                      ],
                    ),
                    SizedBox(height: 10),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Address :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Expanded(
                          child: Text(vendorData["address"],style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.5,
                          )),
                        ),


                      ],
                    ),


                    SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("City :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(vendorData["city"],style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),



                        SizedBox(width: 20),




                        Text("Pin code :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(vendorData["pincode"].toString(),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),


                      ],
                    ),


                    SizedBox(height: 10),



                    Row(
                      children: [

                        Text("Contact No. :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(vendorData["mobile_no"].toString(),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),





                      ],
                    ),

                    SizedBox(height: 10),



                    Row(
                      children: [

                        Text("Submission Date :",style: TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 13.5,
                        )),

                        SizedBox(width: 5),

                        Text(
                            artifactList.length==0?"":


                            parseServerFormatDate(artifactList[0]["created_at"].toString()),style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                        )),





                      ],
                    ),




                  ],
                ),


              ),



              Padding(
                padding: const EdgeInsets.only(left: 12,top: 15,bottom: 5),
                child: Text(
                  'Artifacts Uploaded',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.5,
                      color: Colors.black),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                padding: const EdgeInsets.only(left: 5,right: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (2 / 2.5)),
                itemCount:imageList.length,
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtifactDetailScreen(artifactList[0]["id"].toString(),imageList[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Column(
                            children: [

                              Container(
                                height:150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(imageList[index].toString()),
                                        fit: BoxFit.cover
                                    ),
                                    borderRadius: BorderRadius.circular(6)

                                ),
                              ),





                              SizedBox(height: 8),



                            ],
                          )),
                    ),
                  )
                  ;
                  // Item rendering
                },
              )

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
    fetchArtifacts(context);

  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final timeformat = DateFormat('hh:mm a');
    final clockString = dateformat.format(date);
    final clockString2 = timeformat.format(date);
    return clockString.toString() + " "+ clockString2.toString();
  }
  fetchArtifacts(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    //1
    var data = {
      "Authorization": AppModel.token,
      "vendor_id": widget.storeID,
      "training_id":widget.trainingID,

    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('give-training/completed-training-vendor-artifacts', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    artifactList=responseJSON["data"]["artifacts"];
    vendorData=responseJSON["data"]["vendor"];

    Map<String,dynamic> imageData=artifactList[0]["image_urls"];
    print("Image Data Lengfth"+imageData.length.toString());
    
    if(imageData.length==1)
      {
        imageList.add(imageData["1"]);
      }
    else if(imageData.length==2)
      {
        imageList.add(imageData["1"]);
        imageList.add(imageData["2"]);
      }
    
    
    
    

    trainingData=responseJSON["data"]["training"];

    setState(() {

    });


  }


}

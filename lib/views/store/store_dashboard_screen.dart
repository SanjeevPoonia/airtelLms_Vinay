

import 'dart:async';
import 'dart:convert';

import 'package:airtel_lms/views/quiz/all_quiz_screen.dart';
import 'package:airtel_lms/views/all_shops_screen.dart';
import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/store/store_artifact_screen.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_clipper.dart';
import '../../widgets/dashboard_module_widget.dart';
import '../../widgets/textfield_profile_widget.dart';
import '../courses/all_courses_screen.dart';
import '../courses/courses_names_screen.dart';
import '../search_screen.dart';
import '../training/inprogrees_module_screen.dart';
import '../latest_module_screen.dart';
import '../training/start_training_screen.dart';
import '../vendor_training/store_training_screen.dart';



class StoreDashboardScreen extends StatefulWidget
{
  final String trainingID;
  StoreDashboardScreen(this.trainingID);
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<StoreDashboardScreen>
{
  List<dynamic> vendorList=[];
  var startDateController=TextEditingController();
  var endDateController=TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading=false;
  Map<String,dynamic> trainingData={};
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
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'Completed Trainings',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),



              /*  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                    },

                    child: Image.asset("assets/search_ic.png",width:20,height: 20)),*/

                SizedBox(width: 17),




              ],
            ),
          ),
          SizedBox(height: 14),

          Expanded(child:

          isLoading || trainingData.isEmpty?
          Center(
            child: Loader(),
          ):

          ListView(
            padding: EdgeInsets.zero,

            children: [


            Column(
              children: [



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: Text("Training Name",style: TextStyle(
                    color: Colors.brown,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500
                  )),
                ),

                SizedBox(height: 5),

                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 11),

                  child: Text(trainingData["training_name"],style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                      fontWeight: FontWeight.w500
                  )),
                ),

              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),

            SizedBox(height: 12),




              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                children: [



                  Expanded(flex: 1, child: InkWell(
                      onTap: (){
                    //    Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreTrainingScreen(trainingData["store_id"].toString())));

                      },

                      child: DashboardWidgetStore("Completed\nTraining","assets/tiles_2.png",trainingData["total_completed_vendors"].toString()))),


                  SizedBox(width: 8),

                  Expanded(flex: 1, child: InkWell(
                      onTap: (){
                      },

                      child: DashboardWidgetStore("Total\nArtifacts","assets/tiles_8.png",trainingData["artifact_submissions_last_week"].toString()))),


                ],
              ),
            ),

              SizedBox(height: 15),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Shops List",style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                    )),
                  ),

                  Spacer(),

                  GestureDetector(
                    onTap: (){
                      calenderBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(Icons.calendar_month),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),







              ListView.builder(
                  itemCount: vendorList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (BuildContext context,int pos)
                  {
                    return Column(
                      children: [

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreArtifactScreen(vendorList[pos]["vendor_id"].toString(),widget.trainingID)));
                          },
                          child: Stack(
                            children: [


                              CustomPaint(
                                painter: BoxShadowPainter(),
                                child: ClipPath(
                                  clipper: CustomClipperWidget(bottom: 40, holeRadius: 35),
                                  child: Container(
                                    margin: EdgeInsets.only(left:15,right: 15),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),

                                      ),

                                      border: Border.all(width: 0.5,color: AppTheme.redColor),
                                    ),
                                    width: double.infinity,
                                    height: 95,
                                    padding: EdgeInsets.all(5),
                                    child:  Row(
                                      children: [

                                        SizedBox(width: 7),



                                        Expanded(child: Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Padding(padding: EdgeInsets.only(top: 2),
                                              child:  Text(
                                                'Shop/ Store Name',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: AppTheme.redColor),
                                              ),

                                            ),


                                            SizedBox(height: 2),

                                            Text(
                                              vendorList[pos]["vendor_name"],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),




                                            SizedBox(height: 7),


                                            Row(
                                              children: [

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    Text(
                                                      'Pin Code',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: AppTheme.redColor),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text(
                                                        vendorList[pos]["pincode"].toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black),
                                                    ),

                                                  ],
                                                ),

                                                SizedBox(width: 25),






                                              ],
                                            )


                                          ],


                                        ))



                                      ],
                                    ),
                                  ),
                                ),

                              ),


                              Padding(padding: EdgeInsets.only(
                                  top: 39,right: 11
                              ),child:   Row(
                                children: [


                                  Spacer(),
                                  Image.asset("assets/next_ic.png",width: 16.5,height: 16.5)
                                ],
                              ))



                            ],
                          ),
                        ),

                        SizedBox(height: 20),


                      ],
                    );
                  }


              ),




            SizedBox(height: 20),










          ]))



        ],
      )
    );
  }

  void calenderBottomSheet(BuildContext context) {
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
                      child: Text("Select Date",
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
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38,color: Colors.grey)),
                    SizedBox(width: 4),
                  ],
                ),


                SizedBox(height: 20),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);
                          startDate=pickedDate;
                          startDateController.text = formattedDate.toString();
                          setState(() {});
                        }
                      },

                      child: CalenderTextFieldWidget("Start Date","",startDateController,null,enabled: false,suffixIconExists: 1,)),
                ),
                SizedBox(height: 15),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);


                          endDate=pickedDate;


                          endDateController.text = formattedDate.toString();
                          setState(() {});
                        }
                      },

                      child: CalenderTextFieldWidget("End Date","",endDateController,null,enabled: false,suffixIconExists: 1,)),
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
                    height: 51,
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

                        if(startDate!.isAfter(endDate!))
                        {
                          Toast.show("Start date must be less than End date ",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundColor: Colors.red);
                        }
                        else{


                          Navigator.pop(context);



                        }










                      },
                      child: const Text(
                        'Proceed',
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   /* startDateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7)));
    endDateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now());*/
    startDate=DateTime.now().subtract(Duration(days: 27));
    endDate=DateTime.now();
    fetchTrainingData(context);
  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }

  fetchTrainingData(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token,
      "training_id":widget.trainingID,
      "start_date":startDateController.text,
      "end_date":endDateController.text
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('give-training/completed-training-vendor-list', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    vendorList=responseJSON["data"]["vendors"];
    trainingData=responseJSON["data"];
    setState(() {

    });


  }





}

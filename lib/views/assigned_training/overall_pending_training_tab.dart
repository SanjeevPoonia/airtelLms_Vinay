import 'dart:convert';

import 'package:airtel_lms/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../store/store_dashboard_screen.dart';

class OverallPendingTab extends StatefulWidget {
  PendingState createState() => PendingState();
}

class PendingState extends State<OverallPendingTab> {
  List<dynamic> completedTrainingList = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7),
        Expanded(
            child: isLoading
                ? Center(
                    child: Loader(),
                  )
                : completedTrainingList.length == 0
                    ? Center(
                        child: Text("No training tasks available!"),
                      )
                    :  ListView.builder(
                itemCount: completedTrainingList.length,
                padding: EdgeInsets.zero,

                itemBuilder: (BuildContext context,int pos)
                {
                  return Column(
                    children: [

                      GestureDetector(
                        onTap:(){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDashboardScreen(completedTrainingList[pos]["id"].toString())));
                        },
                        child:  Container(
                          margin: EdgeInsets.only(left:9,right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),

                            ),


                          ),
                          width: double.infinity,
                          height: 105,
                          padding: EdgeInsets.all(5),
                          child:  Row(
                            children: [

                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 93,
                                      height: 87,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),

                                      child: CachedNetworkImage(
                                          imageUrl:completedTrainingList[pos]["thumbnail"]??"",
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 93,
                                            height: 87,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),




                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Container(),
                                          errorWidget: (context, url, error){
                                            //air_dummy.png
                                            return Container(
                                              width: 93,
                                              height: 87,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  image: AssetImage("assets/air_dummy.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );

                                          }
                                      ),

                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 8),


                              Expanded(child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(padding: EdgeInsets.only(top: 2),
                                    child:  Text(
                                      'Training Name',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppTheme.redColor),
                                    ),

                                  ),


                                  SizedBox(height: 2),

                                  Text(
                                    completedTrainingList[pos]["title"]??"",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),




                                  SizedBox(height: 5),


                                  Padding(padding: EdgeInsets.only(top: 2),
                                    child:  Text(
                                      'Start Date',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppTheme.redColor),
                                    ),

                                  ),


                                  SizedBox(height: 2),

                                  Text(
                                    parseServerFormatDate(completedTrainingList[pos]["start_date_time"].toString()),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),



                                ],


                              ))



                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),


                    ],
                  );
                }


            ))
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCompletedTasks(context);
  }

  fetchCompletedTasks(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {"Authorization": AppModel.token};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPI('give-training/completed-trainings', data, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    completedTrainingList = responseJSON["data"];
    setState(() {});
  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import 'notification_detail_screen.dart';



class NotificationScreen extends StatefulWidget {
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationScreen> {
  bool showImage = false;
  bool isLoading=false;
  List<dynamic> notificationList=[];
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
                          'Notifications',
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

                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 15),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notificationList.length, // Example content count
                  itemBuilder: (context, pos) {
                    return InkWell(
                      onTap: (){

                        if(notificationList[pos]["read_at"]==null)
                          {
                            readNotification(context,pos);
                          }






                        Navigator.push(context, MaterialPageRoute(builder:(context)=>NotificationDetailScreen(notificationList[pos]["data"]["body"])));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 14,right: 14,top: 6,bottom: 6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:notificationList[pos]["read_at"]!=null? Color(0xFFF5F5F5):AppTheme.redColor.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(8.0), // Set corner radius
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      
                      
                      
                      
                      
                      
                            Row(
                              children: [
                                Text(notificationList[pos]["data"]["greeting"],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                ),
                                Spacer(),
                                Text(parseServerFormatDate(notificationList[pos]["created_at"]),
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(notificationList[pos]["data"]["body"],
                              style: TextStyle(
                                  fontSize: 11,
                      
                                  color: Color(0xFF808080)
                              ),
                            ),
                            SizedBox(height: 6),
                      
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 25)

            ],
          )
      ),
    );
  }

  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
  fetchMyNotifications(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('notifications', data, context);
    setState(() {
      isLoading=false;
    });
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    notificationList=responseJSON["notifications"];
    setState(() {

    });


  }


  readNotification(BuildContext context,int pos) async {

    var data = {
      "Authorization": AppModel.token,
      "notification_id":notificationList[pos]["id"]
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('notification-click', data, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyNotifications(context);
  }

}

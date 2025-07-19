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



class NotificationDetailScreen extends StatefulWidget {
  final String body;
  NotificationDetailScreen(this.body);
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationDetailScreen> {
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(widget.body,
                    style: TextStyle(
                        fontSize: 14,

                        color: Color(0xFF808080)
                    ),
                  ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyNotifications(context);
  }

}

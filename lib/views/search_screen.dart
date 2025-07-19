


import 'dart:convert';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:airtel_lms/views/training/start_training_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../network/api_helper.dart';
import '../utils/app_modal.dart';

class SearchScreen extends StatefulWidget
{
  final bool showBack;
  SearchScreen(this.showBack);
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<SearchScreen>
{
  var searchController=TextEditingController();
  bool isLoading=false;
  List<dynamic> searchResults=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          widget.showBack?
          SizedBox(height: 27):Container(),
          widget.showBack?
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
                      'Search',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),


                SizedBox(width: 17),




              ],
            ),
          ):Container(),

          SizedBox(height: 45),

          Container(
            height: 57,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Color(0xFFF0F0F0)
            ),
            child: TextFormField(
              controller: searchController,
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,

                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: GestureDetector(
                          onTap: (){
                            searchTraining(context);
                          },

                          child: Icon(Icons.search)),
                    ),
                    suffixIconColor: AppTheme.redColor,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0),
                    /*filled: true,
                    fillColor:
                    Color(0xFFF0F0F0),*/
                    hintText: "Search courses,trainings,quiz",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.39),
                    ))),
          ),


          Expanded(child:

              isLoading?

                  Center(
                    child: Loader(),
                  ):



          searchResults.length!=0 && searchController.text!=""?

          ListView.builder(
              itemCount: searchResults.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context,int pos)
              {
                return Column(
                  children: [

                    GestureDetector(
                      onTap:(){

                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(searchResults[pos]["id"].toString(),0.0,"self")));
                      },
                      child: Container(
                        height: 132,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0xFFF7F7F7),
                            border: Border.all(width: 0.5,color: AppTheme.redColor)
                        ),

                        child: Row(
                          children: [

                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      width: 100,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage("assets/air_dummy.png")
                                        ),
                                      )

                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 2),


                            Expanded(child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(padding: EdgeInsets.only(top: 18),
                                      child:  Text(
                                        'Course',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: AppTheme.redColor),
                                      ),

                                    ),

                                    Spacer(),

                                    searchResults[pos]["time_left"]!=null?
                                    Container(
                                      width: 116,
                                      padding: EdgeInsets.symmetric(horizontal: 6),
                                      height: 28,
                                      decoration: BoxDecoration(
                                          color: AppTheme.redColor,
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(4))
                                      ),

                                      child: Row(
                                        children: [

                                          Text(
                                            'Due In',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),


                                          SizedBox(width: 8),
                                          Column(
                                            children: [

                                              Text(
                                                searchResults[pos]["time_left"]!=null?
                                                fetchDays(searchResults[pos]["time_left"]):"",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'Days',
                                                style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),


                                          SizedBox(width: 5),
                                          Column(
                                            children: [

                                              Text(
                                          searchResults[pos]["time_left"]!=null?
                                                fetchHours(searchResults[pos]["time_left"]):"",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'Hours',
                                                style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),


                                          SizedBox(width: 5),
                                          Column(
                                            children: [

                                              Text(
                                          searchResults[pos]["time_left"]!=null?
                                                fetchMints(searchResults[pos]["time_left"]):"",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'Mins',
                                                style: TextStyle(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )


                                        ],
                                      ),
                                    ):Container()



                                  ],
                                ),

                                SizedBox(height: 2),

                                Text(
                                  searchResults[pos]["title"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),

                           

                                SizedBox(height: 7),

                                Text(
                                  'Published On',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppTheme.redColor),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  parseServerFormatDate(searchResults[pos]["start_date_time"].toString()),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),


                              ],


                            ))



                          ],
                        ),


                      ),
                    ),

                    SizedBox(height: 20)



                  ],
                );
              }




          ):







          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/search_anim.json",width: 200,height: 200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text("search for courses,trainings\n and quiz",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),textAlign: TextAlign.center),
              ),

            ],
          ))


        ],
      ),


    );
  }
  
  String fetchDays(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[0]+aStr[1];
  }
  String fetchHours(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[2]+aStr[3];
  }


  String fetchMints(String data){
    String aStr = data.replaceAll(RegExp(r'[^0-9]'),'');
    print(aStr);
    return aStr[4]+aStr[5];
  }
  searchTraining(BuildContext context) async {
   
   
    searchResults.clear();
    setState(() {
      isLoading = true;
    });
    var data = {
      "Authorization": AppModel.token,
      "title": searchController.text
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('search-data', data, context);

    setState(() {
      isLoading = false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    searchResults = responseJSON["data"];
    setState(() {});
  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
}
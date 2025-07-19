

import 'dart:async';
import 'dart:convert';

import 'package:airtel_lms/views/home_screen.dart';
import 'package:airtel_lms/views/login_screen.dart';
import 'package:airtel_lms/views/pending_module_tab.dart';
import 'package:airtel_lms/views/quiz/pending_quiz_tab.dart';
import 'package:airtel_lms/widgets/dashboard_widget.dart';
import 'package:airtel_lms/widgets/tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/dashboard_module_widget.dart';
import '../../widgets/image_view_screen.dart';
import '../search_screen.dart';
import '../training/full_video_screen.dart';
import '../training/view_pdf_screen.dart';
import 'courses_names_screen.dart';



class AllCoursesScreen extends StatefulWidget
{

  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<AllCoursesScreen>
{
  List<dynamic> newsList=[];
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
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      'News',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
                ),








              ],
            ),
          ),

          SizedBox(height: 7),

          Expanded(child:


              isLoading?
                  Center(
                    child: Loader(),
                  ):


                  newsList.length==0?

                      Center(
                        child: Text("No news found!"),
                      ):




          GridView.builder(
            padding: const EdgeInsets.only(left: 5,right: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: (2 / 3)),
            itemCount:newsList.length,
            itemBuilder: (context, index) {
              return  GestureDetector(
                onTap: (){

                  if(newsList[index]["document_type"]=="pdf")
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPDFScreen(newsList[index]["news_document"])));
                  }
                  else if(newsList[index]["document_type"]=="png" || newsList[index]["document_type"]=="jpg" || newsList[index]["document_type"]=="jpeg")
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(newsList[index]["news_document"])));

                  }
                  else if(newsList[index]["type"]=="video")
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FullVideoScreen(newsList[index]["news_document"],false)));

                  }




                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(quizList[index]["id"].toString())));

                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: DashboardModuleWidget22(

                          newsList[index]["start_date"]??"",
                          newsList[index]["news_title"]??"",
                          newsList[index]["news_document"]??"",
                          newsList[index]["document_type"]??"",
                          newsList[index]["type"]??""

                      )),
                ),
              )
              ;
              // Item rendering
            },
          ))





        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNews(context);

  }
  fetchNews(BuildContext context) async {

    setState(() {
      isLoading=true;
    });

    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('news', data, context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    isLoading=false;
    newsList=responseJSON["data"];


    setState(() {

    });


  }



}

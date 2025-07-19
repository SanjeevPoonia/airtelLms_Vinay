
import 'dart:convert';

import 'package:airtel_lms/views/training/start_training_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../search_screen.dart';

class ModuleInProgressScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<ModuleInProgressScreen>
{
  bool isLoading=false;
  List<dynamic> coursesList=[];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
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
                     'In Progress',
                     style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 19,
                         color: Colors.white.withOpacity(0.9)),
                   ),
                 ),
               ),
               ),

           /*    GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                   },

                   child: Image.asset("assets/search_ic.png",width:20,height: 20)),*/

               SizedBox(width: 17),




             ],
           ),
         ),




         Expanded(child:
         isLoading?
         Center(
           child: Loader(),
         ):

         coursesList.length==0?

         Center(
           child: Text("No courses found!"),
         ):

         ListView.builder(
             itemCount: coursesList.length,
             padding: EdgeInsets.only(top: 15),
             itemBuilder: (BuildContext context,int pos)
             {
               return Column(
                 children: [

                   Container(
                     margin: EdgeInsets.symmetric(horizontal: 10),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(4),
                         boxShadow: [
                           BoxShadow(
                             color: Color(0xFFD6D6D6),
                             blurRadius: 6.0,
                           ),
                         ],
                         color: Colors.white

                     ),
                     child: Column(
                       children: [


                         Padding(
                           padding: const EdgeInsets.only(left: 8,top: 12),
                           child: Text(
                             'Course Name',
                             style: TextStyle(
                                 fontSize: 10,
                                 color: AppTheme.redColor),
                           ),
                         ),





                         Padding(
                           padding: const EdgeInsets.only(left: 8),
                           child: Text(
                             coursesList[pos]["title"],
                             style: TextStyle(
                                 fontSize: 13,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black),
                           ),
                         ),

                         SizedBox(height: 12),

                         ListView.builder(
                             itemCount: coursesList[pos]["courses"].length,
                             padding: EdgeInsets.zero,
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemBuilder: (BuildContext context,int pos22)
                             {
                               return Column(
                                 children: [

                                   GestureDetector(
                                     onTap:(){


                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(coursesList[pos]["courses"][pos22]["training_id"].toString(),double.parse(coursesList[pos]["courses"][pos22]["completion_percentage"].toString()),"self")));



                                     },
                                     child: Container(
                                       height: 132,
                                       margin: EdgeInsets.symmetric(horizontal: 8),
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
                                                       'Module Name',
                                                       style: TextStyle(
                                                           fontSize: 10,
                                                           color: AppTheme.redColor),
                                                     ),

                                                   ),

                                                   Spacer(),




                                                   coursesList[pos]["courses"][pos22]["time_left"]!=null?


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

                                                             Text(fetchDays( coursesList[pos]["courses"][pos22]["time_left"]),
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
                                                               fetchHours( coursesList[pos]["courses"][pos22]["time_left"]),
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
                                                               fetchMints( coursesList[pos]["courses"][pos22]["time_left"]),
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
                                                 coursesList[pos]["courses"][pos22]["title"],
                                                 style: TextStyle(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.w500,
                                                     color: Colors.black),
                                               ),

                                               SizedBox(height: 5),

                                               Row(
                                                 children: [
                                                   Text(
                                                     'Status',
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color: AppTheme.redColor),
                                                   ),

                                                   SizedBox(width: 6),

                                                   coursesList[pos]["courses"][pos22]["completion_percentage"]==0?
                                                   Text(
                                                     'Yet to Start',
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color: Colors.black),
                                                   ):

                                                   Text(
                                                     coursesList[pos]["courses"][pos22]["completion_percentage"].toStringAsFixed(0) +"% Completed" ,
                                                     style: TextStyle(
                                                         fontSize: 10,
                                                         color:coursesList[pos]["courses"][pos22]["completion_percentage"]==0 ?Colors.black:Color(0xFF00B90C)),
                                                   )

                                                   ,
                                                 ],
                                               ),

                                               SizedBox(height: 7),
                                               Container(
                                                 margin: EdgeInsets.only(right: 30),
                                                 child: LinearPercentIndicator(
                                                   padding: EdgeInsets.zero,
                                                   lineHeight: 5.0,
                                                   percent:coursesList[pos]["courses"][pos22]["completion_percentage"]==0? 0.0:(coursesList[pos]["courses"][pos22]["completion_percentage"]/100),
                                                   backgroundColor: Color(0xFFEBEBEB),
                                                   barRadius: Radius.circular(6),
                                                   progressColor:Color(0xFF00B90C),
                                                 ),
                                               ),

                                               SizedBox(height: 7),

                                               Text(
                                                 'Published On',
                                                 style: TextStyle(
                                                     fontSize: 10,
                                                     color: AppTheme.redColor),
                                               ),
                                               SizedBox(height: 2),
                                               Text(parseServerFormatDate(coursesList[pos]["courses"][pos22]["created_at"].toString()),
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

                                   SizedBox(height: 12)



                                 ],
                               );
                             }




                         ),

                         SizedBox(height: 10),





                       ],
                       crossAxisAlignment: CrossAxisAlignment.start,
                     ),

                   ),

                   SizedBox(height: 15),


                 ],
               );
             }


         ))



       ],
     ),

   );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchModules(context);
  }

  fetchModules(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('pending-module', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    coursesList=responseJSON["data"];
    setState(() {

    });


  }

  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
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
}
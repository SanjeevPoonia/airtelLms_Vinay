
import 'package:airtel_lms/views/training/start_training_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/app_theme.dart';
import '../search_screen.dart';


class LatestModule2Screen extends StatefulWidget
{
  final List<dynamic> modulesList;
  LatestModule2Screen(this.modulesList);
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<LatestModule2Screen>
{
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
                   padding: const EdgeInsets.only(left: 30),
                   child: Text(
                     'Latest Modules',
                     style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 19,
                         color: Colors.white.withOpacity(0.9)),
                   ),
                 ),
               ),
               ),

               GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(true)));
                   },

                   child: Image.asset("assets/search_ic.png",width:20,height: 20)),

               SizedBox(width: 17),




             ],
           ),
         ),
       //  SizedBox(height: 20),
         Expanded(child:

         widget.modulesList.length==0?

         Center(
           child: Text("No modules found!"),
         ):



         ListView.builder(
             itemCount: widget.modulesList.length,
             itemBuilder: (BuildContext context,int pos)
             {
               return Column(
                 children: [

                   GestureDetector(
                     onTap:(){

                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(widget.modulesList[pos]["training_id"].toString(),0.0,"self")));

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
                             //widget.modulesList[pos]["thumbnail"]
                             children: [
                               Expanded(
                                 child: Container(
                                   width: 100,
                                   margin: EdgeInsets.all(8),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                   ),

                                   child: CachedNetworkImage(
                                       imageUrl:widget.modulesList[pos]["thumbnail"],
                                       imageBuilder: (context, imageProvider) => Container(
                                         width: 100,
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
                                           width: 100,
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
                                               '03',
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
                                               '22',
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
                                               '12',
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
                                   )



                                 ],
                               ),

                               SizedBox(height: 2),

                               Text(
                                 widget.modulesList[pos]["title"],
                                 style: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.w500,
                                     color: Colors.black),
                               ),

                               SizedBox(height: 5),



                               Text(
                                 'Published On',
                                 style: TextStyle(
                                     fontSize: 10,
                                     color: AppTheme.redColor),
                               ),
                               SizedBox(height: 2),
                               Text(
                                 parseServerFormatDate(widget.modulesList[pos]["start_date_time"].toString()),
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




         ))



       ],
     ),

   );
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
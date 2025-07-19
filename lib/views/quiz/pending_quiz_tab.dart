
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airtel_lms/utils/app_theme.dart';

class PendingQuizScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<PendingQuizScreen>
{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
   body: Column(
     children: [
       
       SizedBox(height: 5),
       
       Expanded(child: GridView.builder(
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         padding: const EdgeInsets.only(left: 5,right: 10),
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: 15,

             crossAxisCount: 2,
             childAspectRatio: (2 / 3.7)),
         itemCount:15,
         itemBuilder: (context, index) {
           return  Container(
             margin: EdgeInsets.all(5.0),
             child: ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
                 child: Column(
                   children: [

                     Image.asset("assets/bulb_ic.png"),

                     SizedBox(height: 8),

                     Text("Simply dummy text",style: TextStyle(
                         color: Colors.black,
                         fontSize: 15,
                         fontWeight: FontWeight.w500
                     )),
                     SizedBox(height: 4),




                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("30 Questions ",style: TextStyle(
                           color: Colors.black,
                           fontSize: 13,
                         )),

                         Image.asset("assets/pending_ic.png",width: 12,height: 12),

                         Text(" 30 Min",style: TextStyle(
                           color: Colors.black,
                           fontSize: 13,
                         )),





                       ],
                     ),

                     SizedBox(height: 10),

                     Container(
                       height: 45,
                       width: 135,
                       child: ElevatedButton(
                           style: ButtonStyle(
                               foregroundColor: MaterialStateProperty.all<Color>(
                                   Colors.white),
                               backgroundColor:
                               MaterialStateProperty.all<Color>(
                                   AppTheme.redColor),
                               shape: MaterialStateProperty.all<
                                   RoundedRectangleBorder>(
                                   const RoundedRectangleBorder(
                                     borderRadius: BorderRadius.all(
                                         Radius.circular(4)),
                                     /*   side: BorderSide(
                                                    color: AppTheme.blueColor)*/))),
                           onPressed: () {

                           },
                           child: const Text("Start Quiz", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500))),
                     ),
                   ],
                 )),
           )
           ;
           // Item rendering
         },
       ))
       
       
     ],
   ), 
   );
  }

}
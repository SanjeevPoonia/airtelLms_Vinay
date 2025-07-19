
import 'dart:convert';

import 'package:airtel_lms/views/quiz/terms_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:toast/toast.dart';

import '../../network/api_helper.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../search_screen.dart';

class UnAttemptQuizScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<UnAttemptQuizScreen>
{
  List<dynamic> quizList=[];
  bool isLoading=false;
  String timeLeft="";
  List<int> timeList=[];
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
                     'Unattempt Quiz',
                     style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 19,
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
         SizedBox(height: 20),
         Expanded(child:

         isLoading?
         Center(
           child: Loader(),
         ):

             quizList.length==0?

                 Center(
                   child: Text("No quizes found!"),
                 ):



         GridView.builder(
           padding: const EdgeInsets.only(left: 5,right: 10),
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisSpacing: 10,
               crossAxisCount: 2,
               childAspectRatio: (2 / 3)),
           itemCount:quizList.length,
           itemBuilder: (context, index) {
             return  GestureDetector(
               onTap: (){


                 if(quizList[index]["is_attempt"]=="yes")
                 {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(quizList[index]["id"].toString())));

                 }
                 else
                 {
                   Toast.show("Please read all the documents for course before attempting the test.",
                       duration: Toast.lengthLong,
                       gravity: Toast.bottom,
                       backgroundColor: Colors.red);
                 }





               },
               child: Container(
                 margin: EdgeInsets.all(5.0),
                 child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                     child: Column(
                       children: [

                         Stack(
                           children: [
                            // Image.asset("assets/bulb_ic.png"),

                             CachedNetworkImage(
                               imageUrl:quizList[index]["thumbnail"],
                               progressIndicatorBuilder: (context, url, downloadProgress) =>
                                   Container(),
                               errorWidget: (context, url, error) => Image.asset("assets/air_dummy.png"),
                             ),
                             Column(
                               children: [
                                 
                                 
                                 quizList[index]["timeLeft"]!=null?
                                 
                                 Container(
                                   height: 27,
                                   decoration: BoxDecoration(
                                     color: Colors.white.withOpacity(0.62),
                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
                                   ),

                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [

                                       Text("Due In",style: TextStyle(
                                         color: AppTheme.themeColor,
                                         fontSize: 10,
                                       )),

                                       SizedBox(width: 5),
                                       Text(fetchDays(quizList[index]["timeLeft"])+" : "+fetchHours(quizList[index]["timeLeft"])+" : "+fetchMints(quizList[index]["timeLeft"]),style: TextStyle(
                                         color: AppTheme.themeColor,
                                         fontWeight: FontWeight.w600,
                                         fontSize: 13,
                                       )),



                                     ],
                                   ),
                                 ):Container(),

                                 Row(
                                   children: [
                                     Container(
                                       width: 88,
                                       padding: EdgeInsets.symmetric(horizontal: 6),
                                       height: 22,
                                       decoration: BoxDecoration(
                                           color: AppTheme.redColor,
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                                       ),

                                       child: Row(
                                         children: [

                                           Text(
                                             quizList[index]["test_type"]=="regular_test"?
                                             'Regular Quiz':"Training Quiz",
                                             style: TextStyle(
                                                 fontSize: 10,
                                                 fontWeight: FontWeight.w500,
                                                 color: Colors.white),
                                           ),


                                         ],
                                       ),
                                     ),
                                     Spacer(),


                                   ],
                                 )
                               ],
                             )


                           ],
                         ),

                         SizedBox(height: 8),

                         Text(quizList[index]["title"],style: TextStyle(
                             color: Colors.black,
                             fontSize: 15,
                             fontWeight: FontWeight.w500
                         )),
                         SizedBox(height: 4),




                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(quizList[index]["questions"].toString()+" Questions ",style: TextStyle(
                               color: Colors.black,
                               fontSize: 12,
                             )),

                             Image.asset("assets/pending_ic.png",width: 12,height: 12),
                             SizedBox(width: 3),

                             Text(quizList[index]["time"].toString()+" Mins",style: TextStyle(
                               color: Colors.black,
                               fontSize: 12,
                             )),





                           ],
                         ),

                         SizedBox(height: 10),

                       ],
                     )),
               ),
             )
             ;
             // Item rendering
           },
         ))



       ],
     ),

   );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuizList(context);

  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
  fetchQuizList(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token,
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('unattempted-test', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    quizList=responseJSON["data"];
    setState(() {

    });


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
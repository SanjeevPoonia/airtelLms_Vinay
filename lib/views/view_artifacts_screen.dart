
import 'dart:convert';

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/views/quiz/certicate_screen.dart';
import 'package:airtel_lms/views/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/app_theme.dart';
import '../network/api_helper.dart';
import '../utils/app_modal.dart';

class ViewArtifactScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<ViewArtifactScreen>
{
  List<dynamic> certificatesList=[];
  bool isLoading=false;
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
                     'Certificate',
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
         SizedBox(height: 10),
         Expanded(child:

             isLoading?
                 Center(
                   child: Loader(),
                 ):


         GridView.builder(
           padding: const EdgeInsets.only(left: 5,right: 10),
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisSpacing: 10,
               crossAxisCount: 2,
               childAspectRatio: (2 / 2.4)),
           itemCount:certificatesList.length,
           itemBuilder: (context, index) {
             return  GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CertificateScreen(certificatesList[index]["certificate_name"].toString(),"cert")));
               },
               child: Container(
                 margin: EdgeInsets.all(5.0),
                 child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                     child: Column(
                       children: [

                         Image.asset("assets/cer_dummy.png"),

                         SizedBox(height: 8),

                         Text(certificatesList[index]["certificate_name"],style: TextStyle(
                             color: Colors.black,
                             fontSize: 15,
                             fontWeight: FontWeight.w500
                         )),
                         SizedBox(height: 4),





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
    fetchCertificates(context);
  }

  fetchCertificates(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-certificate', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    certificatesList=responseJSON["data"];
    setState(() {

    });


  }

}

import 'dart:convert';

import 'package:airtel_lms/network/constants.dart';
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
import '../training/start_training_screen.dart';

class PendingTab extends StatefulWidget
{
  final String storeID;
  PendingTab(this.storeID);
  PendingState createState()=>PendingState();
}

class PendingState extends State<PendingTab>
{
  List<dynamic> trainingList=[];
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7),

        Expanded(child:
        isLoading?
        Center(
          child: Loader(),
        ):

        trainingList.length==0?

        Center(
          child: Text("No modules found!"),
        ):
        GridView.builder(
          padding: const EdgeInsets.only(left: 5,right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              childAspectRatio: (2 / 2.5)),
          itemCount:trainingList.length,
          itemBuilder: (context, index) {
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen(trainingList[index]["training_id"].toString(),0.0,"given")));

              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 194,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                 /* image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(AppConstant.imageBaseURL+trainingList[index]["training"]["thumbnail"])
                                  )*/
                              ),

                              child: CachedNetworkImage(
                                imageUrl: AppConstant.imageBaseURL+trainingList[index]["training"]["thumbnail"],

                                imageBuilder: (context, imageProvider) => Container(
                                  width: 194,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
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
                                   width: 194,
                                   height: 150,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(8),
                                     image: DecorationImage(
                                       image: AssetImage("assets/air_dummy.png"),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 );

                                }
                              ),

                            ),


                            Container(
                              width: 194,
                              height: 150,
                              // transform: Matrix4.translationValues(0.0, -3.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        Image.asset("assets/card_ic.png",width:78,height: 20),
                                        Container(
                                          padding: EdgeInsets.only(left: 5,top: 3),
                                          width:94,height: 29,
                                          child: Text(parseServerFormatDate(trainingList[index]["training"]["start_date_time"]),style: TextStyle(
                                              color: Colors.white.withOpacity(0.9),
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),




                                ],
                              ),



                            ),


                          ],
                        ),
                        SizedBox(height: 8),

                        Text(trainingList[index]["training"]["title"],style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),maxLines: 2),




                      ],
                    )),
              ),
            )
            ;
            // Item rendering
          },
        ))
      ],
    );
  }



  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPendingTasks(context);
  }

  fetchPendingTasks(BuildContext context) async {
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token,
      "store_id": widget.storeID,
      "status": 0
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('give-training/store-modules', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    trainingList=responseJSON["data"];
    setState(() {

    });


  }
}

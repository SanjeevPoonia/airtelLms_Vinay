

import 'dart:convert';

import 'package:airtel_lms/network/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toast/toast.dart';

import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/textfield_profile_widget.dart';
import '../search_screen.dart';

class ViewReportsScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<ViewReportsScreen>
{
  Map<String,dynamic> reportsData={};
  bool isLoading=false;
  List<_SalesData> chartData = [

  ];

  double progressPercentage=0;
  double notStartedPercentage=0;
  DateTime? startDate;
  DateTime? endDate;
  double completedPercentage=0;
  double expiredPercentage=0;
  var startDateController=TextEditingController();
  var endDateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Report',
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

          Expanded(child:

          isLoading || reportsData.isEmpty?

              Center(
                child: Loader(),
              ):

          ListView(
            children: [



              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      parseServerFormatDate(startDate.toString())+" - "+parseServerFormatDate(endDate.toString()),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),

                  Spacer(),

                  GestureDetector(
                    onTap: (){
                      calenderBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(Icons.calendar_month),
                    ),
                  )
                ],
              ),


              SizedBox(height: 15),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            SizedBox(height: 15),
                        
                        
                            Text(
                              'My Courses',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                        
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  reportsData["my_training"]["count"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),
                        
                                SizedBox(width: 10),
                        
                                Icon(Icons.arrow_upward,color: Color(0xFF68BC5E),size: 14),
                        
                                SizedBox(width: 4),
                        
                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF68BC5E)),
                                ),
                        
                              ],
                            ),
                        
                            SizedBox(height: 5),
                        
                        
                            Text(
                              'Total Courses : '+reportsData["my_training"]["total"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),
                          ],
                        ),
                      ),
                      
                      Image.asset("assets/graph_2.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),

              SizedBox(height: 11),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 15),


                            Text(
                              'My Quiz',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                            reportsData["my_quiz"]["count"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),

                                SizedBox(width: 10),

                                Icon(Icons.arrow_downward,color: Colors.red,size: 14),

                                SizedBox(width: 4),

                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.red),
                                ),

                              ],
                            ),

                            SizedBox(height: 5),


                            Text(
                              'Total Quiz : '+reportsData["my_quiz"]["total"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),
                          ],
                        ),
                      ),

                      Image.asset("assets/graph_1.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),

              SizedBox(height: 11),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 15),


                            Text(
                              'My Certificate',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  reportsData["my_certificate"]["count"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),

                                SizedBox(width: 10),

                                Icon(Icons.arrow_downward,color:Color(0xFF68BC5E),size: 14),

                                SizedBox(width: 4),

                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF68BC5E)),
                                ),

                              ],
                            ),

                            SizedBox(height: 2),


                            Text(
                              'Attempted : '+reportsData["my_certificate"]["attempted"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),


                            SizedBox(height: 5),


                            Text(
                              'Failed : '+reportsData["my_certificate"]["failed"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),
                          ],
                        ),
                      ),

                      Image.asset("assets/graph_3.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),


              SizedBox(height: 11),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 15),


                            Text(
                              'Incomplete Courses',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  (reportsData["my_training"]["total"] - reportsData["my_training"]["count"]).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),

                                SizedBox(width: 10),



                              ],
                            ),

                            SizedBox(height: 5),


                          ],
                        ),
                      ),

                      Image.asset("assets/graph_1.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),

              SizedBox(height: 11),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 15),


                            Text(
                              'Shop/Store',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  reportsData["shop_store"]["count"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),

                                SizedBox(width: 10),

                                Icon(Icons.arrow_upward,color: Color(0xFF68BC5E),size: 14),

                                SizedBox(width: 4),

                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF68BC5E)),
                                ),

                              ],
                            ),

                            SizedBox(height: 5),


                            Text(
                              'Total Stores: '+reportsData["shop_store"]["total"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),
                          ],
                        ),
                      ),

                      Image.asset("assets/graph_2.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),

              SizedBox(height: 11),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 15),


                            Text(
                              'Given Courses',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  reportsData["training_given"]["count"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      color: Colors.black),
                                ),

                                SizedBox(width: 10),

                                Icon(Icons.arrow_upward,color: Color(0xFF68BC5E),size: 14),

                                SizedBox(width: 4),

                                Text(
                                  '2.5%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF68BC5E)),
                                ),

                              ],
                            ),

                            SizedBox(height: 5),


                            Text(
                              'Total Training : '+ reportsData["training_given"]["count"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFFB7B6B6)),
                            ),
                          ],
                        ),
                      ),

                      Image.asset("assets/graph_3.png",width: 150,height: 120,),

                      SizedBox(width: 15)
                    ],
                  ),
                ),


              ),


              SizedBox(height: 25),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                //   height: 112,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD6D6D6),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.white

                ),

                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  //Initialize the chart widget
                                  child: SfCircularChart(
                                      palette: <Color>[
                                        Color(0xFFD88542),
                                        Color(0xFF78A1CC),
                                        Color(0xFFEBB560),
                                        Color(0xFFCB5E5C)

                                        ],
                                     margin: EdgeInsets.zero,
                                      backgroundColor: Colors.white,
                                      onDataLabelRender: (DataLabelRenderArgs args) {
                                        double value = double.parse(args.text!);
                                        args.text = value.toStringAsFixed(0);
                                      },
                                      series: <CircularSeries<_SalesData, String>>[
                                        PieSeries<_SalesData, String>(
                                            selectionBehavior: SelectionBehavior(enable: true),
                                            explode: true,
                                            explodeIndex: 0,
                                            dataSource: chartData,
                                            xValueMapper: (_SalesData sales, _) => sales.year,
                                            yValueMapper: (_SalesData sales, _) => sales.sales,
                                            name: 'Sales',
                                            dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                            ))
                                      ]),
                                ),
                              ),

                              Text(
                                'Total : 100',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),


                              SizedBox(width: 15)
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                             Row(
                               children: [

                                 Container(
                                   width: 20,
                                   height: 20,
                                   decoration: BoxDecoration(
                                       color: Color(0xFFCB5E5C)
                                   ),
                                 ),

                                 SizedBox(width: 6),

                                 Text(
                                   'In Progress - '+progressPercentage.toStringAsFixed(0)+"%",
                                   style: TextStyle(
                                       fontWeight: FontWeight.w500,
                                       fontSize: 14,
                                       color: Colors.black),
                                 ),

                               ],
                             ),

                                Row(
                                  children: [

                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFD88542)
                                      ),
                                    ),

                                    SizedBox(width: 6),

                                    Text(
                                      'Not Started - '+notStartedPercentage.toStringAsFixed(0)+"%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),

                                  ],
                                )



                              ],
                            ),
                          ),


                          SizedBox(height: 22),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Row(
                                  children: [

                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEBB560)
                                      ),
                                    ),

                                    SizedBox(width: 6),

                                    Text(
                                      'Completed - '+completedPercentage.toStringAsFixed(0)+"%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),

                                  ],
                                ),

                                Row(
                                  children: [

                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF78A1CC)
                                      ),
                                    ),

                                    SizedBox(width: 6),

                                    Text(
                                      'Expired - '+expiredPercentage.toStringAsFixed(0)+"%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),


                                    SizedBox(width: 27)

                                  ],
                                )



                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 15),
                      child: Text(
                        'Learning Master',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ),


              SizedBox(height: 25),


            ],
          ))



        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 27)));
    endDateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDate=DateTime.now().subtract(Duration(days: 27));
    endDate=DateTime.now();

    fetchReportData(context);
  }


  void calenderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context,bottomSheetState)
        {
          return Container(
            padding: EdgeInsets.all(10),
            // height: 600,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)), // Set the corner radius here
              color: Colors.white, // Example color for the container
            ),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),

                Center(
                  child: Container(
                    height: 6,
                    width: 62,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [

                    SizedBox(width: 5),


                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Select Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ),

                    Spacer(),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/cross_ic.png",width: 38,height: 38,color: Colors.grey)),
                    SizedBox(width: 4),
                  ],
                ),


                SizedBox(height: 20),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);
                          startDate=pickedDate;
                          startDateController.text = formattedDate.toString();
                          setState(() {});
                        }
                      },

                      child: CalenderTextFieldWidget("Start Date","",startDateController,null,enabled: false,suffixIconExists: 1,)),
                ),
                SizedBox(height: 15),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);


                          endDate=pickedDate;


                          endDateController.text = formattedDate.toString();
                          setState(() {});
                        }
                      },

                      child: CalenderTextFieldWidget("End Date","",endDateController,null,enabled: false,suffixIconExists: 1,)),
                ),

                SizedBox(height: 25),



                Card(
                  elevation: 4,
                  shadowColor:Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 51,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white), // background
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              AppTheme.redColor), // fore
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ))),
                      onPressed: () {

                        if(startDate!.isAfter(endDate!))
                          {
                            Toast.show("Start date must be less than End date ",
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom,
                                backgroundColor: Colors.red);
                          }
                        else{


                          Navigator.pop(context);

                          fetchReportData(context);

                        }










                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 15),



              ],
            ),
          );
        }

        );

      },
    );
  }

  fetchReportData(BuildContext context) async {
     progressPercentage=0;
     notStartedPercentage=0;
     completedPercentage=0;
     expiredPercentage=0;
     chartData.clear();
    setState(() {
      isLoading=true;
    });
    var data = {
      "Authorization": AppModel.token,
      "start_date": startDateController.text,
      "end_date": endDateController.text
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('overall-report', data, context);
    isLoading=false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    reportsData=responseJSON["data"];


 /*   _SalesData('Jan', 65),
    _SalesData('Feb', 38),
    _SalesData('Mar', 24),
    _SalesData('Apr', 42),*/


   int in_progress=reportsData["learning_master"]["in_progress"];
    int not_started=reportsData["learning_master"]["not_started"];
    int completed=reportsData["learning_master"]["completed"];
    int expired=reportsData["learning_master"]["expired"];
    int total=reportsData["learning_master"]["total"];
    
    
    if(progressPercentage!=0)
      {
        progressPercentage=(in_progress*100)/total;
      }

     if(notStartedPercentage!=0)
     {
       notStartedPercentage=(not_started*100)/total;
     }
     if(completedPercentage!=0)
     {
       completedPercentage=(completed*100)/total;
     }

     if(expiredPercentage!=0)
     {
       expiredPercentage=(expired*100)/total;
     }
    chartData.add(_SalesData('Feb', notStartedPercentage));
    chartData.add(_SalesData('Apr', expiredPercentage));

    chartData.add(_SalesData('Mar', completedPercentage));

    chartData.add(_SalesData('Jan', progressPercentage));


    setState(() {

    });


  }

  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final clockString = dateformat.format(date);
    return clockString.toString();
  }

}


class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
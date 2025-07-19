
import 'package:airtel_lms/views/store/store_dashboard_screen.dart';
import 'package:airtel_lms/views/assigned_training/overall_pending_training_tab.dart';
import 'package:airtel_lms/views/assigned_training/today_pending_training_tab.dart';
import 'package:airtel_lms/views/vendor_training/completed_training_tab.dart';
import 'package:airtel_lms/views/vendor_training/pending_training_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/app_theme.dart';
import '../../widgets/tab_indicator.dart';
import '../search_screen.dart';



class StoreTrainingScreen extends StatefulWidget
{
  final String trainingID;
  StoreTrainingScreen(this.trainingID);
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<StoreTrainingScreen> with TickerProviderStateMixin
{
  TabController? tabController;
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
                     'Given Training List',
                     style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 17,
                         color: Colors.white.withOpacity(0.9)),
                   ),
                 ),
               ),
               ),




               SizedBox(width: 17),




             ],
           ),
         ),


         Container(
           height: 55,
           color: Color(0xFFECECEC),
          // margin: EdgeInsets.symmetric(horizontal: 20),
           padding: const EdgeInsets.only(bottom: 5),
           child: TabBar(
             //isScrollable: true,
             labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
             indicatorColor: AppTheme.redColor,
             indicatorWeight: 4,
             dividerColor: Colors.transparent,
             unselectedLabelStyle: TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.w400
             ),
             unselectedLabelColor: Colors.black,
             indicatorSize: TabBarIndicatorSize.label,
             indicator: TabBarIndicator(color: AppTheme.redColor, radius: 2),
             labelColor: Colors.black87,
             labelStyle:
             const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
             controller: tabController,
             tabs: const [
               Tab(
                 text: 'Pending Modules',
               ),
               Tab(
                 text: 'Completed Modules',
               ),
             ],
           ),
         ),
         Expanded(
           child: TabBarView(
             controller: tabController,
             children: [


               PendingTab(widget.trainingID),

               CompletedTab(widget.trainingID),


             ],
           ),
         ),



       ],
     ),
   );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }
}


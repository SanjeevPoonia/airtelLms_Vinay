

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class DashboardWidget extends StatelessWidget
{
  final String title;
  final String imagePath;
  final String totalCount;
  final String pendingCount;
  final String completeCount;
  DashboardWidget(this.title,this.imagePath,this.totalCount,this.pendingCount,this.completeCount);
  @override
  Widget build(BuildContext context) {
    return Container(
    //  padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFfF9F9F9),
      ),
      height: 113,
      child: Stack(

        children: [

          Row(
            children: [


              Spacer(),
              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  child: Image.asset(imagePath,width: 93,height: 111))
            ],
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 9),


              Padding(
                padding:  EdgeInsets.only(left: 5),
                child: Text(title,style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(totalCount,style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                height: 1.4,
                color: Color(0xFFE1E1E1),
              ),

              Row(

                children: [

                  Text('Pending',style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),

                  SizedBox(width: 5),

                  Text(pendingCount,style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.redColor,
                  )),

                  SizedBox(width: 10),



                  Text('Completed',style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),

                  SizedBox(width: 5),

                  Text(completeCount,style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.redColor,
                  )),


                ],


              )









            ],
          ),
        ],
      ),
    );
  }

}


class DashboardWidget3 extends StatelessWidget
{
  final String title;
  final String imagePath;
  final String totalCount;
  final String pendingCount;
  final String completeCount;
  DashboardWidget3(this.title,this.imagePath,this.totalCount,this.pendingCount,this.completeCount);
  @override
  Widget build(BuildContext context) {
    return Container(
      //  padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFfF9F9F9),
      ),
      height: 113,
      child: Stack(

        children: [

          Row(
            children: [


              Spacer(),
              Container(
                 // transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  child: Image.asset(imagePath,width: 93,height: 111))
            ],
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 9),


              Padding(
                padding:  EdgeInsets.only(left: 5),
                child: Text(title,style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(totalCount,style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
                height: 1.4,
                color: Color(0xFFE1E1E1),
              ),

              Row(

                children: [

                  Text('Pending',style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),

                  SizedBox(width: 5),

                  Text(pendingCount,style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.redColor,
                  )),

                  SizedBox(width: 10),



                  Text('Completed',style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),

                  SizedBox(width: 5),

                  Text(completeCount,style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.redColor,
                  )),


                ],


              )









            ],
          ),
        ],
      ),
    );
  }

}



class DashboardWidget2 extends StatelessWidget
{
  final String title;
  final String imagePath;
  final String count;
  DashboardWidget2(this.title,this.imagePath,this.count);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFfF9F9F9),
      ),
      height: 113,
      child: Stack(
        children: [

          Row(
            children: [


              Spacer(),
              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  child: Image.asset(imagePath,width: 93,height: 111,))
            ],
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 9),


              Padding(
                padding:  EdgeInsets.only(left: 5),
                child: Text(title,style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(count,style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ),










            ],
          ),
        ],
      ),
    );
  }

}


class DashboardWidgetStore extends StatelessWidget
{
  final String title;
  final String imagePath;
  final String count;
  DashboardWidgetStore(this.title,this.imagePath,this.count);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFfF9F9F9),
      ),
      height: 124,
      child: Stack(
        children: [

          Row(
            children: [


              Spacer(),
              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  child: Image.asset(imagePath,width: 93,height: 111,))
            ],
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 9),


              Padding(
                padding:  EdgeInsets.only(left: 5),
                child: Text(title,style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(count,style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ),



              SizedBox(height: 2),

              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text("Last 7 days",style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
              ),

              SizedBox(height: 5),

            ],
          ),
        ],
      ),
    );
  }

}
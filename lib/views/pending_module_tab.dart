
import 'package:airtel_lms/utils/app_theme.dart';
import 'package:airtel_lms/views/training/start_training_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PendingModuleTab extends StatefulWidget
{
  PendingState createState()=>PendingState();
}

class PendingState extends State<PendingModuleTab>
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7),

        Expanded(child: ListView.builder(
            itemCount: 8,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context,int pos)
        {
          return Column(
            children: [

              GestureDetector(
                onTap:(){

               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfTrainingScreen()));
          },
                child: Container(
                  height: 132,
                  margin: EdgeInsets.symmetric(horizontal: 12),
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
                                  'Course',
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
                            'Simply dummy text of the',
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

                              pos%2==0?
                              Text(
                                '68% Completed',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF00B90C)),
                              ):

                              Text(
                                'Not Startd',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black),
                              ),
                            ],
                          ),

                          SizedBox(height: 7),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              lineHeight: 5.0,
                              percent: pos%2==0?0.68:0.0,
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
                          Text(
                            '21/05/2024',
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

              SizedBox(height: 20)



            ],
          );
        }




        ))
      ],
    );
  }

}

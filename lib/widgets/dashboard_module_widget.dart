

import 'package:airtel_lms/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardModuleWidget extends StatelessWidget
{
  final String startDate;
  final String title;
  final String imagePath;
  DashboardModuleWidget(this.startDate,this.title,this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 194,
          height: 295,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(),
            errorWidget: (context, url, error) => Image.asset("assets/air_dummy.png",fit: BoxFit.cover),
          ),

        ),


        Container(
          width: 194,
          height: 295,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.4)

          ),

        ),

        Container(
          width: 194,
          height: 295,
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
                      child: Text(startDate,style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 9,
                          fontWeight: FontWeight.w500
                      )),
                    ),
                  ],
                ),
              ),

              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Text(title,style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700
                )),
              ),

              SizedBox(height: 10)


            ],
          ),



        ),


      ],
    );
  }

}

class DashboardModuleWidget22 extends StatelessWidget
{
  final String startDate;
  final String title;
  final String imagePath;
  final String docType;
  final String type;
  DashboardModuleWidget22(this.startDate,this.title,this.imagePath,this.docType,this.type);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [



            docType=="pdf"?

                Container(
                  height: 145,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 0.6),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Image.asset("assets/pdf_ic.png",width: 60,height: 60),
                  ),
                ):



            docType=="png" || docType=="jpg" || docType=="jpeg"?






            Container(

              height: 145,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imagePath)
                  )
              ),

            ):

            type=="video"?

            Container(

              height: 145,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
              ),

              child: Center(
                child:Icon(Icons.play_circle,size: 35)
              ),

            ):Container()


            ,


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
                          child: Text("09 May 2024",style: TextStyle(
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

        Text(title,style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500
        )),

      ],
    );
  }

}

class DashboardModuleWidget2 extends StatelessWidget
{
  int type;
  DashboardModuleWidget2(this.type);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(

              height: 145,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(type==1?"assets/dummy1.png":"assets/dummy3.png")
                  )
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
                          child: Text("09 May 2024",style: TextStyle(
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

        Text("#Nugget_201",style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500
        )),

      ],
    );
  }

}


class DashboardCompletedWidget extends StatelessWidget
{
  final String startDate;
  final String title;
  final String imagePath;
  DashboardCompletedWidget(this.startDate,this.title,this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 194,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

              ),

              child: CachedNetworkImage(
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(),
                errorWidget: (context, url, error) => Image.asset("assets/air_dummy.png",fit: BoxFit.cover),
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
                          child: Text(startDate,style: TextStyle(
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

        Text(title,style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500
        )),


        SizedBox(height: 3),

        Text("Completed",style: TextStyle(
          color: Color(0xFF00B90C),
          fontSize: 11,

        )),

      ],
    );
  }

}




class DashboardInProgressWidget extends StatelessWidget
{
  final String startDate;
  final String title;
  final String imagePath;
  final double percentage;

  DashboardInProgressWidget(this.startDate,this.title,this.imagePath,this.percentage);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 194,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // AssetImage("assets/air_dummy.png")

              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(),
                errorWidget: (context, url, error) => Image.asset("assets/air_dummy.png",fit: BoxFit.cover),
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
                          child: Text(startDate,style: TextStyle(
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

        Text(title,style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500
        )),


        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10,right: 5),
          child:  LinearPercentIndicator(
            lineHeight: 4.0,
            percent:percentage==0?0.0:percentage/100,
            barRadius: Radius.circular(5),
            progressColor:Color(0xFF1FC129),
          ),
        ),


        SizedBox(height: 6),

        Text(percentage.toStringAsFixed(0)+"% Completed",style: TextStyle(
            color: percentage==0?AppTheme.redColor:Color(0xFF00B90C),
            fontSize: 11,

        )),

      ],
    );
  }

}
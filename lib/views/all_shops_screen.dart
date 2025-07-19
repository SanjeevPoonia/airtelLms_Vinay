
import 'package:airtel_lms/views/search_screen.dart';
import 'package:airtel_lms/views/store/store_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_theme.dart';
import '../widgets/custom_clipper.dart';

class AllShopsScreen extends StatefulWidget
{
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<AllShopsScreen>
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
                     'Shop/ Store',
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


         SizedBox(height: 15),

          Expanded(child: ListView.builder(
              itemCount: 7,
              padding: EdgeInsets.zero,

              itemBuilder: (BuildContext context,int pos)
          {
            return Column(
              children: [

                GestureDetector(
                  onTap:(){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDashboardScreen()));
            },
                  child: Stack(
                    children: [


                      CustomPaint(
                        painter: BoxShadowPainter(),
                        child: ClipPath(
                          clipper: CustomClipperWidget(bottom: 40, holeRadius: 35),
                          child: Container(
                            margin: EdgeInsets.only(left:9,right: 15),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),

                              ),

                              border: Border.all(width: 0.5,color: AppTheme.redColor),
                            ),
                            width: double.infinity,
                            height: 95,
                            padding: EdgeInsets.all(5),
                            child:  Row(
                              children: [

                                Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          width: 93,
                                          height: 87,
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

                                SizedBox(width: 8),


                                Expanded(child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(padding: EdgeInsets.only(top: 2),
                                      child:  Text(
                                        'Shop/ Store Name',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: AppTheme.redColor),
                                      ),

                                    ),


                                    SizedBox(height: 2),

                                    Text(
                                      'Simply dummy text of the',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),




                                    SizedBox(height: 7),


                                    Row(
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Training',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppTheme.redColor),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              '15',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),

                                          ],
                                        ),

                                        SizedBox(width: 25),



                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Quiz',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppTheme.redColor),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              '5',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),

                                          ],
                                        ),


                                        SizedBox(width: 25),


                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Certificate',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppTheme.redColor),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              '3',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),

                                          ],
                                        )



                                      ],
                                    )


                                  ],


                                ))



                              ],
                            ),
                          ),
                        ),

                      ),


                      Padding(padding: EdgeInsets.only(
                          top: 39,right: 11
                      ),child:   Row(
                        children: [


                          Spacer(),
                          Image.asset("assets/next_ic.png",width: 16.5,height: 16.5)
                        ],
                      ))



                    ],
                  ),
                ),

                SizedBox(height: 20),


              ],
            );
          }


          ))




       ],
     ),
   );
  }

}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(50, 50)

     /* ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - 100)
      ..arcToPoint(
        Offset(size.width, size.height -100 - 35),
        clockwise: true,
        radius: Radius.circular(1),
      )*/

      ..lineTo(size.width-15, size.height-25)
      ..arcToPoint(
        Offset(size.width-15, size.height - 35 - 35),
        clockwise: true,
        radius: Radius.circular(1),
      );


   // path.lineTo(0.0, 0.0);

    path.close();


    Paint paintBorder = Paint()
      ..color = AppTheme.redColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
   // canvas.drawColor(Colors.green, BlendMode.darken);
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
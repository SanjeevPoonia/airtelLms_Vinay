
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:airtel_lms/network/loader.dart';
import 'package:airtel_lms/widgets/dashed_border_widfget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:toast/toast.dart';

import '../../network/Utils.dart';
import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../utils/app_modal.dart';
import '../../utils/permission_utils.dart';

class CertificateScreen extends StatefulWidget
{
  final String quizID;
  final String type;
  CertificateScreen(this.quizID,this.type);
  ModuleState createState()=>ModuleState();
}
class ModuleState extends State<CertificateScreen>
{
  GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading=false;
  String title="";
  String? name="";
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
   return Scaffold(
     backgroundColor: Colors.white,
     body:

         isLoading?

             Center(
               child: Loader(),
             ):

         Container(
           color: Colors.white,
           child: Column(
             children: [

               SizedBox(height: 60),

               Stack(
                 children: [
                   SizedBox(
                     height: 150,
                     child: OverflowBox(
                         minHeight: 220,
                         maxHeight: 220,
                         child:   Lottie.asset("assets/cer_anim.json")
                     ),
                   ),

                   Row(
                     children: [

                       Spacer(),

                       GestureDetector(
                           onTap: (){
                             Navigator.pop(context);
                           },

                           child: Image.asset("assets/cross_ic.png",width: 45,height: 45,color: Colors.grey)),

                       SizedBox(width:15)

                     ],
                   )


                 ],
               ),
               SizedBox(height: 4),







               Screenshot(
                 controller: screenshotController,
                 child: RepaintBoundary(
                   key: _globalKey,
                   child: Container(
                     color: Colors.white,
                     child: Stack(
                       children: [
                         Container(
                           height: 370,
                           margin: EdgeInsets.symmetric(horizontal: 35),
                           decoration: BoxDecoration(
                               border: Border.all(color: Colors.black,width: 0.6)
                           ),
                           child: Column(
                             children: [

                               SizedBox(height: 5),
                               Container(
                                 height: 0.6,
                                 color: Colors.black,
                               ),
                               SizedBox(height: 5),
                               Expanded(child: Padding(
                                 padding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                                 child: CustomPaint(
                                     painter: DottedBorderPainter(),
                                     child:Container(

                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.stretch,
                                           children: [

                                             SizedBox(height: 5),

                                             Image.asset("assets/payment_bank_ic.png",width: 100,height: 80),

                                             SizedBox(height: 10),


                                             Text(
                                               'Certiﬁcate of Completion',
                                               style: TextStyle(
                                                 fontSize: 17.5,
                                                 fontWeight: FontWeight.w700,
                                                 color: Colors.black,
                                               ),
                                               textAlign: TextAlign.center,

                                             ),

                                             SizedBox(height: 10),


                                             Text(
                                               'IS HEREBY GRANTED TO',
                                               style: TextStyle(
                                                 fontSize: 11,
                                                 fontWeight: FontWeight.w700,
                                                 color: Color(0xFF919191),
                                               ),
                                               textAlign: TextAlign.center,

                                             ),


                                             SizedBox(height: 14),


                                             Text(
                                               name.toString(),
                                               style: TextStyle(
                                                 fontSize: 30,
                                                 color: Colors.black,
                                               ),
                                               textAlign: TextAlign.center,

                                             ),


                                             SizedBox(height: 14),


                                             Text(
                                               'TO CERTIFY THAT HE HAS COMPLETED THE',
                                               style: TextStyle(
                                                 fontSize: 11,
                                                 fontWeight: FontWeight.w700,
                                                 color: Color(0xFF919191),
                                               ),
                                               textAlign: TextAlign.center,

                                             ),




                                             SizedBox(height: 15),


                                             Text(
                                               title,
                                               style: TextStyle(
                                                 fontSize: 17.5,
                                                 fontWeight: FontWeight.w700,
                                                 color: Colors.black,
                                               ),
                                               textAlign: TextAlign.center,

                                             ),


                                             SizedBox(height: 25),

                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Container(
                                                   height: 1,
                                                   width: 100,
                                                   color: Colors.grey,
                                                 ),
                                               ],
                                             )



                                           ],
                                         ))),
                               ))




                             ],

                           ),
                         ),

                         Container(
                           height: 400,
                           child: Align(
                             alignment: Alignment.bottomCenter,
                             child: Image.asset("assets/cer_ic.png",width: 190,height: 60),
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               ),


               SizedBox(height: 25),

               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   InkWell(
                     onTap: (){



                       screenshotController.capture().then((Uint8List? image) async {
                         //Capture Done
                         setState(() {
                           _imageFile = image;
                         });
                         print("Image Captured");

                         _saveFile(_imageFile);





                         /*  await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((Uint8List? image) async {
                           if (image != null) {
                             final directory = await getApplicationDocumentsDirectory();
                             final imagePath = await File('${directory.path}/image'+DateTime.now().toString()+'.png').create();
                             await imagePath.writeAsBytes(image);




                           }
                         });*/



                       }).catchError((onError) {
                         print(onError);
                       });

                     },
                     child: Container(
                         height: 44,
                         width: 182,
                         color: Colors.black,
                         child: Center(child:   Text(
                           'Download',
                           style: TextStyle(
                             fontSize: 14.5,
                             fontWeight: FontWeight.w500,
                             color: Colors.white,
                           ),

                         ))
                     ),
                   ),
                 ],
               )
             ],
           ),
         ),
   );
  }

  _saveFile(Uint8List? image) async {
    APIDialog.showAlertDialog(context, "Downloading certificate...");
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
    await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      Navigator.pop(context);
      print(result);

      Toast.show("Certificate downloaded successfully!!",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);

    }
     }
  downloadCertificate(BuildContext context) async {

    setState(() {
      isLoading=true;
    });

    var data = {
      "Authorization": AppModel.token,
      "test_id": widget.quizID,
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
    await helper.postAPI('my-test-certificate', data, context);

    setState(() {
      isLoading=false;
    });

    var responseJSON = json.decode(response.body);
    print(responseJSON);
    title=responseJSON["result"]["test"]["title"];
    setState(() {

    });






  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PermissionUtil.requestAll();
    fetchName();
    if(widget.type=="cert")
      {
        title=widget.quizID;
        setState(() {

        });
      }
    else
      {
        downloadCertificate(context);
      }

  }

  fetchName()async{
    name= await MyUtils.getSharedPreferences("name");
    setState(() {

    });
  }

}
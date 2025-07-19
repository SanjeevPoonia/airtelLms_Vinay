

import 'dart:io';

import 'package:airtel_lms/views/new_dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../../network/api_dialog.dart';
import '../../network/constants.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/dashboard_module_widget.dart';
import '../../widgets/profile_textfield.dart';
import '../courses/all_courses_screen.dart';
import '../courses/courses_names_screen.dart';
import 'inprogrees_module_screen.dart';
import '../landing_screen.dart';
import '../latest_module_screen.dart';



class ArtifactScreen extends StatefulWidget
{
  final String imageURI;
  final String trainingID;
  ArtifactScreen(this.imageURI,this.trainingID);
  DashboardState createState()=>DashboardState();
}
class DashboardState extends State<ArtifactScreen>
{
  var vendorNameController=TextEditingController();
  Position? _currentPosition;
  double? lattitude;
  double? longitude;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 27),


        Stack(
          children: [


            Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(widget.imageURI))
                  ),
                )

            ),




            Padding(padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [

                SizedBox(width: 8),

                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white)),

                Spacer(),

                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: Image.asset("assets/cross_ic.png",width: 33,height: 33)),

                SizedBox(width: 8),

              ],
            ),


            )



          ],
        ),

          SizedBox(height: 26),

          Container(
            height: 105,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color(0xFFF0F0F0)
            ),

            child: Column(
              children: [


                SizedBox(height: 10),

                Row(
                  children: [

                    Text("Latitude :",style: TextStyle(
                      color: AppTheme.redColor,
                      fontSize: 13.5,
                    )),

                    SizedBox(width: 5),

                    Text(lattitude==null?"":lattitude.toString(),style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.5,
                    )),





                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [

                    Text("Longitude :",style: TextStyle(
                      color: AppTheme.redColor,
                      fontSize: 13.5,
                    )),

                    SizedBox(width: 5),

                    Text(longitude==null?"":longitude.toString(),style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.5,
                    )),

                  ],
                ),



                SizedBox(height: 10),

                Row(
                  children: [

                    Text("Date & Time :",style: TextStyle(
                      color: AppTheme.redColor,
                      fontSize: 13.5,
                    )),

                    SizedBox(width: 5),

                    Text(parseServerFormatDate(DateTime.now().toString()),style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.5,
                    )),


                  ],
                ),
              ],
            ),


          ),

          SizedBox(height: 15),


          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text('Vendor Name',
                style: TextStyle(
                  fontSize: 13.0,
                  color: AppTheme.redColor,
                )),
          ),



          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextFieldProfile(
              labeltext: 'Enter Vendor Name',
              controller: vendorNameController,
              validator: null,
              enabled: true,
            ),
          ),

          Spacer(),

          InkWell(
            onTap: (){

            if(vendorNameController.text=="")
              {
                Toast.show("Please enter Vendor name",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.red);

              }

            else if(lattitude==null || longitude==null)
              {
                Toast.show("Fetching location...",
                    duration: Toast.lengthLong,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.blue);
                _getCurrentPosition();
              }

            else
              {
                uploadImage();
              }
            },
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: AppTheme.redColor,
                    borderRadius: BorderRadius.circular(5)),
                height: 58,
                child: Center(
                  child: Text('Submit',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9))),
                )),
          ),

          SizedBox(height: 45),
        ],
      )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      _getCurrentPosition();
    });


  }
  String parseServerFormatDate(String serverDate) {
    var date = DateTime.parse(serverDate);
    final dateformat = DateFormat.yMMMd();
    final dateformat2 = DateFormat('hh:mm a');
    final clockString = dateformat.format(date);
    final clockStringTime = dateformat2.format(date);
    return clockString.toString()+" "+clockStringTime.toString();
  }
  void successDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
                surfaceTintColor:Colors.transparent,
                insetPadding: const EdgeInsets.all(10),
                scrollable: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),


                ),
                //this right here
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width-20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),

                          Row(
                            children: [

                              Spacer(),

                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },

                                  child: Image.asset("assets/cross_ic.png",width: 40,height: 40,color: Colors.grey)),

                            ],
                          ),





                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child:
                              Lottie.asset('assets/check_animation.json'),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Your artifacts has been successfully saved',
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      color: Colors.black,
                                      height: 1.8),
                                  textAlign: TextAlign.center),
                            ),
                          ),

                          const SizedBox(height: 25),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewDashboardScreen()),
                                      (Route<dynamic> route) => false);

                            },
                            child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppTheme.redColor,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 54,
                                child: const Center(
                                  child: Text('Back To Home',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                )),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ));
          });
        });
  }

  uploadImage() async {
    APIDialog.showAlertDialog(context, 'Uploading Artifact...');

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(widget.imageURI),
      "Authorization": AppModel.token,
      "training_id": widget.trainingID,
      "vendor_id": AppModel.vendorID,
      "vendor_name": vendorNameController.text,
      "latitude": lattitude.toString(),
      "longitude": longitude.toString(),

    });

    print("Fields are " + formData.fields.toString());

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    print(AppConstant.appBaseURL + "my-traning-vendor-artifact");

    try {
      var response = await dio.post(
          AppConstant.appBaseURL + "my-traning-vendor-artifact",
          data: formData);
      print(response.data);
      //var responseJSON = jsonDecode(response.data);
      Navigator.pop(context);
      if (response.data['status'].toString() == "success") {
        Toast.show(response.data['message'].toString(),
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.green);
        successDialog(context);

      } else {
        Toast.show(response.data['message'].toString(),
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.message);
        Navigator.pop(context);
        Toast.show("Something went wrong!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
      }
      //handle DioError here by error type or by error code

      else {
        print("Block 2");

        Navigator.pop(context);
        Toast.show("Something went wrong!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
      }
    }
  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toast.show("Location services are disabled. Please enable the services.",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
      /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));*/
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toast.show("Location permissions are denied.",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.red);
        /*ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));*/
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Toast.show(
          "Location permissions are permanently denied, we cannot request permissions.",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
      /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));*/
      return false;
    }

    return true;
  }
  _showPermissionCustomDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please allow below permissions for access the Attendance Functionality.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "1.) Location Permission",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "2.) Enable GPS Services",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          //call attendance punch in or out
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.themeColor,
                          ),
                          height: 45,
                          padding: const EdgeInsets.all(10),
                          child: const Center(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }
  Future<void> _getCurrentPosition() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, "Fetching Location..");
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      Navigator.of(context).pop();
      _showPermissionCustomDialog();
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print(
          "Location  latitude : ${_currentPosition!.latitude} Longitude : ${_currentPosition!.longitude}");


      lattitude=position.latitude;
      longitude=position.longitude;
      setState(() {

      });


      Navigator.pop(context);






      // _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
      Toast.show(
          "Error!!! Can't get Location. Please Ensure your location services are enabled",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
      Navigator.pop(context);
    });
  }
}

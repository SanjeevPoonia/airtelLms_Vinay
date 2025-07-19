import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../network/api_dialog.dart';
import '../../network/api_helper.dart';
import '../../network/constants.dart';
import '../../network/loader.dart';
import '../../utils/app_modal.dart';
import '../../utils/app_theme.dart';
import '../../widgets/textfield_profile_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';

import '../capture_image.dart';
import '../search_screen.dart';

class AddStoreScreen extends StatefulWidget {
  final String trainingID;

  AddStoreScreen(this.trainingID);

  ModuleState createState() => ModuleState();
}

class ModuleState extends State<AddStoreScreen> {
  Position? _currentPosition;
  File? image1;
  File? image2;
  List<String> trainingListAsString = [];
  final _link = LayerLink();

  List<dynamic> trainingList = [];
  List<dynamic> allStoresList = [];
  bool isLoading = false;
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _formKey = GlobalKey<FormState>();
  String? selectedTraining = "Select Training";
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var pinCodeController = TextEditingController();
  var lattitudeController = TextEditingController();
  var longitudeController = TextEditingController();
  var phoneController = TextEditingController();
  var calenderController = TextEditingController();
  List<dynamic> searchList = [];

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          _tooltipController.hide();
          setState(() {

          });
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 27),
              Container(
                height: 57,
                color: Colors.black,
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            'Add Store/ Shop',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 17),
                  /*  GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen(true)));
                        },
                        child: Image.asset("assets/search_ic.png",
                            width: 20, height: 20)),
                    SizedBox(width: 17),*/
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: isLoading
                      ? Center(
                          child: Loader(),
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text("Store/Shop Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFF707070))),
                                  SizedBox(height: 4),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: CompositedTransformTarget(
                                      link: _link,
                                      child: OverlayPortal(
                                          controller: _tooltipController,
                                          overlayChildBuilder:
                                              (BuildContext context) {
                                            return CompositedTransformFollower(
                                              link: _link,
                                              targetAnchor: Alignment.bottomLeft,
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional.topStart,
                                                child:
                                                    searchList.length != 0 ||
                                                            nameController
                                                                .text.isNotEmpty
                                                        ? Row(
                                                            children: [
                                                              Expanded(
                                                                child: Container(
                                                                  width: double
                                                                      .infinity,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top: 2,
                                                                          right:
                                                                              23),
                                                                  height: 320,
                                                                  child:
                                                                      CupertinoScrollbar(
                                                                    child: ListView
                                                                        .builder(
                                                                            padding: EdgeInsets
                                                                                .zero,
                                                                            itemCount: searchList
                                                                                .length,
                                                                            itemBuilder:
                                                                                (BuildContext context, int pos) {
                                                                              print("ID IS ");
                                                                              print(searchList[pos]["id"].toString());
                                                                              return Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      _tooltipController.hide();

                                                                                      nameController.text = searchList[pos]["fullname"];
                                                                                      addressController.text = searchList[pos]["address"] ?? "";
                                                                                      cityController.text = searchList[pos]["city"];
                                                                                      pinCodeController.text = searchList[pos]["pincode"].toString();
                                                                                     /* lattitudeController.text = searchList[pos]["latitude"].toString();
                                                                                      longitudeController.text = searchList[pos]["longitude"].toString();*/
                                                                                      phoneController.text = searchList[pos]["mobile_no"].toString();
                                                                                    },
                                                                                    child: Container(
                                                                                      color: Colors.white,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          SizedBox(height: 5),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                // assets/dummy_profile.png

                                                                                                SizedBox(width: 13),
                                                                                                Expanded(
                                                                                                    child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text(searchList[pos]["fullname"], style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Text("Pin Code: ",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 13,
                                                                                                              color: AppTheme.redColor,
                                                                                                            )),
                                                                                                        Text(searchList[pos]["pincode"].toString(),
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 13,
                                                                                                              color: Color(0xFF707070),
                                                                                                            )),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ],
                                                                                                )),
                                                                                                SizedBox(width: 10),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(height: 5),
                                                                                          Container(
                                                                                            color: Colors.grey.withOpacity(0.3),
                                                                                            width: double.infinity,
                                                                                            height: 1,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 17)
                                                            ],
                                                          )
                                                        : Container(),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            child: TextFormField(
                                              controller: nameController,
                                              validator: checkEmptyString,
                                              onChanged: (value) {
                                                _runFilter(value);
                                              },
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                hintText: "Enter here",
                                                filled: true,
                                                border: InputBorder.none,
                                                /* border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none
                  ),*/
                                                fillColor: Color(0xFFEEEDF9),
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 13,
                                                    color: AppTheme.textlight),

                                                //   floatingLabelBehavior: FloatingLabelBehavior.auto,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            ProfileTextFieldWidget("Shop Address", "",
                                addressController, checkEmptyString),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ProfileTextFieldWidget("City", "",
                                        cityController, checkEmptyString)),
                                Expanded(
                                    child: NumberWidget("Pincode", "", 6,
                                        pinCodeController, checkPincode)),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  height: 39,
                                  //  width: 140,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AppTheme.redColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                            /*   side: BorderSide(
                                                          color: AppTheme.blueColor)*/
                                          ))),
                                      onPressed: () {
                                        _getCurrentPosition();
                                      },
                                      child: const Text("Detect Location",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500))),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            LatLongWidget(
                                "Latitude", "", lattitudeController, null,
                                enabled: false,
                                suffixIconExists: 1,
                                onSuffixClick: () {}),
                            SizedBox(height: 5),
                            LatLongWidget(
                                "Longitude", "", longitudeController, null,
                                enabled: false,
                                suffixIconExists: 1,
                                onSuffixClick: () {}),
                            SizedBox(height: 5),
                            NumberWidget(
                                "Contact No.",
                                "",
                                10,
                                numberPad: true,
                                phoneController,
                                phoneValidator),
                            SizedBox(height: 19),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Upload Image",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        _fetchImage1(context, 1);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "Image 1 ",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFF00407E),
                                                  ),
                                                ),

                                              ),

                                              Text(
                                                "*",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          image1 != null
                                              ? Container(
                                                  height: 100,
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFEFEFEF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: DottedBorder(
                                                    color: Colors.black,
                                                    radius:
                                                        const Radius.circular(6),
                                                    strokeWidth: 1,
                                                    child: Center(
                                                      child: Image.file(
                                                        File(image1!.path
                                                            .toString()),
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 100,
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFEFEFEF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: DottedBorder(
                                                    color: Colors.black,
                                                    radius:
                                                        const Radius.circular(6),
                                                    strokeWidth: 1,
                                                    child: Center(
                                                      child: Image.asset(
                                                        'assets/demo_img.png',
                                                        opacity:
                                                            const AlwaysStoppedAnimation(
                                                                .3),
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        _fetchImage2(context, 1);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Image 2",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF00407E),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          image2 != null
                                              ? Container(
                                                  height: 100,
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFEFEFEF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: DottedBorder(
                                                    color: Colors.black,
                                                    radius:
                                                        const Radius.circular(6),
                                                    strokeWidth: 1,
                                                    child: Center(
                                                      child: Image.file(
                                                        File(image2!.path
                                                            .toString()),
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 100,
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFFEFEFEF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: DottedBorder(
                                                    color: Colors.black,
                                                    radius:
                                                        const Radius.circular(6),
                                                    strokeWidth: 1,
                                                    child: Center(
                                                      child: Image.asset(
                                                        'assets/demo_img.png',
                                                        opacity:
                                                            const AlwaysStoppedAnimation(
                                                                .3),
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 35),
                            Container(
                              height: 59,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppTheme.redColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5)),
                                        /*   side: BorderSide(
                                                        color: AppTheme.blueColor)*/
                                      ))),
                                  onPressed: () {
                                    _submitHandler(context);

                                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>MCQTermsScreen(quizList[index]["id"].toString())));
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>FinalResultScreen(quizList[index]["id"].toString())));
                                  },
                                  child: const Text("Save",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ],
                        ))
            ],
          ),
        ),
      ),
    );
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

      lattitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();
      setState(() {});

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

  void _submitHandler(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    validateValues();
  }

  String? checkEmptyString(String? value) {
    if (value!.isEmpty) {
      return 'Cannot be left as blank';
    }
    return null;
  }

  String? checkPincode(String? value) {
    if (value!.isEmpty) {
      return "Pin code is required";
    } else if (!RegExp(r'(^[1-9][0-9]{5}$)').hasMatch(value)) {
      return 'Invalid Pin code';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    //^0[67][0-9]{8}$
    if (!RegExp(r'(^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$)').hasMatch(value!)) {
      return 'Please enter valid mobile number, it must be of 10 digits and begins with 6, 7, 8 or 9.';
    }
    return null;
  }

  _fetchImage1(BuildContext context22, int pos) async {
  /*  final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);*/

    final image = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CaptureCameraScreen()));

    print('Image File From Android' + (image?.path).toString());
    if (image != null) {
      image1 = File(image.path);
      setState(() {});
    }
  }

  _fetchImage2(BuildContext context22, int pos) async {
/*    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);*/


    final image = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CaptureCameraScreen()));

    print('Image File From Android' + (image?.path).toString());
    if (image != null) {
      image2 = File(image.path);
      setState(() {});
    }
  }

  validateValues() {
    if (image1 == null) {
      Toast.show("Please upload first image",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    } else if (lattitudeController.text == "") {
      Toast.show("Location not found!",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    } else {
      //api Call
      addVendor();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchAllTrainings(context);
    fetchAllStores(context);
  }

  fetchAllTrainings(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {"Authorization": AppModel.token};
    print(data);

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    calenderController.text = formattedDate.toString();

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPI('give-training/all-trainings', data, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    trainingList = responseJSON["data"];
    trainingListAsString.add("Select Training");

    for (int i = 0; i < trainingList.length; i++) {
      trainingListAsString.add(trainingList[i]["title"]);
    }

    setState(() {});
  }

  fetchAllStores(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {"Authorization": AppModel.token};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response =
        await helper.postAPI('give-training/all-vendors', data, context);
    isLoading = false;
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    allStoresList = responseJSON["data"];
    setState(() {});
  }

  addVendor() async {
    APIDialog.showAlertDialog(context, "Submitting Details...");

    FormData formData = FormData.fromMap({
      "Authorization": AppModel.token,
      "name": nameController.text,
      "mobile_number": phoneController.text.toString(),
      "address": addressController.text,
      "city": cityController.text,
      "pincode": pinCodeController.text,
      "latitude": lattitudeController.text,
      "longitude": longitudeController.text,
      "training_id": widget.trainingID,
      "image1": await MultipartFile.fromFile(image1!.path.toString()),
      "image2":image2!=null? await MultipartFile.fromFile(image2!.path.toString()):null,
    });

    print("Fields are " + formData.fields.toString());

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    print(
        AppConstant.appBaseURL + "give-training/vendor-register-with-artifact");

    try {
      var response = await dio.post(
          AppConstant.appBaseURL +
              "give-training/vendor-register-with-artifact",
          data: formData);
      print(response.data);
      //var responseJSON = jsonDecode(response.data);
      Navigator.pop(context);
      if (response.data['status'].toString() == "success") {
        Toast.show("Training completed successfully!",
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.green);

        Navigator.of(context)
          ..pop()
          ..pop()
          ..pop()
          ..pop();
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

  void _runFilter(String enteredKeyword) {
    print(enteredKeyword);
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      //  results = allStoresList;
      nameController.text = "";
      addressController.text = "";
      cityController.text = "";
      pinCodeController.text = "";
      lattitudeController.text = "";
      longitudeController.text = "";
      phoneController.text = "";
      _tooltipController.hide();
      setState(() {});
    } else {
      results = allStoresList
          .where((user) => user['fullname']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      print("The Results are " + results.toString());

      print(enteredKeyword);

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchList = results;
    });

    if (results.length != 0) {
      if (!_tooltipController.isShowing) {
        _tooltipController.show();
      }


      setState(() {});
    }
    else
      {
        _tooltipController.hide();
        setState(() {

        });
      }
  }
}

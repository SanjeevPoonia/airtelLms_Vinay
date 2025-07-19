import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:airtel_lms/network/api_dialog.dart';
import 'package:airtel_lms/network/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../network/api_helper.dart';
import '../network/constants.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import '../widgets/profile_textfield.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<ProfileScreen> {
  int selectedRadioIndex = 9999;
  bool isLoading = false;
  Map<String, dynamic> profileData = {};
  final _formKeyLogin = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var userNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  String dob = "";
  String profileImage = "";
  File? selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyProfile(context);
  }
  _fetchImage(BuildContext context22, int pos) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print('Image File From Android' + (image?.path).toString());
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
      uploadImage();
    }
  }
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: isLoading
            ? Center(child: Loader())
            : Form(
                key: _formKeyLogin,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 10),
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 210,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(height: 165, color: Colors.black),
                              Container(height: 45, color: Colors.white),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [

                                  selectedImage!=null?


                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                  File(selectedImage!.path.toString())))),
                                    ),
                                  ):




                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: profileImage == null ||
                                            profileImage == ""
                                        ? Image.asset("assets/dummy10.png",
                                            width: 100, height: 100)
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        profileImage))),
                                          ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 120,
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: (){
                                            _fetchImage(context, 1);
                                          },
                                          child: Image.asset("assets/edit2.png",
                                              width: 18.18, height: 18.18),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePassScreen(profileData["email"])));
                        },
                        child: Text('Change Password',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.redColor,
                              color: AppTheme.redColor,
                            )),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Full Name',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppTheme.redColor,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFieldProfile(
                        labeltext: 'Full Name',
                        controller: fullNameController,
                        validator: null,
                        enabled: true,
                      ),
                    ),
                    SizedBox(height: 17),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('OLM ID',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppTheme.redColor,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFieldProfile(
                        labeltext: 'OLM ID',
                        controller: userNameController,
                        validator: null,
                        enabled: true,
                      ),
                    ),
                    SizedBox(height: 17),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Mobile Number',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppTheme.redColor,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFieldProfile(
                        labeltext: 'Mobile Number',
                        controller: mobileController,
                        validator: null,
                        enabled: true,
                      ),
                    ),
                    SizedBox(height: 17),


                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Email',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppTheme.redColor,
                          )),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextFieldProfile(
                        labeltext: 'Email',
                        controller: emailController,
                        validator: null,
                        enabled: true,
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text('Gender',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppTheme.redColor,
                          )),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  /*         setState(() {
                                    selectedRadioIndex = 0;
                                  });*/
                                },
                                child: Container(
                                    child: selectedRadioIndex == 0
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: AppTheme.redColor,
                                    )
                                        : Icon(
                                      Icons.radio_button_off,
                                      color: Color(0xFF707070),
                                    )),
                              ),
                              SizedBox(width: 6),
                              Text('Male',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: selectedRadioIndex == 0
                                        ? Colors.black
                                        : Color(0xFF708096),
                                  )),
                            ],
                          ),

                          SizedBox(width: 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  /*     setState(() {
                                    selectedRadioIndex = 1;
                                  });*/
                                },
                                child: Container(
                                    child: selectedRadioIndex == 1
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: AppTheme.redColor,
                                    )
                                        : Icon(
                                      Icons.radio_button_off,
                                      color: Color(0xFF707070),
                                    )),
                              ),
                              SizedBox(width: 6),
                              Text('Female',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: selectedRadioIndex == 1
                                        ? Colors.black
                                        : Color(0xFF708096),
                                  )),
                            ],
                          ),
                          SizedBox(width: 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  /*     setState(() {
                                    selectedRadioIndex = 1;
                                  });*/
                                },
                                child: Container(
                                    child: selectedRadioIndex == 2
                                        ? Icon(
                                      Icons.radio_button_checked,
                                      color: AppTheme.redColor,
                                    )
                                        : Icon(
                                      Icons.radio_button_off,
                                      color: Color(0xFF707070),
                                    )),
                              ),
                              SizedBox(width: 6),
                              Text('Others',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: selectedRadioIndex == 2
                                        ? Colors.black
                                        : Color(0xFF708096),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10 ),
                    Container(
                      height: 1,
                      color: Colors.black.withOpacity(0.5),
                      margin: EdgeInsets.symmetric(horizontal: 14),
                    ),
                  //  SizedBox(height: 15),






                    SizedBox(height: 35),
                    GestureDetector(
                      onTap: (){
                        logOutUser(context);
                      },
                      child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                              color: AppTheme.redColor,
                              borderRadius: BorderRadius.circular(5)),
                          height: 58,
                          child: Center(
                            child: Text('Logout',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.9))),
                          )),
                    ),
                    SizedBox(height: 35),
                  ],
                ),
              ));
  }

  fetchMyProfile(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var data = {"Authorization": AppModel.token};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('my-profile', data, context);
    setState(() {
      isLoading = false;
    });
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    profileData = responseJSON["data"];
    fullNameController.text = profileData["fullname"];
    emailController.text=profileData["email"];
    userNameController.text = profileData["olms_id"].toString();
    mobileController.text = profileData["mobile_number"].toString();
    String gender = profileData["gender"];
    if (gender.toLowerCase() == "male") {
      selectedRadioIndex = 0;
    } else if (gender.toLowerCase() == "female") {
      selectedRadioIndex = 1;
    } else {
      selectedRadioIndex = 2;
    }

    dob = profileData["date_of_birth"].toString();
    profileImage = profileData["image"];

    setState(() {});
  }

  uploadImage() async {
    APIDialog.showAlertDialog(context, 'Updating Image...');

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(selectedImage!.path.toString()),
      "Authorization": AppModel.token,

    });

    print("Fields are " + formData.fields.toString());

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    print(AppConstant.appBaseURL + "update-image");

    try {
      var response = await dio.post(
          AppConstant.appBaseURL + "update-image",
          data: formData);
      print(response.data);
      //var responseJSON = jsonDecode(response.data);
      Navigator.pop(context);
      if (response.data['status'].toString() == "success") {
        Toast.show(response.data['message'].toString(),
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
            backgroundColor: Colors.green);


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



  logOutUser(BuildContext context) async {
    APIDialog.showAlertDialog(context, "Logging out...");
    var data = {"Authorization": AppModel.token};
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('logout', data, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);
    _logOut(context);
  }

  _logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  void _submitHandler(BuildContext context) async {
    if (!_formKeyLogin.currentState!.validate()) {
      return;
    }
    _formKeyLogin.currentState!.save();
  }

  String? checkPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}

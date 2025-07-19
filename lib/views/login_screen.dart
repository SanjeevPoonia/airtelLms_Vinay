import 'dart:convert';

import 'package:airtel_lms/views/landing_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../network/Utils.dart';
import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';
import 'dashboard_screen.dart';
import 'new_dashboard_screen.dart';
import 'otp_verify_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordVisible = true;
  int selectedRadioIndex=0;
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKeyLogin,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                        //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        padding: const EdgeInsets.only(top: 2),
                        child: Image.asset("assets/login_background.png",
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill),
                      ),


                      Lottie.asset("assets/login_anim.json")
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color:Colors.black.withOpacity(0.50)
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),

                        Center(child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Image.asset("assets/payment_bank_ic.png",opacity: const AlwaysStoppedAnimation(.7)),
                        )),

                        SizedBox(height: 55),

                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: Colors.white.withOpacity(0.9)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Select Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 22),


                       Row(
                         children: [

                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 selectedRadioIndex=0;
                               });
                             },
                             child: Container(child:

                             selectedRadioIndex==0?

                             Icon(Icons.radio_button_checked,color: AppTheme.redColor):
                             Icon(Icons.radio_button_off,color: Colors.white)

                             ),
                           ),

                           SizedBox(width: 9),

                           Text(
                             'OLM ID',
                             style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 13,
                                 color: Colors.white.withOpacity(0.9)),
                           ),

                           SizedBox(width: 26),
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 selectedRadioIndex=1;
                               });
                             },
                             child: Container(child:

                             selectedRadioIndex==1?

                             Icon(Icons.radio_button_checked,color: AppTheme.redColor):
                             Icon(Icons.radio_button_off,color: Colors.white)

                             ),
                           ),

                           SizedBox(width: 9),

                           Text(
                             'Login With OTP',
                             style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 13,
                                 color: Colors.white.withOpacity(0.9)),
                           ),



                         ],
                       ),



                        const SizedBox(height: 22),





                        selectedRadioIndex==0?

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                child: TextFormField(
                                  controller: usernameController,
                                  validator: emailValidator,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "OLM ID/Email",
                                    label: Text(
                                      "OLM ID/Email",
                                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                    ),
                                    suffixIcon: Container(
                                      padding: EdgeInsets.all(15.0),
                                      constraints: BoxConstraints(
                                        maxHeight: 10.0,
                                        maxWidth: 10.0,
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                          'assets/mail_ic.png',
                                        ),
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFF00376A))),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: TextFormField(
                                  validator: checkPasswordValidator,
                                  controller: passwordController,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  obscureText: passwordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    label: Text(
                                      "Password",
                                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(
                                              () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    alignLabelWithHint: false,
                                    filled: false,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFF00376A))),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),

                            ],
                          ),
                        ):Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Container(
                              child: TextFormField(
                                validator: emailValidator,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: "Enter Mobile No.",
                                  label: Text(
                                    "Enter Mobile No.",
                                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                  ),
                                  suffixIcon: Container(
                                    padding: EdgeInsets.all(15.0),
                                    constraints: BoxConstraints(
                                      maxHeight: 10.0,
                                      maxWidth: 10.0,
                                    ),
                                    child:
                                    Icon(Icons.phone_android_outlined,color: Colors.white

                                      )

                                    /*Image(
                                      image: AssetImage(
                                        'assets/mail_ic.png',
                                      ),
                                      height: 20,
                                      width: 20,
                                    ),*/
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFF00376A))),
                                ),
                              ),
                            ),
                            Text(
                              'We will send you a confirmation code',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 70),
                        InkWell(
                          onTap: () {

                            if(selectedRadioIndex==0)
                              {


                                _submitHandler(context);


                          //      Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingScreen()));

                                // Login User
                              }
                            else
                              {
                                // Verify OTP


                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerifyScreen()));




                              }


                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppTheme.redColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 58,
                              child: Center(
                                child: Text(selectedRadioIndex==0?'Login':'Continue',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.9))),
                              )),
                        ),
                        SizedBox(height: 20),

                      ],
                    ),
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email or OLM Id cannot be empty";
    } else if (value.toString().contains("@")) {
      if (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Enter a valid Email address';
      }
    }

    return null;
  }
  void _submitHandler(BuildContext context) async {
    if (!_formKeyLogin.currentState!.validate()) {
      return;
    }
    _formKeyLogin.currentState!.save();
    loginUser(context);

  }

  String? checkPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }


  loginUser(BuildContext context) async {
    FocusScope.of(context).unfocus();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    APIDialog.showAlertDialog(context, 'Logging in...');
    var data = {
      "email": usernameController.text,
      "password": passwordController.text,
      "fcm_token":fcmToken!=null?fcmToken.toString():"",
    };
    print(data);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('login', data, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    if(responseJSON["status"]=="success")
    {
      Toast.show(responseJSON["message"],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);
      AppModel.setTokenValue(responseJSON['token']);

      MyUtils.saveSharedPreferences(
          'access_token', responseJSON['token']);
      MyUtils.saveSharedPreferences(
          'user_id', responseJSON['user']['id'].toString());
      MyUtils.saveSharedPreferences(
          'email', responseJSON['user']['email']);
      MyUtils.saveSharedPreferences(
          'name',  responseJSON['user']['fullname']);
      AppModel.setUserID(responseJSON['user']['id'].toString());



      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NewDashboardScreen()),
              (Route<dynamic> route) => false);

    }
    else
    {
      Toast.show("Please enter valid credentials!",
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }


    print(responseJSON);

  }
}

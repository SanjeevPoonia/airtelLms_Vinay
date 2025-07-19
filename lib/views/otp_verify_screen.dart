import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_theme.dart';

class OTPVerifyScreen extends StatefulWidget {
  OTPVerifyState createState() => OTPVerifyState();
}

class OTPVerifyState extends State<OTPVerifyScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordVisible = true;
  int selectedRadioIndex=0;
  final _formKeyLogin = GlobalKey<FormState>();
  int _start = 30;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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

                      Center(child: Image.asset("assets/payment_bank_ic.png",opacity: const AlwaysStoppedAnimation(.7))),

                      SizedBox(height: 80),

                      Text(
                        'Enter the code sent to your phone',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                      SizedBox(height: 21),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              'We Send it to +09876543211',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),

                            Spacer(),

                            Image.asset("assets/edit_ic.png",width: 13,height: 13),
                            SizedBox(width: 7),

                            Text(
                              'Edit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppTheme.redColor),
                            ),


                            SizedBox(width: 7),



                          ],
                        ),
                      ),
                      const SizedBox(height: 24),




                      Row(
                        children: [
                          OtpTextField(
                            numberOfFields: 4,
                            fieldHeight: 48,
                            fieldWidth: 43,
                            margin: EdgeInsets.only(right: 10),
                            fillColor: Colors.white,
                            filled: true,
                            borderRadius:
                            BorderRadius.circular(6),
                            borderColor: Color(0xFF707070),
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode){

                            }, // end onSubmit
                          ),
                        ],
                      ),



                      const SizedBox(height: 25),



                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Resend OTP in '),
                                TextSpan(
                                  text: _start < 10
                                      ? '00:0' +
                                      _start.toString()
                                      : '00:' +
                                      _start.toString(),
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.red),
                                ),
                                const TextSpan(
                                    text: ' seconds '),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Didn\'t receive the OTP?   ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          _start == 0
                              ? GestureDetector(
                            onTap: () {
                              print(
                                  "resend otp triggered");

                            },
                            child: Text('Resend Now',
                                style: TextStyle(
                                    fontSize: 13,
                                    decoration:
                                    TextDecoration
                                        .underline,
                                    fontWeight:
                                    FontWeight.w500,
                                    color: AppTheme
                                        .redColor)),
                          )
                              : Text('Resend Now',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration:
                                  TextDecoration
                                      .underline,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),








                      const SizedBox(height: 22),








                      const SizedBox(height: 55),
                      InkWell(
                        onTap: () {

                          if(selectedRadioIndex==0)
                            {
                              // Login User
                            }
                          else
                            {
                              // Verify OTP


                              



                            }


                        },
                        child: Container(
                            width: double.infinity,
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
                      SizedBox(height: 20),

                    ],
                  ),
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Email should be valid Email address.';
    }
    return null;
  }

  String? checkPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void startTimer() {
    _start = 30;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}

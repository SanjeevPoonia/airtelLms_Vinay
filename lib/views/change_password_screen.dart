import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';

import '../network/api_dialog.dart';
import '../network/api_helper.dart';
import '../utils/app_modal.dart';
import '../utils/app_theme.dart';

class ChangePassScreen extends StatefulWidget {
 final String email;
 ChangePassScreen(this.email);

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<ChangePassScreen> {
  bool isObscureOld = true;
  bool isObscureConfirm = true;
  bool isObscureNew = true;
  final _formKeyChangePassword = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Form(
        key: _formKeyChangePassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),



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
                        'Change Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                  ),
                  ),





                  SizedBox(width: 36),




                ],
              ),
            ),


            Center(child: Lottie.asset("assets/password_anim.json",width: 180,height: 180)),





            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text('Old Password', style: TextStyle(
                fontSize: 13.0,
                color: AppTheme.redColor,
              )),
            ),



            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                  obscureText: isObscureOld,
                  controller: currentPasswordController,
                  validator: checkOldPasswordValidator,
                  style: const TextStyle(
                    fontSize: 15.0,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    /*    contentPadding:
                                      const EdgeInsets.fromLTRB(
                                          0.0, 20.0, 0.0, 10.0),*/
                    suffixIcon: IconButton(
                      icon: isObscureOld
                          ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: AppTheme.redColor,
                      )
                          : const Icon(
                        Icons.visibility,
                        size: 20,
                        color: AppTheme.redColor,
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () async {
                          if (isObscureOld) {
                            isObscureOld = false;
                          } else {
                            isObscureOld = true;
                          }

                          setState(() {});
                        });
                      },
                    ),
                    hintText: 'Enter Old Password',
                    hintStyle: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text('New Password', style: TextStyle(
                fontSize: 13.0,
                color: AppTheme.redColor,
              )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  obscureText: isObscureConfirm,
                  controller: newPasswordController,
                  validator: checkPasswordValidator,
                  style: const TextStyle(
                    fontSize: 15.0,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    /*    contentPadding:
                                      const EdgeInsets.fromLTRB(
                                          0.0, 20.0, 0.0, 10.0),*/
                    suffixIcon: IconButton(
                      icon: isObscureConfirm
                          ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: AppTheme.redColor,
                      )
                          : const Icon(
                        Icons.visibility,
                        size: 20,
                        color: AppTheme.redColor,
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () async {
                          if (isObscureConfirm) {
                            isObscureConfirm = false;
                          } else {
                            isObscureConfirm = true;
                          }

                          setState(() {});
                        });
                      },
                    ),
                    hintText: 'Enter New Password',
                    hintStyle: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text('Confirm Password', style: TextStyle(
                fontSize: 13.0,
                color: AppTheme.redColor,
              )),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  obscureText: isObscureNew,
                  controller: confirmPasswordController,
                  validator: checkConfirmPasswordValidator,
                  style: const TextStyle(
                    fontSize: 15.0,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    /*    contentPadding:
                                      const EdgeInsets.fromLTRB(
                                          0.0, 20.0, 0.0, 10.0),*/
                    suffixIcon: IconButton(
                      icon: isObscureNew
                          ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: AppTheme.redColor,
                      )
                          : const Icon(
                        Icons.visibility,
                        size: 20,
                        color: AppTheme.redColor,
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () async {
                          if (isObscureNew) {
                            isObscureNew = false;
                          } else {
                            isObscureNew = true;
                          }

                          setState(() {});
                        });
                      },
                    ),
                    labelText: 'Re-enter Your New Password',
                    labelStyle: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  )),
            ),
            Spacer(),
            Container(
              height: 56,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // background
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.redColor), // fore
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ))),
                onPressed: () {
                  _submitHandler();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String? checkConfirmPasswordValidator(String? value) {
    if (newPasswordController.text.toString()!=value) {
      return "Password and Confirm Password must be same";
    } else {
      return null;
    }
  }

  void _submitHandler() async {
    if (!_formKeyChangePassword.currentState!.validate()) {
      return;
    }
    _formKeyChangePassword.currentState!.save();
    changePassword();

  }


  String? checkPasswordValidator(String? value) {
    if (value!.length<6) {
      return "Password must be of at least 6 digits";
    } else {
      return null;
    }
  }

  String? checkOldPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Old Password cannot be left as empty";
    } else {
      return null;
    }
  }

  changePassword() async {
    FocusScope.of(context).unfocus();
    APIDialog.showAlertDialog(context, 'Changing Password...');
    var requestModel = {
      "Authorization":AppModel.token,
      "current_password": currentPasswordController.text,
      "new_password": newPasswordController.text,
      "new_password_confirmation": confirmPasswordController.text
    };

    print(requestModel);

    ApiBaseHelper helper = ApiBaseHelper();
    var response = await helper.postAPI('change-password', requestModel, context);
    Navigator.pop(context);
    var responseJSON = json.decode(response.body);
    print(responseJSON);

    if (responseJSON['status'] == "success") {
      Toast.show(responseJSON["message"],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.green);
      Navigator.pop(context);

    } else {
      Toast.show(responseJSON['message'],
          duration: Toast.lengthLong,
          gravity: Toast.bottom,
          backgroundColor: Colors.red);
    }
  }

}

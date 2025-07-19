

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_theme.dart';

class ProfileTextFieldWidget extends StatelessWidget
{
  final String title,initialValue;
  bool? enabled;
  bool? numberPad;
  Function? onSuffixClick;
  int? suffixIconExists;
  var controller;
  final String? Function(String?)? validator;
  ProfileTextFieldWidget(this.title,this.initialValue,this.controller,this.validator,{this.enabled,this.numberPad,this.suffixIconExists,this.onSuffixClick});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        onSuffixClick!();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),

            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF707070))),
            SizedBox(height: 4),
            SizedBox(

              child: TextFormField(
                controller: controller,
                validator: validator,
                keyboardType: numberPad!=null?TextInputType.number:TextInputType.text,
                enabled: enabled!=null?enabled:true,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black
                ),
                decoration: InputDecoration(
                  hintText:"Enter here",
                  filled: true,
                  border: InputBorder.none,
                 /* border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none
                  ),*/
                  fillColor: Color(0xFFEEEDF9),
                  suffixIcon: suffixIconExists!=null?GestureDetector(
                      onTap: (){
                        onSuffixClick!();
                      },

                      child: Icon(Icons.location_on,color: AppTheme.redColor)):null,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: AppTheme.textlight
                  ),

               //   floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}

class LatLongWidget extends StatelessWidget
{
  final String title,initialValue;
  bool? enabled;
  bool? numberPad;
  Function? onSuffixClick;
  int? suffixIconExists;
  var controller;
  final String? Function(String?)? validator;
  LatLongWidget(this.title,this.initialValue,this.controller,this.validator,{this.enabled,this.numberPad,this.suffixIconExists,this.onSuffixClick});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        onSuffixClick!();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),

            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF707070))),
            SizedBox(height: 4),
            SizedBox(

              child: TextFormField(
                controller: controller,
                validator: validator,
                keyboardType: numberPad!=null?TextInputType.number:TextInputType.text,
                enabled: enabled!=null?enabled:true,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black
                ),
                decoration: InputDecoration(
                  hintText:"",
                  filled: true,
                  border: InputBorder.none,
                  /* border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none
                  ),*/
                  fillColor: Color(0xFFEEEDF9),
                  suffixIcon: suffixIconExists!=null?GestureDetector(
                      onTap: (){
                        onSuffixClick!();
                      },

                      child: Icon(Icons.location_on,color: AppTheme.redColor)):null,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: AppTheme.textlight
                  ),

                  //   floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}
class CalenderTextFieldWidget extends StatelessWidget
{
  final String title,initialValue;
  bool? enabled;
  bool? numberPad;
  int? suffixIconExists;
  var controller;
  final String? Function(String?)? validator;
  CalenderTextFieldWidget(this.title,this.initialValue,this.controller,this.validator,{this.enabled,this.numberPad,this.suffixIconExists});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),

          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF707070))),
          SizedBox(height: 4),
          SizedBox(

            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: numberPad!=null?TextInputType.number:TextInputType.text,
              enabled: enabled!=null?enabled:true,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                hintText:"Please select date",
                filled: true,
                border: InputBorder.none,
                /* border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide.none
                ),*/
                fillColor: Color(0xFFEEEDF9),
                suffixIcon: suffixIconExists!=null?Icon(Icons.calendar_month,color: AppTheme.redColor):null,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: AppTheme.textlight
                ),

                //   floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),


        ],
      ),
    );
  }

}


class NumberWidget extends StatelessWidget
{
  final String title,initialValue;
  bool? enabled;
  bool? numberPad;
  int? suffixIconExists;
  int maxLength;
  var controller;
  final String? Function(String?)? validator;
  NumberWidget(this.title,this.initialValue,this.maxLength,this.controller,this.validator,{this.enabled,this.numberPad,this.suffixIconExists});

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
      //  color:  Color(0xFFEEEDF9),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),

          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF707070))),
          SizedBox(height: 4),
          SizedBox(
          //  height: 40,
            child: TextFormField(
              controller: controller,
              validator: validator,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ],
              keyboardType: TextInputType.number,
              enabled: enabled!=null?enabled:true,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                hintText:"Enter here",
                filled: true,
                fillColor: Color(0xFFEEEDF9),
                suffixIcon: suffixIconExists!=null?Icon(Icons.location_on,color: AppTheme.redColor):null,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: AppTheme.textlight
                ),
                border: InputBorder.none,
              //  floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ),


        ],
      ),
    );
  }

}




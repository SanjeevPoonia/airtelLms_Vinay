import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatefulWidget {
  String labeltext;
  Icon fieldIC;
  Icon suffixIc;
  var controller;
  bool enabled;
  final String? Function(String?)? validator;

  TextFieldName(
      {required this.labeltext,
        required this.fieldIC,
        required this.suffixIc,
        this.controller,
        required this.enabled,
        this.validator});

  TextFieldNameState22 createState() => TextFieldNameState22();
}

class TextFieldNameState22 extends State<TextFieldName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: widget.enabled,
          validator: widget.validator,
          controller: widget.controller,
          maxLength: 30,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              height: 1.6,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0),
              filled: true,
              fillColor:
              widget.enabled ? Colors.white : Colors.grey.withOpacity(0.2),
              hintText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}


class TextFieldProfile extends StatefulWidget {
  String labeltext;
  var controller;
  bool enabled;
  final String? Function(String?)? validator;

  TextFieldProfile(
      {required this.labeltext,
        this.controller,
        required this.enabled,
        this.validator
     });

  TextFieldState22 createState() => TextFieldState22();
}

class TextFieldState22 extends State<TextFieldProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextFormField(
          enabled: widget.enabled,
          validator: widget.validator,
          controller: widget.controller,
          style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
              filled: true,
              fillColor:
             Colors.white,
              hintText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ))),
    );
  }
}







class TextFieldWithBorder extends StatefulWidget {
  String labeltext;
  var controller;
  bool enabled;
  final String? Function(String?)? validator;

  TextFieldWithBorder(
      {required this.labeltext,
        this.controller,
        required this.enabled,
        this.validator
      });

  TextFieldWithBorderState22 createState() => TextFieldWithBorderState22();
}

class TextFieldWithBorderState22 extends State<TextFieldWithBorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(5),
         border: Border.all(color: Colors.black,width: 1)
       ),
      child: TextFormField(
          enabled: widget.enabled,
          validator: widget.validator,
          controller: widget.controller,
          maxLines: 4,
          style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(7.0, 8.0, 0.0, 0),
              hintText: widget.labeltext,
              hintStyle: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.4),
              ))),
    );
  }
}



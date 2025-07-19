

import 'package:flutter/material.dart';




class TermsAppBar extends StatelessWidget {
  bool showBackIc;
  Function onTap;

  TermsAppBar(
      {Key? key,
        required this.showBackIc,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 2),
      decoration: const BoxDecoration(
        /*borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),*/
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0,
          ),
        ],

      ),
      child: Row(
        children: [
          showBackIc
              ? Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: IconButton(
                onPressed: () {
                  onTap();
                },
                icon: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white)),
          )
              : Container(),
          const SizedBox(width: 10),
         /* Container(
            width: 60,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/"),
                    fit: BoxFit.fill)),
          ),*/

          const SizedBox(width: 5)
        ],
      ),
    );
  }
}



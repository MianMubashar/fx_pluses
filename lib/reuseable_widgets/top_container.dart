import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TopContainer extends StatelessWidget {
  String title;
  String description1;
  String description2;
  var size;
  VoidCallback onPress;
  TopContainer({required this.title,required this.description1,required this.description2,required this.size,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: size.height * 0.12,
      width: size.width,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8F38FF),
              Color(0xFF5861FF),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              title,
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            RichText(
                text: TextSpan(
                    text: description1,
                    style: TextStyle(
                      color: whiteColor,
                    ),
                    children: [
                      TextSpan(
                          text: description2,
                          style: TextStyle(
                              color: whiteColor,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = onPress)
                    ])),
          ],
        ),
      ),
    );
  }
}

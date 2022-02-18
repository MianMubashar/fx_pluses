import 'package:flutter/material.dart';

import '../constants.dart';

class appbar extends StatelessWidget {
  var size;
  VoidCallback onPress;
  String text;
  appbar({required this.size,required this.onPress,required this.text});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: buttonColor,
      title: Text(
        text,
        style: TextStyle(
            color: whiteColor, fontSize: 25, fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        icon: Image.asset(
          'assets/images/backbutton.png',
          height: size.height * 0.08,
          width: size.width * 0.08,
        ),
        onPressed: onPress,
      ),
    );
  }
}

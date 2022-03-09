import 'package:flutter/material.dart';

import '../constants.dart';

class appbar extends StatelessWidget {
  var size;
  VoidCallback onPress;
  String text;
  bool check=true;
  appbar({required this.size,required this.onPress,required this.text,required this.check});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: buttonColor,
      title: Text(
        text,
        style: TextStyle(
            color: whiteColor, fontSize: 23, fontWeight: FontWeight.w600),
      ),
      leading: check ?IconButton(
        icon: Image.asset(
          'assets/images/backbutton.png',
          height: size.height * 0.08,
          width: size.width * 0.08,
        ),
        onPressed: onPress,
      ):Container(),
    );
  }
}

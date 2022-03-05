import 'package:flutter/material.dart';

import '../constants.dart';

class HelpSupportCard extends StatelessWidget {
  var size;
  String text;
  VoidCallback onPress;
  HelpSupportCard({required this.size,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: size.height * 0.05,
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: size.width * 0.08,),
                Text(text,style: TextStyle(
                    color: textBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

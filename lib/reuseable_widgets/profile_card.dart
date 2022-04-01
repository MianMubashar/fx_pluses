import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../constants.dart';

class ProfileCard extends StatelessWidget {
  var size;
  String text;
  String iconData;
  VoidCallback onPress;
  ProfileCard({required this.iconData,required this.size,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconData,height: size.height * 0.04,),
                SizedBox(width: size.width * 0.08,),
                Text(text,style: TextStyle(
                    color: textBlackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),)
              ],
            ),
            Image.asset('assets/icons/forwardicon.png',height: size.height * 0.06,width: size.width * 0.02,),


          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  double? bottomMargin;
  MainButton({required this.text,required this.onPress,this.bottomMargin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: bottomMargin==null ? 2 : bottomMargin!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradient,
        ),
        child: Center(child: Text(text,style: TextStyle(
          color: Colors.white
        ),)),
      ),
    );
  }
}

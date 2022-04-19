import 'package:flutter/material.dart';

import '../../constants.dart';
class MoneyAddedDialog extends StatelessWidget {

  String? text;
  MoneyAddedDialog({required this.text});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        height: 390.0,
        width: 320.0,
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(alignment:Alignment.topRight,child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel_outlined),
            )),
            Image.asset('assets/images/moneyadd.png',height: size.height * 0.27,width: size.width * 0.9,),
            Flexible(child: Text('$text',maxLines: 4,style: TextStyle(
                color: newColor,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}

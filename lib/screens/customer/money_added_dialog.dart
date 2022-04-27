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
        height: size.height * 0.65,
        width: size.width * 0.6,
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 30),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Align(alignment:Alignment.topRight,child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel_outlined),
            )),
            Image.asset('assets/images/moneyadd.png',height: size.height * 0.24,width: size.width * 0.8,),
            Flexible(child: Text('$text',maxLines: 10,overflow: TextOverflow.fade,style: TextStyle(
                color: newColor,
                fontSize: 15,
                fontWeight: FontWeight.w600
            ),textAlign: TextAlign.start,))
          ],
        ),
      ),
    );
  }
}

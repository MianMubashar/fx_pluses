import 'package:flutter/material.dart';

import '../../constants.dart';
class MoneyAddedDialog extends StatelessWidget {
  var  size;
  MoneyAddedDialog({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.0,
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
          Flexible(child: Text('Your Money has been added to your wallet',maxLines: 2,style: TextStyle(
              color: newColor,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}

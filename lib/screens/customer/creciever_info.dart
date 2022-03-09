import 'package:flutter/material.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';

import '../../constants.dart';

class CRecieverInfo extends StatefulWidget {
  static final String id='CRecieverInfo_Screen';
  const CRecieverInfo({Key? key}) : super(key: key);

  @override
  _CRecieverInfoState createState() => _CRecieverInfoState();
}

class _CRecieverInfoState extends State<CRecieverInfo> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {},
            text: 'John Snow',
            check: true,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Receiver Information.',style: TextStyle(
                fontSize: 16
              ),),
              SizedBox(height: 18,),
              Text(
                'First Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    //firstName = value;
                  },
                ),
              ),
              Text(
                'Last Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    //firstName = value;
                  },
                ),
              ),
              Text(
                'Account/IBAN Number',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Account/IBAN Number',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    //firstName = value;
                  },
                ),
              ),
              Text(
                'Swift Code',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Swift Code',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    //firstName = value;
                  },
                ),
              ),
              Text(
                'Amount',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    //firstName = value;
                  },
                ),
              ),

              MainButton(text: "Request", onPress: (){})
            ],
          ),
        ),
      ),
    );
  }
}

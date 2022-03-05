import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class About extends StatelessWidget {
  static final String id='About_Screen';
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text(
              'About FX Pluses',
              style: TextStyle(
                  color: textBlackColor,
                  fontSize: 23,
                  fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
              icon: Image.asset(
                'assets/images/backbutton.png',
                height: size.height * 0.08,
                width: size.width * 0.08,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15,bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    color: buttonColor,
                    //margin: EdgeInsets.only(bottom: 20),
                  ),
                  Positioned(
                    left: (size.width / 100 ) * 25,
                    top: size.height * 0.07,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.15,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('FX Pluses',textAlign: TextAlign.start,style: TextStyle(
                        color: textBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Text(Provider.of<ApiDataProvider>(context,listen: false).aboutUs!['description'],
                      style: TextStyle(
                          fontSize: 15
                      ),maxLines: 20,),
                    SizedBox(height: 10,),
                    Text('Version',textAlign: TextAlign.start,style: TextStyle(
                        color: textBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),

                    SizedBox(height: 10,),
                    Text(Provider.of<ApiDataProvider>(context,listen: false).aboutUs!['app_version'],
                      style: TextStyle(
                          fontSize: 15
                      ),maxLines: 20,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

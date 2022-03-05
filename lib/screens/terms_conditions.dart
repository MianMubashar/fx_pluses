import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class TermsConditions extends StatelessWidget {
  static final String id='TermsConditions_Screen';
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(size: size, onPress: (){
          Navigator.pop(context);
        }, text: 'Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Terms and Conditions',textAlign: TextAlign.start,style: TextStyle(
                        color: textBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 10,),
                    Text(Provider.of<ApiDataProvider>(context,listen: false).appSetting!['terms_conditions'],
                      style: TextStyle(
                          fontSize: 15
                      ),maxLines: 20,),
                    SizedBox(height: 10,),
                    Text('Privacy and Policy',textAlign: TextAlign.start,style: TextStyle(
                        color: textBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),

                    SizedBox(height: 10,),
                    Text(Provider.of<ApiDataProvider>(context,listen: false).appSetting!['privacy_policy'],
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

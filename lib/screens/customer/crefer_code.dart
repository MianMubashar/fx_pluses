import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CReferCode extends StatelessWidget {
  static final String id='CReferCode_Screen';
  CReferCode({Key? key}) : super(key: key);
  TextEditingController codeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){
            Navigator.pop(context);
          },text: 'Refer Code',check: true,)),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Refer Code',
              textAlign: TextAlign.start,
              style: TextStyle(color: textBlackColor,fontSize: 20,fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller:codeController,
                decoration: InputDecoration(
                    hintText: 'xxxxx-xxxxx',
                    helperStyle: TextStyle(color: blackColor),
                    isDense: true,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    )),
                onChanged: (value) {

                },
              ),
            ),
            SizedBox(
              height: 13,
            ),
            
            Flexible(child: Text('Please Enter Refer code to get 15% discount'
                ' on first transaction, Lorem ipsum is a placeholder text commonly',maxLines: 3,style: TextStyle(
              fontSize: 13
            ),)),
            SizedBox(
              height: 40,
            ),
            MainButton(text: 'Submit', onPress: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              if(codeController.text.isNotEmpty){
                Provider.of<ApiDataProvider>(context,listen: false).validateVoucher(context,
                    Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                    codeController.text);
              }else{
                Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid data',redColor);
              }
            })

            
          ],
        ),
      ),
    );
  }
}

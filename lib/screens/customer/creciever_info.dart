import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CRecieverInfo extends StatefulWidget {
  static final String id='CRecieverInfo_Screen';
  CRecieverInfo({Key? key,required this.reciever_id,required this.transaction_id}) : super(key: key);
  int reciever_id;
  int  transaction_id;

  @override
  _CRecieverInfoState createState() => _CRecieverInfoState();
}

class _CRecieverInfoState extends State<CRecieverInfo> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController accountNumberController=TextEditingController();
  TextEditingController swiftCodeController=TextEditingController();
  TextEditingController amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: 'Enter reciever information',
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
                  controller: firstNameController,
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
                  controller: lastNameController,
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
                  controller: accountNumberController,
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
                  controller: swiftCodeController,
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
                  controller: amountController,
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

              MainButton(text: "Send", onPress: () async{
                if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && accountNumberController.text.isNotEmpty
                    && swiftCodeController.text.isNotEmpty && amountController.text.isNotEmpty){
                 await Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                      Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                      widget.reciever_id,
                      "Name: "+firstNameController.text +lastNameController.text +'\n'+
                      "Account Number: "+accountNumberController.text + "\n"+
                      "Swift Code: "+swiftCodeController.text + "\n"+
                      "Amount: "+amountController.text,
                      '',
                      '',
                      widget.transaction_id);
                 Navigator.pop(context);
                }else{

                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

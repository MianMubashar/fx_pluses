import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class MWithdraw extends StatefulWidget {
  int currency_id;
  MWithdraw({Key? key,required this.currency_id}) : super(key: key);

  @override
  _MWithdrawState createState() => _MWithdrawState();
}

class _MWithdrawState extends State<MWithdraw> {

  TextEditingController accountHolderName=TextEditingController();
  TextEditingController accountNumber=TextEditingController();
  TextEditingController amount=TextEditingController();
  TextEditingController bankName=TextEditingController();
  TextEditingController currency=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: 'Withdraw',
            check: true,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Holder’s Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: accountHolderName,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    // firstName = value;
                  },
                ),
              ),
              Text(
                'Account Number',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(

                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: accountNumber,
                  decoration: InputDecoration(
                      hintText: 'xxxx-xxxx-xxxx',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    // firstName = value;
                  },
                ),
              ),
              Text(
                'Bank Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(

                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: bankName,
                  decoration: InputDecoration(
                      hintText: 'Bank Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    // firstName = value;
                  },
                ),
              ),
              Text(
                'Currency',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(

                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: currency,
                  decoration: InputDecoration(
                      hintText: Provider.of<ApiDataProvider>(context,listen: true).selectedCurrencySymbol+" " + Provider.of<ApiDataProvider>(context,listen: true).defaultCurrencyName,
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    // firstName = value;
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
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    // firstName = value;
                  },
                ),
              ),
              MainButton(text: 'Withdraw', onPress: () async{
                if(accountHolderName.text.isNotEmpty &&
                    accountNumber.text.isNotEmpty &&
                    amount.text.isNotEmpty) {
                  int balance = int.parse(amount.text);
                  List a = Provider
                      .of<ApiDataProvider>(context, listen: false)
                      .balance
                      .split('.');
                  int balance2 = int.parse(a[0]);
                  if (balance2 >= balance) {
                    if (balance2 == 0) {
                      Provider.of<ApiDataProvider>(context, listen: false).showSnackbar(
                          context, 'Add balance in your wallet for withdraw',redColor);
                    } else {
                      if (accountHolderName.text.isNotEmpty &&
                          accountNumber.text.isNotEmpty && amount.text.isNotEmpty) {

                        await Provider.of<ApiDataProvider>(context, listen: false)
                            .updateWallet(
                            context,
                            Provider
                                .of<ApiDataProvider>(context, listen: false)
                                .bearerToken,
                            2,
                            amount.text,
                            0,
                            accountNumber.text,
                            accountHolderName.text,
                            widget.currency_id,
                            bankName.text);
                        amount.clear();
                        accountNumber.clear();
                        accountHolderName.clear();
                        bankName.clear();

                      } else {
                        Provider.of<ApiDataProvider>(context, listen: false).showSnackbar(
                            context, 'Please enter valid data to proceed',redColor);
                      }
                    }
                  } else {
                    Provider.of<ApiDataProvider>(context, listen: false).showSnackbar(
                        context, 'Your wallet balance is insufficient',redColor);
                  }
                }else{
                  Provider.of<ApiDataProvider>(context, listen: false)
                      .showSnackbar(
                      context, 'Please enter valid data to proceed',redColor);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

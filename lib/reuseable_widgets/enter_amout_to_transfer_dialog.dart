import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/model/user_wallets_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../shared_preferences.dart';
import 'customloader.dart';
import 'package:http/http.dart' as http;

class EnterAmountToTransferDialog extends StatelessWidget {
  var size;
  int currency_id;
  String currency_name;
  EnterAmountToTransferDialog({required this.size,required this.currency_id,required this.currency_name});

  TextEditingController amountController=TextEditingController();
  Map<String, dynamic>? paymentInentData;
  String? balance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 340.0,
        width: 320.0,
        padding: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/transfer_dialog_image.png',height: size.height * 0.12,width: size.width * 0.2,),
                Text('Add Balance',style: TextStyle(
                    color: textBlackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                )),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Amount',
                  style: TextStyle(
                    color: greyColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25, top: 5),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding:  EdgeInsets.only(left: 20.0,top: 15),
                        child: Text(Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol,),
                      ),
                        hintText: 'amount',

                        helperStyle: TextStyle(color: blackColor),
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onChanged: (value) {
                      //email=value;
                    },
                  ),
                ),
                InkWell(
                  onTap: () async{
                    if(amountController.text.isEmpty){
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter amount',redColor);
                    }else {
                      if(amountController.text.contains('.')){
                        Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter amount in digits format',redColor);
                      }else{
                        Navigator.pop(context);
                        await makePayment(
                            context, amountController.text, currency_name, size);
                      }



                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.6,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: gradient,
                      ),
                      child: Center(child: Text('Send',style: TextStyle(
                          color: Colors.white
                      ),)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Future<void> makePayment(BuildContext context, String amount, String currency,size) async {
    Get.dialog(CustomLoader());
    try {
      paymentInentData = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentInentData!['client_secret'],
              applePay: false,
              googlePay: false,
              style: ThemeMode.light,
             // merchantCountryCode: 'US',
              merchantDisplayName: 'FX Pluses'
          ));
      Get.back();

      await displayPaymentSheet(amount,size,context);
    } catch (e) {
      print('exception ' + e.toString());
    }
  }

  displayPaymentSheet(amount,size,context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        // print('payment intent' + paymentInentData?['id'].toString());
        // print('payment intent' + paymentInentData?['client_secret'].toString());
        // print('payment intent' + paymentInentData?['amount'].toString());
        // print('payment intent' + paymentInentData?.toString());

        //orderPlaceApi(paymentIntentData!['id'].toString());
        //       SharedPreferences pref = await SharedPreferences.getInstance();
        //       String? token = await pref.getString(SharedPreference.bearerTokenKey);
        //       String? wallletList=await pref.getString(SharedPreference.userWalletsKey);
        //       List<UserWalletsModel> list=UserWalletsModel.decode(wallletList!);

        // String? amount1=await pref.getString(SharedPreference.walletKey);
        // List a=amount1!.split('.');
        // int amount2=int.parse(a[0]);
        // int amount3=int.parse(amount);
        //
        // int total=amount2+amount3;
        // balance=total.toString();

                // list.forEach((element) {
                //   if(element.currency_id==currency_id){
                //     String amount1=element.wallet;
                //     List a=amount1.split('.');
                //     int amount2=int.parse(a[0]);
                //     int amount3=int.parse(amount);
                //     int total=amount3+amount2;
                //     print('balance bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${element.wallet}');
                //     element.wallet=total.toString();
                //     print('balance ccccccccccccccccccccccccccccccccc ${element.wallet}');
                //     //SharedPreference.saveWalletBalanceSharedPreferences(total.toString());
                //     Provider.of<ApiDataProvider>(context,listen: false).setBalance(total.toString());
                //   }
                //   //Provider.of<ApiDataProvider>(context,listen: false).user
                // });

                // await Provider.of<ApiDataProvider>(context,listen: false).setUserWalletModelList(list);
                // final String encodedData=UserWalletsModel.encode(list);
                // await SharedPreference.saveUserWalletsSharedPreferences(encodedData);



        //await Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
        try{
          print(Provider.of<ApiDataProvider>(Get.context!, listen: false));
          await Provider.of<ApiDataProvider>(Get.context!, listen: false)
              .updateWallet(Get.context!,
              Provider.of<ApiDataProvider>(Get.context!,listen: false).bearerToken,
              1, amount, 0,'','',currency_id,null,null);
        }catch(e){
          print(e);
        }

        paymentInentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51KUTspLzsnFu9r8sIixPxiTZpUpcNv91mp38hvFlCGFbCcj0GqqwNCRPPkeKd3njpOrzE4kQRj7Il9qGeEdIGpiL00barE2kvI',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body.toString());
    } catch (e) {
      print('exception ' + e.toString());
    }
  }

  calculateAmount(amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}

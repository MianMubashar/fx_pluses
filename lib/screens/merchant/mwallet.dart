import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/ctransfer_dialog.dart';
import 'package:fx_pluses/screens/customer/cwallet_to_wallet_transfer.dart';
import 'package:fx_pluses/screens/customer/money_added_dialog.dart';
import 'package:fx_pluses/screens/merchant/mwithdraw.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences.dart';

class MWallet extends StatefulWidget {
  static final String id='MWallet_Screen';
  const MWallet({Key? key}) : super(key: key);

  @override
  _MWalletState createState() => _MWalletState();
}

class _MWalletState extends State<MWallet> {

  Map<String , dynamic>? paymentInentData;
  String? balance;
  getData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    balance=await preferences.getString(SharedPreference.walletKey);
    await Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){},text: 'Wallet',)),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Container(
              height: size.height * 0.20,
              width: size.width,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              margin: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: gradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      RichText(text: TextSpan(
                          text: Provider.of<ApiDataProvider>(context,listen: false).balance==null?'':Provider.of<ApiDataProvider>(context,listen: false).balance,
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          children: const [
                            TextSpan(
                                text: 'USD',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 10
                                )
                            )
                          ]
                      )),
                    ],
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: Text('Please add balance to proceed transaction',style: TextStyle(
                            color: whiteColor,
                            fontSize: 15
                        ),maxLines: 2,),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () async{
                          await makePayment('20', 'USD',size);
                          print('add balance clicked');
                        },
                        child: Text('Add Balance +',style: TextStyle(
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                        ),),
                      )
                    ],
                  ),

                ],
              ),
            ),
            MainButton(text: 'Add Balance +', onPress: () async{

                await makePayment('30','USD',size);


            },bottomMargin: 30,),
            MainButton(text: 'Withdraw', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MWithdraw()));
            },bottomMargin: 30,),

          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount, String currency,size) async {
    try {
      paymentInentData = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentInentData!['client_secret'],
              applePay: true,
              googlePay: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'FX Pluses'
          ));

      await displayPaymentSheet(amount,size);
    } catch (e) {
      print('exception ' + e.toString());
    }
  }

  displayPaymentSheet(amount,size) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        print('payment intent' + paymentInentData!['id'].toString());
        print('payment intent' + paymentInentData!['client_secret'].toString());
        print('payment intent' + paymentInentData!['amount'].toString());
        print('payment intent' + paymentInentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = await pref.getString(SharedPreference.bearerTokenKey);
        String? amount1=await pref.getString(SharedPreference.walletKey);
        List a=amount1!.split('.');
        int amount2=int.parse(a[0]);
        int amount3=int.parse(amount);

        int total=amount2+amount3;
        balance=total.toString();
        SharedPreference.saveWalletBalanceSharedPreferences(total.toString());
        Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);

        setState(() {
          Provider.of<ApiDataProvider>(context, listen: false)
              .updateWallet(context, token!, 1, amount, 0,'','');
          showDialog(context: context, builder: (BuildContext context)=>Dialog(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
            child: MoneyAddedDialog(size: size,),
          ));

        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

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

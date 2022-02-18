import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/money_added_dialog.dart';
import 'package:http/http.dart' as http;

class CWallet extends StatefulWidget {
  const CWallet({Key? key}) : super(key: key);

  @override
  _CWalletState createState() => _CWalletState();
}

class _CWalletState extends State<CWallet> {

  Map<String , dynamic>? paymentInentData;
  
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
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8F38FF),
                    Color(0xFF5861FF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
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
                      RichText(text: const TextSpan(
                          text: '0,000',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          children: [
                            TextSpan(
                                text: 'PKR',
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
                        onTap: (){
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
            MainButton(text: 'Add Balance +', onPress: (){
              setState(() {
                makePayment();
              });

            },bottomMargin: 30,),
            MainButton(text: 'Withdraw', onPress: (){},bottomMargin: 30,),
            MainButton(text: 'Wallet to Wallet Transfer', onPress: (){
              setState(() {
                showDialog(context: context, builder: (BuildContext context)=>Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
                  child: MoneyAddedDialog(size:size),
                ));
              });

            })

          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async{
    try{
      paymentInentData=await createPaymentIntent('20','USD');
      Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentInentData!['client_secret'],
        applePay: true,
        googlePay: true,
        style: ThemeMode.dark,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Mubashar'
      ));

      displayPaymentSheet();
    }catch(e){
      print('exception ' +e.toString());
    }
  }
  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentInentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentInentData!['id'].toString());
        print('payment intent'+paymentInentData!['client_secret'].toString());
        print('payment intent'+paymentInentData!['amount'].toString());
        print('payment intent'+paymentInentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentInentData = null;

      }).onError((error, stackTrace){
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

  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String,dynamic> body={
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response=await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51KUTspLzsnFu9r8sIixPxiTZpUpcNv91mp38hvFlCGFbCcj0GqqwNCRPPkeKd3njpOrzE4kQRj7Il9qGeEdIGpiL00barE2kvI',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );

      return jsonDecode(response.body.toString());
    }catch(e){
      print('exception ' +e.toString());
    }
  }
  calculateAmount(amount){
    final price= int.parse(amount) * 100;
    return price.toString();
  }
}

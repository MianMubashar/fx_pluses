import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/model/get_currencies_model.dart';
import 'package:fx_pluses/model/user_wallets_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/reuseable_widgets/enter_amout_to_transfer_dialog.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/ctransfer_dialog.dart';
import 'package:fx_pluses/screens/customer/cwallet_to_wallet_transfer.dart';
import 'package:fx_pluses/screens/customer/cwithdraw.dart';
import 'package:fx_pluses/screens/customer/money_added_dialog.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CWallet extends StatefulWidget {
  static final String id = 'CWallet_Screen';
  const CWallet({Key? key}) : super(key: key);

  @override
  _CWalletState createState() => _CWalletState();
}

class _CWalletState extends State<CWallet> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Map<String, dynamic>? paymentInentData;
  String? balance;
  GetCurrenciesModel? data;

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
    //getData();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {},
            text: 'Wallet',
            check: false,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [

              InkWell(
                onTap: () async {
                  // SharedPreferences preferences=await SharedPreferences.getInstance();
                  // bearerToken=await preferences.getString(SharedPreference.bearerTokenKey);
                  // print(bearerToken);
                  // await Provider.of<ApiDataProvider>(context,listen: false).getCountries(context, bearerToken!);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 20, top: 5),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      // enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    iconSize: 30,
                    isExpanded: true,
                    items: Provider.of<ApiDataProvider>(context, listen: false)
                        .getCurrenciesList
                        .map((e) => DropdownMenuItem<GetCurrenciesModel>(
                        value: e, child: Text("   "+e.name + " "+e.symbol)))
                        .toList(),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hint: Text("   "+Provider.of<ApiDataProvider>(context, listen: false).defaultCurrencyName +
                        '  '+
                        Provider.of<ApiDataProvider>(context, listen: false).selectedCurrencySymbol,style: TextStyle(color:textBlackColor),),
                    onChanged: (GetCurrenciesModel? value) async{
                      data=value;
                      //print('cccccccccccccccccc ${value!.name}');
                      Provider.of<ApiDataProvider>(context, listen: false).userWalletModelList.forEach((element)  {
                        if(element.currency_id==value!.id){
                           Provider.of<ApiDataProvider>(context, listen: false).setBalance(element.wallet);
                           Provider.of<ApiDataProvider>(context, listen: false).setSelectedWalletBalance(element.wallet);
                           Provider.of<ApiDataProvider>(context, listen: false).setSelectedCurrencySymbol(value.symbol);
                           Provider.of<ApiDataProvider>(context,listen: false).setSelectedCurrencyId(value.id);

                          Provider.of<ApiDataProvider>(context, listen: false).setdefaultCurrencySymbol(value.symbol);
                          Provider.of<ApiDataProvider>(context, listen: false).setdefaultCurrencyName(value.name);

                        }
                      });
                      setState(() {

                      });
                     // print(Provider.of<ApiDataProvider>(context, listen: false).userWalletModelList[value.id-1].currency_id);
                    },
                    onSaved: (value) {
                      print('bbbbbbbbbbbbbbbbbbbbbbb ${Provider.of<ApiDataProvider>(context, listen: false).userWalletModelList.length}');
                      //selectedValue = value.toString();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  if(data != null){
                    Provider.of<ApiDataProvider>(context, listen: false).updateDefaultCurrency(context,
                        Provider.of<ApiDataProvider>(context, listen: false).bearerToken,
                        Provider.of<ApiDataProvider>(context, listen: false).selectedCurrencyId);
                  }else{
                    Provider.of<ApiDataProvider>(context, listen: false).showSnackbar(context, 'Please select currency');
                  }
                },
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.04,
                 margin: EdgeInsets.only(bottom: 10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10)
                 ),
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text('set as default',style: TextStyle(
                      color: buttonColor
                    ),),
                  ),
                ),
              ),
              ),

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
                        RichText(
                            text: TextSpan(
                                text:  Provider.of<ApiDataProvider>(context,listen: true).balance==null ?'0.00':Provider.of<ApiDataProvider>(context,listen: true).balance,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: Provider.of<ApiDataProvider>(context,listen: false).defaultCurrencyName,
                                  style:
                                      TextStyle(color: whiteColor, fontSize: 10))
                            ])),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Please add balance to proceed transaction',
                            style: TextStyle(color: whiteColor, fontSize: 15),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async{
                            showDialog(context: context, builder: (context){
                              return EnterAmountToTransferDialog(size: size,
                                currency_id: Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencyId,
                              currency_name: Provider.of<ApiDataProvider>(context,listen: false).defaultCurrencyName,);
                            });
                            // await makePayment('20', 'USD',size);
                            print('add balance clicked');
                          },
                          child: Text(
                            'Add Balance +',
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              MainButton(
                text: 'Add Balance +',
                onPress: () async {
                  showDialog(context: context, builder: (context){
                    return EnterAmountToTransferDialog(size: size,
                      currency_id: Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencyId,
                      currency_name: Provider.of<ApiDataProvider>(context,listen: false).defaultCurrencyName,);
                  });
                  //await makePayment('20', 'USD',size);
                },
                bottomMargin: 30,
              ),
              MainButton(
                text: 'Withdraw',
                onPress: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CWithdraw(currency_id:
                  Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencyId,)));
                },
                bottomMargin: 30,
              ),
              MainButton(
                  text: 'Wallet to Wallet Transfer',
                  onPress: () async{
                    await Provider.of<ApiDataProvider>(context,listen: false).acceptedRequests(context,
                        Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CWalletToWalletTransfer()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> makePayment(String amount, String currency,size) async {
  //   Get.dialog(CustomLoader());
  //   try {
  //     paymentInentData = await createPaymentIntent(amount, currency);
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //       paymentIntentClientSecret: paymentInentData!['client_secret'],
  //       applePay: true,
  //       googlePay: true,
  //       style: ThemeMode.dark,
  //       merchantCountryCode: 'US',
  //             merchantDisplayName: 'FX Pluses'
  //     ));
  //
  //     await displayPaymentSheet(amount,size);
  //   } catch (e) {
  //     print('exception ' + e.toString());
  //   }
  // }
  //
  // displayPaymentSheet(amount,size) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((newValue) async {
  //       print('payment intent' + paymentInentData!['id'].toString());
  //       print('payment intent' + paymentInentData!['client_secret'].toString());
  //       print('payment intent' + paymentInentData!['amount'].toString());
  //       print('payment intent' + paymentInentData.toString());
  //       //orderPlaceApi(paymentIntentData!['id'].toString());
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       String? token = await pref.getString(SharedPreference.bearerTokenKey);
  //       String? amount1=await pref.getString(SharedPreference.walletKey);
  //       List a=amount1!.split('.');
  //       int amount2=int.parse(a[0]);
  //       int amount3=int.parse(amount);
  //
  //       int total=amount2+amount3;
  //       balance=total.toString();
  //       SharedPreference.saveWalletBalanceSharedPreferences(total.toString());
  //       Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
  //       setState(() {
  //         Provider.of<ApiDataProvider>(context, listen: false)
  //             .updateWallet(context, token!, 1, amount, 0,'','',1);
  //         showDialog(context: context, builder: (BuildContext context)=>Dialog(
  //
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
  //           child: MoneyAddedDialog(size: size,),
  //         ));
  //
  //       });
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("paid successfully")));
  //
  //       paymentInentData = null;
  //     }).onError((error, stackTrace) {
  //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
  //     });
  //   } on StripeException catch (e) {
  //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               content: Text("Cancelled "),
  //             ));
  //   } catch (e) {
  //     print('$e');
  //   }
  // }
  //
  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //     };
  //     var response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           'Authorization':
  //               'Bearer sk_test_51KUTspLzsnFu9r8sIixPxiTZpUpcNv91mp38hvFlCGFbCcj0GqqwNCRPPkeKd3njpOrzE4kQRj7Il9qGeEdIGpiL00barE2kvI',
  //           'Content-Type': 'application/x-www-form-urlencoded'
  //         });
  //
  //     return jsonDecode(response.body.toString());
  //   } catch (e) {
  //     print('exception ' + e.toString());
  //   }
  // }
  //
  // calculateAmount(amount) {
  //   final price = int.parse(amount) * 100;
  //   return price.toString();
  // }
}


import 'package:country_currency_pickers/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/customer/profile.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CHome extends StatefulWidget {
  static final String id = 'CHome_Screen';
  const CHome({Key? key}) : super(key: key);

  @override
  _CHomeState createState() => _CHomeState();
}

class _CHomeState extends State<CHome> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  TextEditingController amount = TextEditingController();
  String? amountWritten;
  final List<String> genderItems = [
    'England',
    'Pakistan',
  ];
  String country = '';
  String countryCode = '';
  bool check = false;
  String? bearerToken;
  String? token;
  int? from_country_id;
  int? to_counntry_id;
  String? fromCurrencySymbol;
  bool active=false;
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bearerToken = await preferences.getString(SharedPreference.bearerTokenKey);
    print(bearerToken);
    await Provider.of<ApiDataProvider>(context, listen: false)
        .getCountries(context, bearerToken!);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Home',
                style: TextStyle(
                    color: textBlackColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () async{
                  await Provider.of<ApiDataProvider>(context, listen: false)
                      .setScreenIndex(6);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CProfile(backButtonEnabled: true,)));
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      (Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("https") ||
                      Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("http")) ?
                  Uri.encodeFull(Provider.of<ApiDataProvider>(context,listen: true).photoUrl) :
                  profile_url + Provider.of<ApiDataProvider>(context,listen: true).photoUrl),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.15,
                width: size.width,
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     heightFactor: 0.4,
                    //     child: IconButton(
                    //         onPressed: () {},
                    //         icon: Image.asset(
                    //           'assets/images/cancelicon.png',
                    //           height: size.height * 0.02,
                    //         ))),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/ellipse.png',
                              width: size.width * 0.22,
                            ),
                            Positioned(
                              child: Image.asset(
                                'assets/images/happy.png',
                                width: size.width * 0.14,
                              ),
                              top: size.height * 0.02,
                              left: size.width * 0.040,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              'Welcome ${Provider.of<ApiDataProvider>(context,listen: false).firstName==null?'':
                              Provider.of<ApiDataProvider>(context,listen: false).firstName}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: textWhiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Please Process you payments.',
                              style: TextStyle(
                                color: textWhiteColor,
                                fontSize: 15,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'Process your Transactions',
                style: TextStyle(
                    color: textBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select country from',
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              Container(
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
                      .getCountriesForMerchants
                      .map((e) => DropdownMenuItem<GetCountriesForMerchants>(
                          value: e, child: Text(e.country)))
                      .toList(),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hint: Text('Select country from'),
                  onChanged: (GetCountriesForMerchants? value) {
                    print('cccccccccccccccccc ${value!.country}    ${value.country_code} ${value.id}');
                    country = value.country as String;
                    from_country_id=value.id;
                    fromCurrencySymbol=value.currency['symbol'];

                    print(country);
                    setState(() {
                      check=false;
                    });
                  },
                  onSaved: (value) {
                    print('bbbbbbbbbbbbbbbbbbbbbbb ${value}');
                    //selectedValue = value.toString();
                  },
                ),
              ),
              Text(
                'Select country to',
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              Container(
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
                      .getCountriesForMerchants
                      .map((e) => DropdownMenuItem<GetCountriesForMerchants>(
                      value: e, child: Text(e.country)))
                      .toList(),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hint: Text('Select country To'),
                  onChanged: (GetCountriesForMerchants? value) {
                    print('cccccccccccccccccc ${value!.country}');
                    //country = value.country as String;
                    to_counntry_id=value.id;
                    print(country);
                    setState(() {
                      check=false;
                    });
                  },
                  onSaved: (value) {
                    print('bbbbbbbbbbbbbbbbbbbbbbb ${value}');
                    //selectedValue = value.toString();
                  },
                ),
              ),
              Text(
                'Enter Amount',
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25, top: 5),
                child: TextField(
                  controller: amount,

                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:  EdgeInsets.only(left: 20.0,top: 15),
                      child: Text(fromCurrencySymbol==null?Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol:fromCurrencySymbol!),
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
                    amountWritten=value;
                   setState(() {
                     check=false;
                   });
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  if(amount.text.isNotEmpty || country !='') {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    token =
                    await prefs.getString(SharedPreference.bearerTokenKey);


                    // String amount1 =
                    // await Provider
                    //     .of<ApiDataProvider>(context, listen: false)
                    //     .selectedWalletBalance;

                    // List a = amount1.split('.');
                    // int amount2 = int.parse(a[0]);
                    // int amount3 = int.parse(amount.text);
                    // if (amount2 < amount3) {
                    //   Get.showSnackbar(GetSnackBar(
                    //     backgroundColor: Colors.red,
                    //     message: 'Your wallet balance is insufficient',
                    //     duration: Duration(seconds: 3),
                    //     animationDuration: Duration(milliseconds: 500),
                    //   ));
                    //   //Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Your wallet balance is insufficient');
                    // } else {
                      print('aaaaaaaaaaaaaaaaaaaaaaa $country');
                      Provider
                          .of<ApiDataProvider>(context, listen: false)
                          .getCountriesForMerchants
                          .forEach((element) async {
                        //await Provider.of<ApiDataProvider>(context,listen: false).setCountryName(CountryPickerUtils.getCountryByIsoCode(element.country_code).name.toString());
                        if (element.country == country) {
                          print(element.country);
                          countryCode = element.country_code;
                          if(amountWritten !='0'  ){
                            if(amount.text.isEmpty){
                              Provider
                                  .of<ApiDataProvider>(context,
                                  listen: false).showSnackbar(context, 'Please enter amount', redColor);
                            }else{
                              if(from_country_id != null && to_counntry_id != null){
                                if(amount.text.contains('.')) {
                                  Provider
                                      .of<ApiDataProvider>(context,
                                      listen: false).showSnackbar(context,'Please enter amount in digits format',redColor);
                                }else{
                                  FocusScope.of(context).requestFocus(
                                      FocusNode());

                                  await Provider.of<ApiDataProvider>(
                                      context, listen: false).getMercchantes(
                                      context,
                                      token!,
                                      amount.text,
                                      element.country_code,
                                      Provider
                                          .of<ApiDataProvider>(context,
                                          listen: false)
                                          .selectedCurrencyId,
                                      from_country_id!,
                                      to_counntry_id!);

                                  amount.clear();


                                  setState(() {
                                    check = true;
                                  });

                                }
                              }else{
                                Provider
                                    .of<ApiDataProvider>(context,
                                    listen: false).showSnackbar(context, 'Please select countries', redColor);
                              }

                            }

                          }else{
                            Provider
                                .of<ApiDataProvider>(context,
                                listen: false).showSnackbar(context, 'Please enter amount more then 0', redColor);
                          }

                        }
                      });
                   // }
                  }else{
                    Get.showSnackbar(GetSnackBar(
                      backgroundColor: Colors.red,
                      message: 'Please select valid values',
                      animationDuration: Duration(milliseconds: 500),
                      duration: Duration(seconds: 3),
                    ));
                    //Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please select valid values');
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: check
                          ? LinearGradient(colors: [
                              const Color(0xFF666666),
                              const Color(0xFF666666),
                            ])
                          : gradient),
                  child: Center(
                      child: Text(
                    'Get Rate',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),


              Visibility(
                visible: check,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top five Merchants',
                      style: TextStyle(
                          color: textBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: size.height * 0.4,
                      child:Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list.length<1?
                      Center(
                        child: Container(
                          child: Text('No merchant found',style: TextStyle(
                              color: textBlackColor
                          ),),
                        ),
                      )
                          : ListView.builder(
                          itemCount: Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: size.height * 0.17,
                              width: size.width,
                              margin: EdgeInsets.only(
                                  bottom: 1, left: 10, right: 10, top: 10),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                      1,
                                      0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             CMerchantProfile(name:  Provider.of<ApiDataProvider>(
                                              //                 context,
                                              //                 listen: false)
                                              //                 .top_five_merchant_list[
                                              //             index]
                                              //                 .first_name +
                                              //                 Provider.of<ApiDataProvider>(
                                              //                     context,
                                              //                     listen: false)
                                              //                     .top_five_merchant_list[
                                              //                 index]
                                              //                     .last_name,
                                              //               country: country,
                                              //               profilePhoto: Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].profile,)));
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  (Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].user['profile_photo_path'].contains('http') ||
                                                      Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].user['profile_photo_path'].contains('https'))?
                                                  Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].user['profile_photo_path'] :
                                              profile_url+Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].user['profile_photo_path']),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             CMerchantProfile(name:  Provider.of<ApiDataProvider>(
                                              //                 context,
                                              //                 listen: false)
                                              //                 .top_five_merchant_list[
                                              //             index]
                                              //                 .first_name +
                                              //                 Provider.of<ApiDataProvider>(
                                              //                     context,
                                              //                     listen: false)
                                              //                     .top_five_merchant_list[
                                              //                 index]
                                              //                     .last_name,
                                              //               country: country,
                                              //               profilePhoto: Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].profile,)));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 5.0),
                                                        child: SizedBox(
                                                          width:size.width * 0.25,
                                                          child: Text(
                                                            Provider.of<ApiDataProvider>(context, listen: false)
                                                                .top_five_merchant_list[index].user['business']==null?
                                                            Provider.of<ApiDataProvider>(context, listen: false)
                                                                    .top_five_merchant_list[index].user['first_name'] +
                                                                Provider.of<ApiDataProvider>(context, listen: false)
                                                                    .top_five_merchant_list[index].user['last_name']:
                                                            Provider.of<ApiDataProvider>(context, listen: false)
                                                                .top_five_merchant_list[index].user['business'],
                                                            style: TextStyle(
                                                                color: textBlackColor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight.w500),maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'icons/flags/png/${Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list[index].user['country_code'].toLowerCase()}.png',
                                                        package: 'country_icons',
                                                        height: 20,
                                                        width: 20,
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list[index].user['country_name'],
                                                    style: TextStyle(
                                                        color: greyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(double.parse(Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list[index].user['rating']).toStringAsFixed(2),
                                                  style: TextStyle(
                                                      color: greyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // SharedPreferences prefs =
                                          //     await SharedPreferences.getInstance();
                                          // String amount1 = Provider.of<ApiDataProvider>(context,listen: false).balance;
                                          // //String? token=await prefs.getString(SharedPreference.bearerTokenKey);
                                          // List a = amount1.split('.');
                                          // int amount2 = int.parse(a[0]);
                                          // int amount3 = int.parse(amountWritten!);
                                          // if (amount2 < amount3) {
                                          //   Provider.of<ApiDataProvider>(context,
                                          //           listen: false)
                                          //       .showSnackbar(context,
                                          //           'Account balance is insuffcient',redColor);
                                          // } else {


                                            await Provider.of<ApiDataProvider>(
                                                    Get.context!,
                                                    listen: false)
                                                .requestTransaction(Get.context!, amountWritten!,
                                                    Provider.of<ApiDataProvider>(Get.context!, listen: false).top_five_merchant_list[index].user_id,
                                                    token!,
                                                Provider.of<ApiDataProvider>(Get.context!, listen: false).top_five_merchant_list[index].user['first_name'] +
                                                   " "+ Provider.of<ApiDataProvider>(Get.context!, listen: false).top_five_merchant_list[index].user['last_name'],
                                                Provider.of<ApiDataProvider>(Get.context!, listen: false).selectedCurrencyId,
                                                Provider.of<ApiDataProvider>(Get.context!, listen: false).top_five_merchant_list[index].id);
                                            setState(() {
                                              check = true;
                                            });
                                         // }

                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(left: 10, right: 10),
                                          height: size.height * 0.05,
                                          width: size.width * 0.26,
                                          decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/images/messageicon.png',
                                                  height: size.height * 0.02,
                                                ),
                                                Text(
                                                  'Chat Now',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.009,),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(

                                          margin: EdgeInsets.only(left: 30),
                                          height: size.height * 0.03,
                                          width: size.width * 0.2,
                                          decoration: BoxDecoration(

                                              color: buttonColor,
                                              borderRadius: BorderRadius.circular(5
                                              )
                                          ),
                                          child: Center(
                                            child: Text('${Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].fromCurrency['symbol']}'+
                                                ' 1',style: TextStyle(
                                                color: textWhiteColor
                                            ),),
                                          ),
                                        ),
                                        Text(' =',style: TextStyle(
                                            fontSize: 15
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(left:3),
                                          decoration:BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          height: size.height * 0.03,
                                          width: size.width * 0.2,
                                          child: Row(
                                            children: [
                                              Text('${Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].exchange_rate}'),
                                              Text('${Provider.of<ApiDataProvider>(context,listen: false).top_five_merchant_list[index].toCurrency['symbol']}')
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

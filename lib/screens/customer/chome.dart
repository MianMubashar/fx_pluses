import 'package:country_currency_pickers/country_pickers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:fx_pluses/screens/customer/cmerchant_profile.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CHome extends StatefulWidget {
  static final String id = 'CHome_Screen';
  const CHome({Key? key}) : super(key: key);

  @override
  _CHomeState createState() => _CHomeState();
}

class _CHomeState extends State<CHome> {
  TextEditingController amount = TextEditingController();
  final List<String> genderItems = [
    'England',
    'Pakistan',
  ];
  String country = '';
  String countryCode = '';
  bool check = false;
  String? bearerToken;
  String? token;
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
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
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
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        heightFactor: 0.4,
                        child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/cancelicon.png',
                              height: size.height * 0.02,
                            ))),
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
                              'Welcome !!',
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
                'Select country',
                style: TextStyle(
                  color: greyColor,
                ),
              ),
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
                        .getCountriesForMerchants
                        .map((e) => DropdownMenuItem<GetCountriesForMerchants>(
                            value: e, child: Text(e.country)))
                        .toList(),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hint: Text('Please select country'),
                    onChanged: (GetCountriesForMerchants? value) {
                      print('cccccccccccccccccc ${value!.country}');
                      country = value.country as String;
                      print(country);
                      setState(() {
                        check = false;
                      });
                    },
                    onSaved: (value) {
                      print('bbbbbbbbbbbbbbbbbbbbbbb ${value}');
                      //selectedValue = value.toString();
                    },
                  ),
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
                  decoration: InputDecoration(
                      hintText: '400',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                   setState(() {
                     check=false;
                   });
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? amount1 =
                      await prefs.getString(SharedPreference.walletKey);
                  token =
                      await prefs.getString(SharedPreference.bearerTokenKey);
                  List a = amount1!.split('.');
                  int amount2 = int.parse(a[0]);
                  int amount3 = int.parse(amount.text);
                  if (amount2 < amount3) {
                    Provider.of<ApiDataProvider>(context, listen: false)
                        .showSnackbar(
                            context, 'Your Wallet balance is insufficient');
                  } else {
                    print('aaaaaaaaaaaaaaaaaaaaaaa $country');
                    Provider.of<ApiDataProvider>(context, listen: false)
                        .getCountriesForMerchants
                        .forEach((element) async {
                      //await Provider.of<ApiDataProvider>(context,listen: false).setCountryName(CountryPickerUtils.getCountryByIsoCode(element.country_code).name.toString());
                      if (element.country == country) {
                        print(element.country);
                        countryCode = element.country_code;
                        await Provider.of<ApiDataProvider>(context,
                                listen: false)
                            .getMercchantes(context, token!, amount.text,
                                element.country_code);

                        setState(() {
                          check = true;
                        });
                      }
                    });
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
                      child: ListView.builder(
                          itemCount: Provider.of<ApiDataProvider>(context,
                                  listen: false)
                              .top_five_merchant_list
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: size.height * 0.13,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CMerchantProfile()));
                                        },
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.black12,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CMerchantProfile()));
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
                                                        Provider.of<ApiDataProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .top_five_merchant_list[
                                                                    index]
                                                                .first_name +
                                                            Provider.of<ApiDataProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .top_five_merchant_list[
                                                                    index]
                                                                .last_name,
                                                        style: TextStyle(
                                                            color: textBlackColor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500),maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    'icons/flags/png/${Provider.of<ApiDataProvider>(context, listen: false).top_five_merchant_list[index].countryCode.toLowerCase()}.png',
                                                    package: 'country_icons',
                                                    height: 20,
                                                    width: 20,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                country,
                                                style: TextStyle(
                                                    color: greyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String? amount1 = await prefs.getString(
                                          SharedPreference.walletKey);
                                      //String? token=await prefs.getString(SharedPreference.bearerTokenKey);
                                      List a = amount1!.split('.');
                                      int amount2 = int.parse(a[0]);
                                      int amount3 = int.parse(amount.text);
                                      if (amount2 < amount3) {
                                        Provider.of<ApiDataProvider>(context,
                                                listen: false)
                                            .showSnackbar(context,
                                                'Account balance is insuffcient');
                                      } else {
                                        await Provider.of<ApiDataProvider>(
                                                context,
                                                listen: false)
                                            .requestTransaction(
                                                context,
                                                amount.text,
                                                Provider.of<ApiDataProvider>(
                                                        context,
                                                        listen: false)
                                                    .top_five_merchant_list[
                                                        index]
                                                    .id,
                                                token!);
                                        // pushNewScreen(
                                        //   context,
                                        //   screen: ChatScreen(),
                                        //   withNavBar:
                                        //       false, // OPTIONAL VALUE. True by default.
                                        //   pageTransitionAnimation:
                                        //       PageTransitionAnimation.cupertino,
                                        // );
                                      }
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fx_pluses/model/onboarding_content.dart';
import 'package:fx_pluses/model/user_wallets_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/customer/cbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/home.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String id = 'SplashScreen_Screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? initScreen = 0;

  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? balance;
  int? roleId;
  String? countryCode;
  String? rating;
  String? photoUrl;
  String? bearerToken;
  bool? isLoggedIn;
  int? defaultCurrenceyId;
  String? defaultCurrenceyName;
  String? defaultCurrenceySymbol;
  String? listData;
  List<UserWalletsModel>? list;



  abc() async {


    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = await preferences.getInt('initScreen');
    roleId=await preferences.getInt(SharedPreference.roleIdKey);
    isLoggedIn=await preferences.getBool(SharedPreference.userLoggedInKey);

    if(isLoggedIn==true){
      print('get data');
      SharedPreferences preferences=await SharedPreferences.getInstance();
      bearerToken=await preferences.getString(SharedPreference.bearerTokenKey);
      Provider.of<ApiDataProvider>(context,listen: false).validateToken(context, bearerToken!);
      // userId=await preferences.getInt(SharedPreference.userIdKey);
      // firstName=await preferences.getString(SharedPreference.firstNameKey);
      // lastName=await preferences.getString(SharedPreference.lastNameKey);
      // email=await preferences.getString(SharedPreference.userEmailKey);
      //balance=await preferences.getString(SharedPreference.walletKey);
      //roleId=await preferences.getInt(SharedPreference.roleIdKey);
      // countryCode=await preferences.getString(SharedPreference.countryCodeKey);
      // rating=await preferences.getString(SharedPreference.ratingKey);
      // //defaultCurrencey=await preferences.getString(SharedPreference.defaultCurrencyKey);
      // photoUrl=await preferences.getString(SharedPreference.photoUrlKey);

      // defaultCurrenceyId=await preferences.getInt(SharedPreference.defaultCurrencyIdKey);
      // defaultCurrenceyName=await preferences.getString(SharedPreference.defaultCurrencyNameKey);
      // defaultCurrenceySymbol=await preferences.getString(SharedPreference.defaultCurrencySymbolKey);
      // listData=await preferences.getString(SharedPreference.userWalletsKey);
      //
      //
      // list=UserWalletsModel.decode(listData!);
      // list!.forEach((element) async{
      //   if(element.currency_id==defaultCurrenceyId){
      //     balance=element.wallet;
      //   }
      // });


      // await Provider.of<ApiDataProvider>(context,listen: false).setId(userId!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setFirstName(firstName!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setLastName(lastName!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setEmail(email!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setSelectedWalletBalance(balance!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setRoleId(roleId!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setCountryCode(countryCode!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setRating(rating!);
      // //await Provider.of<ApiDataProvider>(context,listen: false).setDefaultCurrency(defaultCurrencey!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setPhotoUrl(photoUrl!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setBearerToken(bearerToken!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setDefaultCurrencyId(defaultCurrenceyId!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setSelectedCurrencyId(defaultCurrenceyId!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setdefaultCurrencyName(defaultCurrenceyName!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setdefaultCurrencySymbol(defaultCurrenceySymbol!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setSelectedCurrencySymbol(defaultCurrenceySymbol!);
      // await Provider.of<ApiDataProvider>(context,listen: false).setUserWalletModelList(list!);
      // await Provider.of<ApiDataProvider>(context, listen: false).getCountries(context, bearerToken!);
      // await Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequests(context, bearerToken!);
      // await Provider.of<ApiDataProvider>(context,listen: false).getCurrencies(context, bearerToken!);
    }


    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${isLoggedIn} and ${roleId}');
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => initScreen == null || initScreen==0
              ? Home()
              : isLoggedIn==true ?
          roleId==5?
          CBottomNavigationBar():
          MBottomNavigationBar():
          Login(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    abc();
    // int a=SharedPreference.getIsSeenSharedPreferences()!;


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF8F38FF)),
      child: Center(
          child: Image.asset(
        'assets/images/logo.png',
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
      )),
    );
  }
}

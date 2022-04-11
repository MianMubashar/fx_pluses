import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/accepted_request_merchants_model.dart';
import 'package:fx_pluses/model/chat_menu_model.dart';
import 'package:fx_pluses/model/customer_transaction_history_model.dart';
import 'package:fx_pluses/model/faqs_model.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/model/get_currencies_model.dart';
import 'package:fx_pluses/model/get_currency_rates_model.dart';
import 'package:fx_pluses/model/merchant_transaction_requests_model.dart';
import 'package:fx_pluses/model/show_chat_model.dart';
import 'package:fx_pluses/model/top_five_merchants.dart';
import 'package:fx_pluses/model/user_wallets_model.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:fx_pluses/screens/customer/cbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/customer/cmessages.dart';
import 'package:fx_pluses/screens/wallet_to_wallet_transfer.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';
import 'package:fx_pluses/screens/terms_conditions.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ApiDataProvider extends ChangeNotifier {
  static const String BASE_URL =
      'http://console.fxpluses.com/';
  // static const String BASE_URL =
  //     'http://192.168.18.17/FX_Pluses/FX_Pluses/public/';
  String SERVER_URL = BASE_URL + 'api/';
  String verificationId = '';

//setters
  String? _firstName = '';
  String? _lastName = '';
  String? _email = '';
  String? _password = '';
  String? _contact = '';
  String? _countryCode = '';
  String? _userId = '';
  int? _roleId = 0;
  String? _deviceToken = '';
  String verificationIdRecieved = '';
  String? _idFile;

  String? _idFileForlocal;
  String? _buisnessName;


  bool check = false;
  String? _balance = '';
  int? _defaultCurrencyId;
  String? _defaultCurrencyName = '';
  String? _defaultCurrencySymbol = '';
  List<TopFiveMerchants> top_five_merchant_list = [];
  List<GetCountriesForMerchants> getCountriesForMerchants = [];
  List<String> _countryNameForTopFiveMerchantes = [];
  List<MerchantTransactionRequestsModel> merchantTransactionRequestsList = [];
  List<AcceptedRequestMerchantsModel> acceptedRequestMerchantsList = [];
  List<ChatMenuModel> usersHavingChatList = [];
  List<CustomerTransactionHistoryModel> customerTransactionHistoryList = [];
  List<FaqsModel> faqsList = [];
  List<ShowChatModel> showChatList = [];

  Map<String,dynamic>? _chatOffers;





  List<GetCurrenciesModel> getCurrenciesList = [];
  List<UserWalletsModel> _userWalletModelList = [];
  List<GetCurrencyRatesModel> getCurrencyRateModelList=[];
  Map? appSetting;
  Map? aboutUs;
  String? _bearerToken = '';
  String? _rating = '';
  String? _default_currency = '';
  String? _photoUrl;
  int? _id;
  int? _selectedCurrencyId;
  String? _selectedWalletBalance = '';
  String? _selectedCurrencySymbol = '';
  String? _countryName;
  int _screenIndex=0;

  String? _updatedContact;

   //String? id_file;



  String? _currencySymbolForExchangeRateScreen;


  setChatOffers(Map<String, dynamic>? value) {
    _chatOffers = value;
    notifyListeners();
  }
  setUpdatedContact(String c){
    _updatedContact=c;
  }
 setScreenIndex(int i){
   _screenIndex=i;
   notifyListeners();
 }
  setIdFileForLocal(String file){
    _idFileForlocal=file;
    notifyListeners();
  }
  setBuisnessName(String? n){
    _buisnessName=n;
    notifyListeners();
  }
  setIdFile(String? file){
    _idFile=file;
    notifyListeners();
  }
setRegisterUserCountryName(String n){
  _countryName=n;
}
  setcurrencySymbolForExchangeRateScreen(String s) {
    _currencySymbolForExchangeRateScreen = s;
    notifyListeners();
  }
  setSelectedCurrencySymbol(String s) {
    _selectedCurrencySymbol = s;
  }

  setSelectedWalletBalance(String b) {
    _selectedWalletBalance = b;
  }

  setSelectedCurrencyId(int idd) {
    _selectedCurrencyId = idd;
  }

  setUserWalletModelList(List<UserWalletsModel> list) {
    _userWalletModelList.clear();
    _userWalletModelList = list;
  }

  setDefaultCurrencyId(int idd) {
    _defaultCurrencyId = idd;
  }

  setdefaultCurrencyName(String n) {
    _defaultCurrencyName = n;
  }

  setdefaultCurrencySymbol(String s) {
    _defaultCurrencySymbol = s;
  }

  setId(int idd) {
    _id = idd;
  }

  setBearerToken(String bt) {
    _bearerToken = bt;
  }

  setFirstName(String firstName) {
    this._firstName = firstName;
    notifyListeners();
  }

  setLastName(String lastName) {
    this._lastName = lastName;
    notifyListeners();
  }

  setEmail(String email) {
    this._email = email;
  }

  setPassword(String password) {
    this._password = password;
  }

  setUserId(String userId) {
    this._userId = userId;
  }

  setRoleId(int roleId) {
    this._roleId = roleId;
  }

  setContact(String contact) {
    this._contact = contact;
    notifyListeners();
  }

  setCountryCode(String contryCode) {
    this._countryCode = contryCode;
  }

  setToken(String token) {
    this._deviceToken = token;
  }

  setBalance(String balance) {
    _balance = balance;
    notifyListeners();
  }



  setRating(String r) {
    _rating = r;
  }

  setDefaultCurrency(String dc) {
    _default_currency = dc;
  }

  setPhotoUrl(String photo) {
    _photoUrl = photo;
    notifyListeners();
  }



  Future<bool> registerRequest(BuildContext context,
      String firstName,
      String lastName,
      String email,
      String password,
      String contact,
      String countryCode,
      String? userId,
      int roleId,
      String deviceToken,
      String country_name,
      String? buisness_name) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'register');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map customerData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'contact_no': contact,
        'country_code': countryCode,
        'role_id': roleId,
        'device_token': deviceToken,
        'country_name':country_name
      };
      Map merchantData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'contact_no': contact,
        'country_code': countryCode,
        'user_id': userId,
        'role_id': roleId,
        'device_token': deviceToken,
        'country_name':country_name,
        'business':buisness_name
      };

      var body = jsonEncode(roleId == 5 ? customerData : merchantData);

      var response = await http.post(url, headers: header, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        print('body is ${response.body}');
        if (status) {
          Get.back();
          print('status is $status');
          if (roleId == 5) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          }
        } else {
          Get.back();
          print('status is $status');
          showSnackbar(context, apiResponse['error'], redColor);
          return false;
        }
      } else {
        Get.back();
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        Map<String, dynamic> a = apiResponse['error'];
        getError(a, context);
        return false;
      }
    } catch (e) {
      Get.back();
      print('try catch error ${e}');
       showSnackbar(context, e.toString(),redColor);
      //Map<String, dynamic> apiResponse = jsonDecode(response.body);
      //getError(apiResponse['error'], context);
    }

    return false;
  }

  Future<bool> loginRequest(BuildContext context, String email, String password,
      String device_token) async {
    // Get.put(Get.dialog(CustomLoader()));
    Get.dialog(CustomLoader());

    Uri url = Uri.parse(SERVER_URL + 'login');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map customerData = {
        'email': email,
        'password': password,
        'device_token': device_token
      };
      Map merchantData = {
        'email': email,
        'password': password,
        'device_token': device_token
      };
      var body = jsonEncode(customerData);
      print('api hit $customerData');
      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          _userWalletModelList.clear();

          int user_id = apiResponse['user']['id'];
          String firstName = apiResponse['user']['first_name'];
          String lastName = apiResponse['user']['last_name'];
          String email = apiResponse['user']['email'];
          String contactNum=apiResponse['user']['contact_no'];
         String? file=apiResponse['user']['id_file'];
         String? buisness=apiResponse['user']['business'];

          // String wallet=apiResponse['user']['wallet'];
          int role_id = apiResponse['user']['role_id'];
          String country_code = apiResponse['user']['country_code'];
          String rating = apiResponse['user']['rating'];
          String country_name=apiResponse['user']['country_name'];
          //String? default_currency=apiResponse['user']['default_currency'];
          String photo_url = apiResponse['user']['profile_photo_path'];
          String token = apiResponse['token'];
          int currencyId = apiResponse['user']['default_currency_id'];
          String currencyName = apiResponse['user']['default_currency']['name'];
          String currencySymbol = apiResponse['user']['default_currency']['symbol'];

          List<dynamic> user_wallets_data = apiResponse['user']['user_wallet'];

          for (int i = 0; i < user_wallets_data.length; i++) {
            if (UserWalletsModel
                .fromJson(user_wallets_data[i])
                .currency_id == currencyId) {
              await SharedPreference.saveWalletBalanceSharedPreferences(
                  UserWalletsModel
                      .fromJson(user_wallets_data[i])
                      .wallet);
              setBalance(UserWalletsModel
                  .fromJson(user_wallets_data[i])
                  .wallet);
              setSelectedWalletBalance(UserWalletsModel
                  .fromJson(user_wallets_data[i])
                  .wallet);
            }
            _userWalletModelList.add(
                UserWalletsModel.fromJson(user_wallets_data[i]));
          }
          final String encodedData = UserWalletsModel.encode(
              _userWalletModelList);


          await SharedPreference.saveUserIdSharedPreferences(user_id);
          await SharedPreference.saveFirstNameSharedPreferences(firstName);
          await SharedPreference.saveLastNameSharedPreferences(lastName);
          await SharedPreference.saveEmailSharedPreferences(email);
          //await SharedPreference.saveWalletBalanceSharedPreferences(wallet);
          await SharedPreference.saveRoleIdSharedPreferences(role_id);
          await SharedPreference.saveCountryCodeSharedPreferences(country_code);
          await SharedPreference.saveRatingSharedPreferences(rating);
          await SharedPreference.savePhotoUrlSharedPreferences(photo_url);
          await SharedPreference.saveBearerTokenSharedPreferences(token);
          await SharedPreference.saveIsLoggedInSharedPreferences(true);
          await SharedPreference.saveDefaultCurrencyIdSharedPreferences(
              currencyId);
          await SharedPreference.saveDefaultCurrencyNameSharedPreferences(
              currencyName);
          await SharedPreference.saveDefaultCurrencySymbolSharedPreferences(
              currencySymbol);
          await SharedPreference.saveUserWalletsSharedPreferences(encodedData);


          await setId(user_id);
          await setFirstName(firstName);
          await setLastName(lastName);
          await setEmail(email);
          // setBalance(wallet);
          await setRoleId(role_id);
          await setCountryCode(country_code);
          await setRating(rating);
          //setDefaultCurrency(default_currency);
          await setPhotoUrl(photo_url);
          await setBearerToken(token);
          await setDefaultCurrencyId(currencyId);
          await setdefaultCurrencyName(currencyName);
          await setdefaultCurrencySymbol(currencySymbol);
          await setSelectedCurrencySymbol(currencySymbol);
          await setSelectedCurrencyId(currencyId);
          await setContact(contactNum);
          await setIdFile(file);
          await setBuisnessName(buisness);
          await setRegisterUserCountryName(country_name);

          await setScreenIndex(0);



          await getCountries(context, token);
          await merchantTransactionRequests(context, token);
          await getCurrencies(context, token);
          Get.back();
          if (roleId == 5) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CBottomNavigationBar(index: 0,),
              ),
            );
          } else {
            if (roleId == 4) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MBottomNavigationBar(index: 0,),));
            }
          }


          return false;
        } else {
          Get.back();
          showSnackbar(context, apiResponse['message'], redColor);
          print('status is $status');
          return false;
        }
      } else {
        Get.back();
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        print(
            "status code is ${response
                .statusCode} and ${apiResponse['error']}");
        showSnackbar(context, 'Email or Password is incorrect', redColor);
        return false;
      }
    } catch (e) {
      Get.back();
      print('try catch error from login ${e}');
      return false;
    }
  }

  Future validateToken(BuildContext context, String token) async {
    Uri url = Uri.parse(SERVER_URL + 'validate-token');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          _userWalletModelList.clear();


          int user_id = apiResponse['user']['id'];
          String firstName = apiResponse['user']['first_name'];
          String lastName = apiResponse['user']['last_name'];
          String email = apiResponse['user']['email'];
          String contact=apiResponse['user']['contact_no'];
          String? file=apiResponse['user']['id_file'];
          String? buisness=apiResponse['user']['business'];
          // String wallet=apiResponse['user']['wallet'];
          int role_id = apiResponse['user']['role_id'];
          String country_code = apiResponse['user']['country_code'];
          String rating = apiResponse['user']['rating'];
          //String? default_currency=apiResponse['user']['default_currency'];
          String photo_url = apiResponse['user']['profile_photo_path'];
          // String token=apiResponse['token'];
          int currencyId = apiResponse['user']['default_currency_id'];
          String country_name=apiResponse['user']['country_name'];
          String currencyName = apiResponse['user']['default_currency']['name'];
          String currencySymbol = apiResponse['user']['default_currency']['symbol'];
          List<dynamic> user_wallets_data = apiResponse['user']['user_wallet'];

          for (int i = 0; i < user_wallets_data.length; i++) {
            if (UserWalletsModel
                .fromJson(user_wallets_data[i])
                .currency_id == currencyId) {
              await SharedPreference.saveWalletBalanceSharedPreferences(
                  UserWalletsModel
                      .fromJson(user_wallets_data[i])
                      .wallet);
              setBalance(UserWalletsModel
                  .fromJson(user_wallets_data[i])
                  .wallet);
              setSelectedWalletBalance(UserWalletsModel
                  .fromJson(user_wallets_data[i])
                  .wallet);
            }
            _userWalletModelList.add(
                UserWalletsModel.fromJson(user_wallets_data[i]));
          }
          final String encodedData = UserWalletsModel.encode(
              _userWalletModelList);


          await SharedPreference.saveUserIdSharedPreferences(user_id);
          await SharedPreference.saveFirstNameSharedPreferences(firstName);
          await SharedPreference.saveLastNameSharedPreferences(lastName);
          await SharedPreference.saveEmailSharedPreferences(email);
          //await SharedPreference.saveWalletBalanceSharedPreferences(wallet);
          await SharedPreference.saveRoleIdSharedPreferences(role_id);
          await SharedPreference.saveCountryCodeSharedPreferences(country_code);
          await SharedPreference.saveRatingSharedPreferences(rating);
          await SharedPreference.savePhotoUrlSharedPreferences(photo_url);
          await SharedPreference.saveBearerTokenSharedPreferences(token);
          await SharedPreference.saveIsLoggedInSharedPreferences(true);
          await SharedPreference.saveDefaultCurrencyIdSharedPreferences(
              currencyId);
          await SharedPreference.saveDefaultCurrencyNameSharedPreferences(
              currencyName);
          await SharedPreference.saveDefaultCurrencySymbolSharedPreferences(
              currencySymbol);
          await SharedPreference.saveUserWalletsSharedPreferences(encodedData);

          await setId(user_id);
          await setFirstName(firstName);
          await setLastName(lastName);
          await setEmail(email);
          setContact(contact);
          // setBalance(wallet);
          await setRoleId(role_id);
          await setCountryCode(country_code);
          await setRating(rating);
          //setDefaultCurrency(default_currency);
          await setPhotoUrl(photo_url);
          await setBearerToken(token);
          await setDefaultCurrencyId(currencyId);
          await setSelectedCurrencyId(currencyId);
          await setdefaultCurrencyName(currencyName);
          await setdefaultCurrencySymbol(currencySymbol);
          await setSelectedCurrencySymbol(currencySymbol);
          await setRegisterUserCountryName(country_name);
          await setIdFile(file);
          await setBuisnessName(buisness);

          await setScreenIndex(0);


          await getCountries(context, token);
          await merchantTransactionRequests(context, token);
          await getCurrencies(context, token);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          //int? initScreen = 0;
          int? role;
          bool? isLoggedIn;
          //initScreen = await preferences.getInt('initScreen');
          role = await preferences.getInt(SharedPreference.roleIdKey);
          isLoggedIn =
          await preferences.getBool(SharedPreference.userLoggedInKey);

          print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${isLoggedIn} and ${roleId}');
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>
              role == 5
                  ? CBottomNavigationBar(index: 0,)
                  : MBottomNavigationBar(index: 0,)));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    } catch (e) {
      print('try catch error from validateToken $e');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Future<bool> updateWallet(BuildContext context, String token,
      int wallet_action_id, String amount, int to_user_id, String accountNumber,
      String name, int currencyId) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'update-wallet');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      if (token != null) {
        var header = {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        };


        Map addBalanceData = {
          'wallet_action_id': wallet_action_id,
          'amount': amount,
          'currency_id': currencyId
          //'device_token': device_token
        };
        Map withdrawData = {
          'wallet_action_id': wallet_action_id,
          'acc_owner_name': name,
          'acc_number': accountNumber,
          'amount': amount,
          'currency_id': currencyId
          //'device_token': device_token
        };
        Map walletToWalletTransferData = {
          'wallet_action_id': wallet_action_id,
          'amount': amount,
          'to_user_id': to_user_id,
          'currency_id': currencyId
          //'device_token': device_token
        };
        var body = jsonEncode(
            wallet_action_id == 1 ? addBalanceData : wallet_action_id == 2
                ? withdrawData
                : walletToWalletTransferData);
        var response = await http.post(url, body: body, headers: header);

        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          print(jsonDecode(response.body));

          bool status = apiResponse['status'];
          if (status) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            String? token = await pref.getString(
                SharedPreference.bearerTokenKey);
            String? wallletList = await pref.getString(
                SharedPreference.userWalletsKey);
            List<UserWalletsModel> list = UserWalletsModel.decode(wallletList!);

            list.forEach((element) {
              if (element.currency_id == selectedCurrencyId) {
                String amount1 = element.wallet;
                double a = double.parse(amount1);
                int amount2 = a.round();

                int amount3 = int.parse(amount);
                int total=0;
                if (wallet_action_id == 1) {
                  total = amount3 + amount2;
                } else {
                  if(wallet_action_id ==2){
                    total=amount2;
                  }else{
                    if(amount2>0){
                      total = amount2 - amount3;
                    }
                  }
                }

                print('balance bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${element
                    .wallet}');
                element.wallet = total.toString();
                print('balance ccccccccccccccccccccccccccccccccc ${element
                    .wallet}');
                //SharedPreference.saveWalletBalanceSharedPreferences(total.toString());
                setBalance(total.toString());
                setSelectedWalletBalance(total.toString());
              }
              //Provider.of<ApiDataProvider>(context,listen: false).user
            });

            await setUserWalletModelList(list);
            final String encodedData = UserWalletsModel.encode(list);
            await SharedPreference.saveUserWalletsSharedPreferences(
                encodedData);
            Get.back();
            showSnackbar(context, apiResponse['message'], buttonColor);
            // Navigator.pop(context);
          } else {
            Get.back();
            //showSnackbar(context, '')
          }
        } else {
          Get.back();
          showSnackbar(
              context, apiResponse['error']['acc_number'][0], redColor);
        }
      } else {
        Get.back();
        print('token is null');
      }
    } catch (e) {
      Get.back();
      print('try catch error in update wallet $e');
    }
    return false;
  }

  Future getMercchantes(BuildContext context, String token, String amount,
      String countryCode, int currency_id,int from_country_id,int to_country_id) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'get-merchants');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'from_country_id': from_country_id,
        'to_country_id': to_country_id,
        //'currency_id': currency_id
        //'device_token': device_token
      };
      var body = jsonEncode(data);
      var response = await http.post(url, body: body, headers: header);
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        top_five_merchant_list.clear();
        print(jsonDecode(response.body));

        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          List<dynamic> data = apiResponse['merchant_rates'];
          for (int i = 0; i < data.length; i++) {
            top_five_merchant_list.add(TopFiveMerchants.fromJson(data[i]));
          }
        } else {
          Get.back();
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Get.back();
        showSnackbar(context, apiResponse['error'], redColor);
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(GetSnackBar(
        backgroundColor: redColor,
        message: 'Something went wrong',
        duration: Duration(seconds: 1),
        animationDuration: Duration(milliseconds: 500),
      ));
      ;
    }
  }

  Future getCountries(BuildContext context, String token,) async {
    Uri url = Uri.parse(SERVER_URL + 'get-countries');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };


      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          getCountriesForMerchants.clear();
          List<dynamic> data = apiResponse['countries'];
          for (int i = 0; i < data.length; i++) {
            getCountriesForMerchants.add(
                GetCountriesForMerchants.fromJson(data[i]));
          }
        } else {
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        showSnackbar(context, 'Get countries error', redColor);
      }
    } catch (e) {
      print('try catch error from getCountries is ${e}');
    }
  }

  Future getCurrencies(BuildContext context, String token,) async {
    Uri url = Uri.parse(SERVER_URL + 'get-currencies');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };


      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          getCurrenciesList.clear();
          List<dynamic> data = apiResponse['currencies'];
          for (int i = 0; i < data.length; i++) {
            getCurrenciesList.add(GetCurrenciesModel.fromJson(data[i]));
          }
        } else {
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        showSnackbar(context, apiResponse['error'][0], redColor);
      }
    } catch (e) {
      print('try catch error from getCurrencies ${e}');
    }
  }


  Future requestTransaction(BuildContext context, String amount, int id,
      String token, String name, int currency_id,int merchant_rate_id,) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'request-transaction');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'to_user_id': id,
        'amount': amount,
        //'currency_id': currency_id,
        'merchant_rate_id':merchant_rate_id
        //'device_token': device_token
      };
      var body = jsonEncode(data);
      var response = await http.post(url, body: body, headers: header);
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {

          Get.back(closeOverlays: true);
          print(apiResponse['message']);
          Map transaction = apiResponse['transaction'];
          Map<String,dynamic>? rateOffer = apiResponse['rate_offer'];
          await setChatOffers(rateOffer);
          setScreenIndex(6);

          // Get.showSnackbar(GetSnackBar(
          //   backgroundColor: buttonColor,
          //   message: apiResponse['message'],
          //   duration: Duration(seconds: 2),
          //   animationDuration: Duration(milliseconds: 100),
          // ),);

          pushNewScreen(context,
              screen: ChatScreen(
                reciever_id: id, name: name, transactionId: transaction['id'],transaction: transaction,rateOffer: rateOffer,),
              withNavBar: false,
              pageTransitionAnimation:
              PageTransitionAnimation.cupertino);
        } else {
          Get.back(closeOverlays: true);
          Map transaction = apiResponse['transaction'];
          Map<String,dynamic>? rateOffer = apiResponse['rate_offer'];
          await setChatOffers(rateOffer);
          setScreenIndex(6);
          pushNewScreen(context,
              screen: ChatScreen(
                reciever_id: id, name: name, transactionId: transaction['id'],transaction: transaction,rateOffer: rateOffer),
              withNavBar: false,
              pageTransitionAnimation:
              PageTransitionAnimation.cupertino);
         // showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Get.back();
        getError(apiResponse['error'], context);
      }
    } catch (e) {
      Get.back();
      print('Try Catch Error from request transaction $e');
    }
  }

  Future merchantTransactionRequests(BuildContext context, String token) async {
    Uri url = Uri.parse(SERVER_URL + 'merchant-transaction-requests');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        //print(apiResponse.values);
        bool status = apiResponse['status'];
        if (status) {
          merchantTransactionRequestsList.clear();
          List<dynamic> data = apiResponse['requests'];
          for (int i = 0; i < data.length; i++) {
            merchantTransactionRequestsList.add(
                MerchantTransactionRequestsModel.fromJson(data[i]));
          }
        } else {
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        // showSnackbar(context, 'Something went wrong',redColor);
      }
    } catch (e) {
      showSnackbar(context, 'Something went wrong', redColor);
    }
  }

  Future accepteOrNotStatusRequest(BuildContext context, String token,
      String status, int transaction_id, int index) async {
    Uri url = Uri.parse(SERVER_URL + 'update-transaction-request-status');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'status': status,
        'transaction_id': transaction_id,
      };
      var body = jsonEncode(data);
      var response = await http.post(url, body: body, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          print(apiResponse['message']);
          showSnackbar(context, apiResponse['message'], buttonColor);
          //merchantTransactionRequestsList.removeAt(index);
        }
      }
    } catch (e) {
      print('try catch error from accepterOrNotStatusRequest $e');
    }
  }

  Future acceptedRequests(BuildContext context, String token) async {
    Uri url = Uri.parse(SERVER_URL + "accepted-transaction-request");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          acceptedRequestMerchantsList.clear();
          List<dynamic> data = apiResponse['transaction_requests'];
          for (int i = 0; i < data.length; i++) {
            acceptedRequestMerchantsList.add(
                AcceptedRequestMerchantsModel.fromJson(data[i]));
          }
        } else {
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        print('status code is not 200');
        showSnackbar(context, 'Something went wrong', redColor);
      }
    } catch (e) {
      print('try catch error from acceptedRequests $e');
    }
  }

  // Future chatMenu(BuildContext context,String token,) async{
  //   Uri url=Uri.parse(SERVER_URL + "chat-menu");
  //   try {
  //     var header = {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token"
  //     };
  //     var response = await http.post(url, headers: header);
  //     if(response.statusCode==200) {
  //       Map<String, dynamic> apiResponse = jsonDecode(response.body);
  //       bool status = apiResponse['status'];
  //
  //       if(status){
  //         usersHavingChatList.clear();
  //         List<dynamic> data=apiResponse['chats'];
  //         for(int i=0;i<data.length;i++){
  //           usersHavingChatList.add(ChatMenuModel.fromJson(data[i]));
  //         }
  //       }
  //     }else{
  //       print('status is not 200');
  //     }
  //   }catch(e){
  //     print('try catch error from chatMenu $e');
  //   }
  // }

  Future<void> customerTrancationHistory(BuildContext context,
      String token,) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + "customer-transaction-history");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];

        if (status) {
          Get.back();
          customerTransactionHistoryList.clear();
          List<dynamic> data = apiResponse['transaction_history'];
          for (int i = 0; i < data.length; i++) {
            customerTransactionHistoryList.add(
                CustomerTransactionHistoryModel.fromJson(data[i]));
          }
          // return true;
        }
      } else {
        print('status is not 200');
        Get.back();
        // return false;
      }
    } catch (e) {
      print('try catch error from customerTrancationHistory $e');
      Get.back();
      // return false;
    }
  }

  Future getAppData(BuildContext context, String token,) async {
    Uri url = Uri.parse(SERVER_URL + "get-app-data");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];

        if (status) {
          appSetting = apiResponse['app_settings'];
          aboutUs = apiResponse['about_us'];
          List<dynamic> data = apiResponse['faqs'];
          for (int i = 0; i < data.length; i++) {
            faqsList.add(FaqsModel.fromJson(data[i]));
          }
        }
      } else {
        print('status is not 200');
      }
    } catch (e) {
      print('try catch error from getAppData $e');
    }
  }

  // Future showChatt(BuildContext context,String token, int reciever_id) async{
  //   Uri url=Uri.parse(SERVER_URL + 'show-chat');
  //   try{
  //     var header={
  //       'Content-Type':'application/json',
  //       'Authorization':'Bearer $token'
  //     };
  //     var response=await http.post(url,headers: header);
  //
  //     if(response.statusCode==200){
  //       Map<String, dynamic> apiResponse=jsonDecode(response.body);
  //       bool status=apiResponse['status'];
  //       if(status){
  //         List<dynamic> data=apiResponse['messages'];
  //         for(int i=0;i<data.length;i++){
  //           showChatList.add(ShowChatModel.fromJson(data[i]));
  //         }
  //       }else{
  //         print('status is not true from showChat');
  //       }
  //     }
  //     else{
  //       print('statusCode is not 200 from showChat');
  //     }
  //   }catch(e){
  //     print('try catch error from showChat $e');
  //   }
  // }
  Future contactUs(BuildContext context, String token, String message) async {
    Uri url = Uri.parse(SERVER_URL + "store-contact-message");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        "message": message
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          String m = apiResponse['message'];
          showSnackbar(context, m, buttonColor);
        }
      }
    } catch (e) {
      print('try catch error from contactUs $e');
    }
  }

  Future sendMessage(BuildContext context, String token, int recieverid,
      String message, String filePath, String name, int? transacion_id
      ,int? is_rate_msg,String? from_country_id,String? to_country_id,String? rate) async {
    Uri url = Uri.parse(SERVER_URL + "send-message");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        "receiver_id": recieverid,
        "message": message,
        "transaction_id": transacion_id,
        "is_rate_msg":is_rate_msg
      };

      if(is_rate_msg != null && is_rate_msg == 1){
        bodyData['from_country_id'] = from_country_id;
        bodyData['to_country_id'] = to_country_id;
        bodyData['rate'] = rate;
      }


      Map bodyData2 = {
        "receiver_id": recieverid,
      };
      var body;
      var response;
      if (message != '') {
        body = jsonEncode(bodyData);
        response = await http.post(url, headers: header, body: body);
      } else {
        var request = await http.MultipartRequest('POST', url);
        request.headers['Authorization'] = "Bearer $token";
        request.fields['receiver_id'] = '$recieverid';
        request.fields['transaction_id'] ='$transacion_id';
        request.files.add(
            await http.MultipartFile.fromPath(
                'file',
                filePath
            )
        );

        response = await request.send();
        // print(response);
        print(response.statusCode);
      }


      Map<String, dynamic> apiResponse;
      if (message == '') {
        final res = await http.Response.fromStream(response);
        apiResponse = jsonDecode(res.body);
      } else {
        apiResponse = jsonDecode(response.body);
      }
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {
          String m = apiResponse['message'];
          //showSnackbar(context, m);
        } else {
          print('status is not true from sendMessage');
        }
      } else {
        print('status from send message ${apiResponse['error']}');
      }
    } catch (e) {
      print('try catch error from sendMessage $e');
    }
  }

  Future updateDefaultCurrency(BuildContext context, String token,
      int currency_id) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + "update-default-currency");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        "currency_id": currency_id,
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          showSnackbar(context, apiResponse['message'], buttonColor);
        } else {
          Get.back();
          print('status is not true from updateDefaultCurrency');
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        showSnackbar(context, 'Something went wrong', redColor);
      }
    } catch (e) {
      Get.back();
      print('try catch error from updateDefaultCurrency $e');
    }
  }

  Future updateProfile(BuildContext context, String token, String? first_name,
      String? last_name, String? filePath, String file_Key,String? contact_num,
      String? buisness,String? country_code,String? country_name) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + "update-profile");
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        "first_name": first_name,
        "last_name": last_name,
      };

      var body;
      var response;
      if (first_name != '') {
        body = jsonEncode(bodyData);
        response = await http.post(url, headers: header, body: body);
      } else {
        var request = await http.MultipartRequest('POST', url);
        request.headers['Authorization'] = "Bearer $token";
        if(contact_num != 'null' && contact_num != null) {
          request.fields['contact_no'] = '$contact_num';
          request.fields['country_code']= '$countryCode';
          request.fields['country_name']='$countryName';
        }
        if(buisness != null && buisness != ''){
          request.fields['business']='$buisness';
        }
        if(filePath !=null){
          request.files.add(
              await http.MultipartFile.fromPath(
                  file_Key,
                  filePath
              )
          );
        }


        response = await request.send();
        //print(response.body);
        print(response.statusCode);
      }


      Map<String, dynamic> apiResponse;
      if (first_name == '') {
        final res = await http.Response.fromStream(response);
        apiResponse = jsonDecode(res.body);
      } else {
        apiResponse = jsonDecode(response.body);
      }
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          if (first_name == '' || first_name==null) {
            String m = apiResponse['message'];
            if(buisness != null && buisnessName != ''){
              setBuisnessName(buisness);
            }
            if(contact_num != null){
              setContact(contact_num);
            }
            if(filePath != null && filePath != ''){
              if(file_Key == 'photo'){
                String p = apiResponse['photo_path'];
                setPhotoUrl(p);
              }else{
                Map<String, dynamic> user = apiResponse['user'];
                 if(user['id_file'] != '' || user['id_file'] != null){
                   setIdFile(user['id_file']);
                 }

              }

            }
            showSnackbar(context, m, buttonColor);
          } else {
            if(first_name==null && last_name==null){
              setContact(contact_num!);
              showSnackbar(context, apiResponse['message'], buttonColor);
            }
            else{
              setFirstName(first_name);
              setLastName(last_name!);
              showSnackbar(context, apiResponse['message'], buttonColor);
            }


          }
        } else {
          Get.back();
          print('status is not true from sendMessage');
        }
      } else {
        Get.back();
        print('status from send message ${apiResponse['error']}');
      }
    } catch (e) {
      Get.back();
      print('try catch error from updateProfile $e');
    }
  }

  Future validateVoucher(BuildContext context, String token,
      String code) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'validate-voucher');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

      Map bodyData = {
        'code': code
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          showSnackbar(context, apiResponse['message'], buttonColor);
        } else {
          Get.back();
          print('status is not true from validateVoucher ');
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Get.back();
        print('status code is not 200 from validateVoucher ');
        showSnackbar(context, apiResponse['error'][0], redColor);
      }
    } catch (e) {
      Get.back();
      print('try catch error from validateVoucher $e');
    }
  }

  Future privacyPolicy(BuildContext context) async {
    Uri url = Uri.parse(SERVER_URL + 'privacypolicy-termsconditions');
    try {
      var header = {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      };
      var response = await http.post(url, headers: header);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          appSetting = apiResponse['app_settings'];
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TermsConditions()));
        } else {
          showSnackbar(context, apiResponse['message'], redColor);
        }
      }
    } catch (e) {
      print('try catch error from privacyPolicy $e');
    }
  }

  Future<bool> completeTransaction(BuildContext context, String token,
      int? transactionId, String status) async {
    Uri url = Uri.parse(SERVER_URL + 'complete-transaction');
    try {
      var header = {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        'transaction_id': transactionId,
        'status': status
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          showSnackbar(context, apiResponse['message'], buttonColor);
          return true;
        } else {
          getError(apiResponse['error'], context);
          return false;
        }
      } else {
        showSnackbar(context, 'Something went wrong', redColor);
        return false;
      }
    } catch (e) {
      print('try catch error from privacyPolicy $e');
      return false;
    }
  }

  Future rateMerchant(BuildContext context, String token, int merchant_id,
      double rate) async {
    Uri url = Uri.parse(SERVER_URL + 'rate-merchant');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        'merchant_id': merchant_id,
        'rating': rate
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => CBottomNavigationBar(index: 0,)));
          showSnackbar(context, apiResponse['message'], buttonColor);
        } else {
          Navigator.pop(context);
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Navigator.pop(context);
        getError(apiResponse['error'], context);
      }
    } catch (e) {
      print('try catch error from rateMerchant $e');
      showSnackbar(context, e.toString(), redColor);
    }
  }

  Future forgotPassword(BuildContext context, String email_id) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'password-reset-email');
    try {
      var header = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map bodyData = {
        'email': email_id
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          showSnackbar(context, apiResponse['message'], buttonColor);
        } else {
          Get.back();
          print('status is not true from forgot password');
          showSnackbar(context, apiResponse['message'], redColor);
        }
      } else {
        Get.back();
        getError(apiResponse['error'], context);
      }
    } catch (e) {
      Get.back();
      print('try catch error from rateMerchant $e');
      showSnackbar(context, e.toString(), redColor);
    }
  }
  Future CreateRate(BuildContext context, String token, int fromCurrency, int toCurrency, String exchangeRate) async{
    Get.dialog(CustomLoader());
    Uri url=Uri.parse(SERVER_URL+'create-rate');
    try{
      var  header={
        "Content-Type":"application/json",
        "Accept" : "application/json",
        "Authorization": "Bearer $token"
      };
      Map  bodyData={
        'from_currency_id':fromCurrency,
        'to_currency_id':toCurrency,
        'exchange_rate':exchangeRate
      };
      var body=jsonEncode(bodyData);
      var response=await http.post(url,headers: header,body: body);
      Map<String,dynamic> apiResponse=jsonDecode(response.body);
      if(response.statusCode==200){
        bool status=apiResponse['status'];
        if(status){
          Get.back();
          Map data=apiResponse['created_rate'];
          getCurrencyRateModelList.add(GetCurrencyRatesModel(id: data['id'], from_currency_id: data['from_currency_id'],
              to_currency_id: data['to_currency_id'], exchange_rate: data['exchange_rate'],
              user_id: data['user_id'], from_currency: data['from_currency'], to_currency: data['to_currency']));
          //showSnackbar(context, apiResponse['messsage'], buttonColor);
        }else{
          Get.back();
          showSnackbar(context, apiResponse['messsage'], redColor);
        }
      }else{
        Get.back();
        getError(apiResponse['error'], context);
      }

    }catch(e){
      Get.back();
      showSnackbar(context, 'Something went wrong', redColor);
    }
  }

  Future GetRate(BuildContext context, String token) async{
    Get.dialog(CustomLoader());
    Uri url=Uri.parse(SERVER_URL+'get-rates');
    try{
      var  header={
        "Content-Type":"application/json",
        "Accept" : "application/json",
        "Authorization": "Bearer $token"
      };

      var response=await http.post(url,headers: header);
      Map<String,dynamic> apiResponse=jsonDecode(response.body);
      if(response.statusCode==200){
        bool status=apiResponse['status'];
        if(status){
          Get.back();
          getCurrencyRateModelList.clear();
          List<dynamic> data=apiResponse['rates'];
          for(int i=0;i<data.length;i++){
            getCurrencyRateModelList.add(GetCurrencyRatesModel.fromJson(data[i]));
          }

        }else{
          Get.back();
          showSnackbar(context, apiResponse['messsage'], redColor);
        }
      }else{
        Get.back();
        getError(apiResponse['error'], context);
      }

    }catch(e){
      Get.back();
      showSnackbar(context, 'Something went wrong', redColor);
    }
  }

  Future DeleteRate(BuildContext context, String token,int rate_id,int index) async{
    Get.dialog(CustomLoader());
    Uri url=Uri.parse(SERVER_URL+'delete-rate');
    try{
      var  header={
        "Content-Type":"application/json",
        "Accept" : "application/json",
        "Authorization": "Bearer $token"
      };

      var bodyData={
        'rate_id':rate_id
      };
      var body=jsonEncode(bodyData);

      var response=await http.post(url,headers: header,body: body);
      Map<String,dynamic> apiResponse=jsonDecode(response.body);
      if(response.statusCode==200){
        bool status=apiResponse['status'];
        if(status){
          Get.back();
          getCurrencyRateModelList.removeAt(index);
          //showSnackbar(context, apiResponse['messsage'], buttonColor);


        }else{
          Get.back();
          showSnackbar(context, apiResponse['messsage'], redColor);
        }
      }else{
        Get.back();
        getError(apiResponse['error'], context);
      }

    }catch(e){
      Get.back();
      showSnackbar(context, 'Something went wrong', redColor);
    }
  }

  Future UpdateRate(BuildContext context, String token, int fromCurrency, int toCurrency, String exchangeRate,int rate_id) async{
    Get.dialog(CustomLoader());
    Uri url=Uri.parse(SERVER_URL+'update-rate');
    try{
      var  header={
        "Content-Type":"application/json",
        "Accept" : "application/json",
        "Authorization": "Bearer $token"
      };
      Map  bodyData={
        'from_currency_id':fromCurrency,
        'to_currency_id':toCurrency,
        'exchange_rate':exchangeRate,
        'rate_id':rate_id
      };
      var body=jsonEncode(bodyData);
      var response=await http.post(url,headers: header,body: body);
      Map<String,dynamic> apiResponse=jsonDecode(response.body);
      if(response.statusCode==200){
        bool status=apiResponse['status'];
        if(status){
          Get.back();
         // showSnackbar(context, apiResponse['messsage'], buttonColor);
        }else{
          Get.back();
          showSnackbar(context, apiResponse['messsage'], redColor);
        }
      }else{
        Get.back();
        getError(apiResponse['error'], context);
      }

    }catch(e){
      Get.back();
      showSnackbar(context, 'Something went wrong', redColor);
    }
  }

  Future<bool> UpdateOfferStatus(BuildContext context, String token,
      int? offer_id, int? status_id,int? merchant_id) async {
    Get.dialog(CustomLoader());
    Uri url = Uri.parse(SERVER_URL + 'update-offer-status');
    try {
      var header = {
        'Content-Type': 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData = {
        'offer_id': offer_id,
        'status_id': status_id,
        'merchant_id':merchant_id
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          Get.back();
          showSnackbar(context, apiResponse['message'], buttonColor);
          return true;
        } else {
          Get.back();
          getError(apiResponse['error'], context);
          return false;
        }
      } else {
        Get.back();
        showSnackbar(context, 'Something went wrong', redColor);
        return false;
      }
    } catch (e) {
      Get.back();
      print('try catch error from privacyPolicy $e');
      return false;
    }
  }

  Stream<http.Response> chatMenu(BuildContext context,String token) async* {
    var header={
      'Content-Type':'application/json',
      "Accept" : "application/json",
      'Authorization':'Bearer $token'
    };
    //print('stream builder 4');
    yield* Stream.periodic(Duration(milliseconds:3000), (_) async{
      return await http.post(Uri.parse(SERVER_URL + 'chat-menu'),headers:header);
    }).asyncMap((event) async {
      //print('stream builder 4');
      // event.then((value) => print('stream builder 4 ${value.body}'));
      return await event;
    });
  }

  Stream<http.Response> showChat(BuildContext context,String token,int recieverId,int? transactionId) async* {
    var header={
      'Content-Type':'application/json',
      "Accept" : "application/json",
      'Authorization':'Bearer $token'
    };
    Map bodyData={
      'receiver_id':recieverId,
      'transaction_id':transactionId
    };
    var body=jsonEncode(bodyData);
    //print('stream builder 4');
    yield* Stream.periodic(Duration(milliseconds: 2000), (_) async{
      return await http.post(Uri.parse(SERVER_URL + 'show-chat'),headers:header,body: body);
    }).asyncMap((event) async {
      return await event;
    });
  }


  Future<void> otpRequest(phoneNumber, BuildContext context,int from) async {
    Get.dialog(CustomLoader());
    var auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {

        // auth.signInWithCredential(credential).then((value) {
        //   print('You are signed in succefully');
        //   registerRequest(
        //     context,
        //     firstName,
        //     lastName,
        //     email,
        //     password,
        //     phoneNumber.toString(),
        //     countryCode,
        //     userId,
        //     4,
        //     deviceToken,
        //   );
        //   // Navigator.push(
        //   //   context,
        //   //   MaterialPageRoute(
        //   //     builder: (context) => OTP(
        //   //       verificationIdRecieved: verificationIdRecieved,
        //   //     ),
        //   //   ),
        //   // );
        // });
      },
      verificationFailed: (FirebaseAuthException exception) {
        Get.back();
        print('Verification Failed ${exception.message}');
        showSnackbar(context, '${exception.message}',redColor);

      },
      codeSent: (String verificationId, int? resendToken) async{
        verificationIdRecieved = verificationId;
        print('verification id  is $verificationId');
        Get.back();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(
              verificationIdRecieved: verificationId,
              from: from,
            ),
          ),
        );
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificatioId) {
        verificationIdRecieved = verificatioId;
        Get.back();
      },
    );
  }






  getNotificationsPermissions() {
    Future<PermissionStatus> permissionStatus =
    NotificationPermissions.getNotificationPermissionStatus();

    permissionStatus.then((value) async => {
      if (value == PermissionStatus.unknown)
        {NotificationPermissions.requestNotificationPermissions()}
      else if (value == PermissionStatus.denied)
        {
          NotificationPermissions.requestNotificationPermissions(
              openSettings: true)
        }
      else if(value == PermissionStatus.granted){
          // saveToken()
        }
    });
  }



  void showSnackbar(BuildContext context, String text,Color color) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color,
      message: text,
      duration: Duration(seconds: 2),
      animationDuration: Duration(milliseconds: 200),
    ));
  }

   getError(Map<String, dynamic> error,context){
    Map<String, dynamic> errorResponse = error;
    errorResponse.forEach((key, value) {
      List<dynamic> message =  errorResponse[key];
      if(message.isNotEmpty) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: message[0],
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 500),
        ));
      }
    });
  }

  getImageFromGallery(){

  }





  //getters
  String get firstName => _firstName ?? '';
  String get lastName => _lastName ?? '';
  String get email => _email ?? '';
  String get password => _password ?? '';
  String get userId => _userId ?? '';
  int get roleId => _roleId!;
  String get contact => _contact ?? '';
  String get countryCode => _countryCode??'';
  String get deviceToken => _deviceToken??'';
  String get balance => _balance!;
  int get id => _id!;
  List<String> get countryNameForTopFiveMerchantes =>
      _countryNameForTopFiveMerchantes;
  String get bearerToken => _bearerToken!;

  String get default_currency => _default_currency!;
  String get photoUrl => _photoUrl??'';
  String get rating => _rating!;
  int get defaultCurrencyId => _defaultCurrencyId!;
  String get defaultCurrencyName => _defaultCurrencyName!;
  String get defaultCurrencySymbol => _defaultCurrencySymbol!;
  List<UserWalletsModel> get userWalletModelList => _userWalletModelList;
  int get selectedCurrencyId => _selectedCurrencyId!;
  String get selectedWalletBalance => _selectedWalletBalance!;
  String get selectedCurrencySymbol => _selectedCurrencySymbol!;
  String get currencySymbolForExchangeRateScreen => _currencySymbolForExchangeRateScreen ?? '';
  String get countryName => _countryName ?? '';
  String? get idFile => _idFile;
  String? get buisnessName => _buisnessName;
  String? get idFileForlocal => _idFileForlocal;
  int get screenIndex => _screenIndex;
  String? get updatedContact => _updatedContact;
  Map<String, dynamic>? get chatOffers => _chatOffers;
}

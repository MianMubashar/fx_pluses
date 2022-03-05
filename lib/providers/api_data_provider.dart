import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/model/accepted_request_merchants_model.dart';
import 'package:fx_pluses/model/chat_menu_model.dart';
import 'package:fx_pluses/model/customer_transaction_history_model.dart';
import 'package:fx_pluses/model/faqs_model.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/model/merchant_transaction_requests_model.dart';
import 'package:fx_pluses/model/show_chat_model.dart';
import 'package:fx_pluses/model/top_five_merchants.dart';
import 'package:fx_pluses/screens/customer/cbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/customer/cwallet_to_wallet_transfer.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiDataProvider extends ChangeNotifier {
  static const String BASE_URL =
      'http://192.168.18.17/FX_Pluses/FX_Pluses/public/';
  String SERVER_URL = BASE_URL + 'api/';
  String verificationId = '';
//setters
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _contact;
  String? _countryCode;
  String? _userId;
  int? _roleId;
  String? _deviceToken;
  String verificationIdRecieved='';
  bool otp_check=false;
  String? _balance;
  List<TopFiveMerchants> top_five_merchant_list=[];
  List<GetCountriesForMerchants> getCountriesForMerchants=[];
  List<String> _countryNameForTopFiveMerchantes=[];
  List<MerchantTransactionRequestsModel> merchantTransactionRequestsList=[];
  List<AcceptedRequestMerchantsModel> acceptedRequestMerchantsList=[];
  List<ChatMenuModel> usersHavingChatList=[];
  List<CustomerTransactionHistoryModel> customerTransactionHistoryList=[];
  List<FaqsModel> faqsList=[];
  List<ShowChatModel> showChatList=[];
  Map? appSetting;
  Map? aboutUs;
  String? _bearerToken;
  String? _rating;
  String? _default_currency;
  String? _photoUrl;




  setBearerToken(String bt){
    _bearerToken=bt;
  }

  setFirstName(String firstName) {
    this._firstName = firstName;
  }

  setLastName(String lastName) {
    this._lastName = lastName;
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
  }

  setCountryCode(String contryCode) {
    this._countryCode = contryCode;
  }

  setToken(String token) {
    this._deviceToken = token;
  }

  setBalance(String balance){
    _balance=balance;
    notifyListeners();
  }
  setCountryName(String name){
    _countryNameForTopFiveMerchantes.add(name);
  }
  setRating(String r){
    _rating=r;
  }
  setDefaultCurrency(String dc){
    _default_currency=dc;
  }
  setPhotoUrl(String photo){
    _photoUrl=photo;
  }



  Future<bool> registerRequest(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String password,
    String contact,
    String countryCode,
    String? userId,
    int roleId,
    String deviceToken,
  ) async {
    Uri url = Uri.parse(SERVER_URL + 'register');
    try {
      var header = {
        "Content-Type": "application/json",
      };

      Map customerData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'contact_no': contact,
        'country_code': countryCode,
        'role_id': roleId,
        'device_token': deviceToken
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
        'device_token': deviceToken
      };

      var body = jsonEncode(roleId == 5 ? customerData : merchantData);

      var response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        print('body is ${response.body}');
        if (status) {
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
          print('status is $status');
          showSnackbar(context, apiResponse['error']);
          return false;
        }
      } else {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        showSnackbar(context, apiResponse['error']['email'][0].toString());
        return false;
      }
    } catch (e) {
      print('try catch error ${e}');
      showSnackbar(context, e.toString());
    }

    return false;
  }

  Future<bool> loginRequest(BuildContext context, String email, String password,
      String device_token) async {
    Uri url = Uri.parse(SERVER_URL + 'login');
    try {
      var header = {
        "Content-Type": "application/json",
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
          String user_id=apiResponse['user']['id'].toString();
          String firstName=apiResponse['user']['first_name'];
          String lastName=apiResponse['user']['last_name'];
          String email=apiResponse['user']['email'];
          String wallet=apiResponse['user']['wallet'];
          int role_id=apiResponse['user']['role_id'];
          String country_code=apiResponse['user']['country_code'];
          String rating=apiResponse['user']['rating'];
          //String? default_currency=apiResponse['user']['default_currency'];
          String photo_url=apiResponse['user']['profile_photo_url'];
          String token=apiResponse['token'];

          await SharedPreference.saveUserIdSharedPreferences(user_id);
          await SharedPreference.saveFirstNameSharedPreferences(firstName);
          await SharedPreference.saveLastNameSharedPreferences(lastName);
          await SharedPreference.saveEmailSharedPreferences(email);
          await SharedPreference.saveWalletBalanceSharedPreferences(wallet);
          await SharedPreference.saveRoleIdSharedPreferences(role_id);
          await SharedPreference.saveCountryCodeSharedPreferences(country_code);
          await SharedPreference.saveRatingSharedPreferences(rating);
          //await SharedPreference.saveDefaultCurrencySharedPreferences(default_currency!);
          await SharedPreference.savePhotoUrlSharedPreferences(photo_url);
          await SharedPreference.saveBearerTokenSharedPreferences(token);
          await SharedPreference.saveIsLoggedInSharedPreferences(true);


          setUserId(user_id);
          setFirstName(firstName);
          setLastName(lastName);
          setEmail(email);
          setBalance(wallet);
          setRoleId(role_id);
          setCountryCode(country_code);
          setRating(rating);
          //setDefaultCurrency(default_currency);
          setPhotoUrl(photo_url);
          setBearerToken(token);
          if(roleId==5){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CBottomNavigationBar(),
              ),
            );
          }else{
            if(roleId==4){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MBottomNavigationBar(),));
            }
          }



          return false;
        } else {
          print('status is $status');
          return false;
        }
      } else {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        print(
            "status code is ${response.statusCode} and ${apiResponse['error']}");
        showSnackbar(context, 'Email or Password is incorrect');
        return false;
      }
    } catch (e) {
      print('try catch error from login ${e}');
      return false;
    }
  }

  Future<bool> updateWallet(BuildContext context, String token,int wallet_action_id,String amount,int to_user_id,String accountNumber,String name) async{
    Uri url=Uri.parse(SERVER_URL + 'update-wallet');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try{
      if(token!=null) {
        var header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };


        Map addBalanceData = {
          'wallet_action_id': wallet_action_id,
          'amount': amount,
          //'device_token': device_token
        };
        Map withdrawData = {
          'wallet_action_id': wallet_action_id,
          'acc_owner_name': name,
          'acc_number': accountNumber,
          'amount': amount,
          //'device_token': device_token
        };
        Map walletToWalletTransferData = {
          'wallet_action_id': wallet_action_id,
          'amount': amount,
          'to_user_id': to_user_id
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
            showSnackbar(context, apiResponse['message']);
            // Navigator.pop(context);
          } else {
            //showSnackbar(context, '')
          }
        } else {
          showSnackbar(context, apiResponse['error']['acc_number'][0]);
        }
      }else{
        print('token is null');
      }

    }catch(e){
      print('try catch error in update wallet $e');
    }
    return false;
  }

  Future getMercchantes(BuildContext context, String token,String amount,String countryCode) async {
    Uri url = Uri.parse(SERVER_URL + 'get-merchants');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'country_code': countryCode,
        'amount': amount,
        //'device_token': device_token
      };
      var body=jsonEncode(data);
      var response=await http.post(url, body: body,headers: header);
      if(response.statusCode==200){
        top_five_merchant_list.clear();
        print(jsonDecode(response.body));
        Map<String, dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
          List<dynamic> data=apiResponse['merchants'];
          for(int i=0; i<data.length;i++){
            top_five_merchant_list.add(TopFiveMerchants.fromJson(data[i]));
          }

        }
      }
    }catch(e){
      showSnackbar(context, 'Something is wrong');
    }
  }

  Future getCountries(BuildContext context, String token,) async{
    Uri url = Uri.parse(SERVER_URL + 'get-countries');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };


      var response=await http.post(url, headers: header);
      if(response.statusCode==200){
        print(jsonDecode(response.body));
        Map<String,dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
           getCountriesForMerchants.clear();
          List<dynamic> data=apiResponse['countries'];
          for( int i=0;i<data.length;i++){
            getCountriesForMerchants.add(GetCountriesForMerchants.fromJson(data[i]));

          }
        }else{
          showSnackbar(context, 'Status false');
        }

      }
    }catch(e){
      print('try catch error is ${e}');
    }
  }

  Future requestTransaction(BuildContext context, String amount, int id,String token) async {
    Uri url = Uri.parse(SERVER_URL + 'request-transaction');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'to_user_id': id,
        'amount': amount,
        //'device_token': device_token
      };
      var body = jsonEncode(data);
      var response = await http.post(url, body: body, headers: header);
      if(response.statusCode==200){
        Map<String,dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
          print(apiResponse['message']);
          showSnackbar(context, apiResponse['message']);
        }
      }
    }catch(e){
      print('Try Catch Error from request transaction $e');
    }
  }

  Future merchantTransactionRequests(BuildContext context,String token) async {
    Uri url = Uri.parse(SERVER_URL + 'merchant-transaction-requests');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var response=await http.post(url,headers: header);
      if(response.statusCode==200){
        Map<String,dynamic> apiResponse=jsonDecode(response.body);
        print(apiResponse.values);
        bool status=apiResponse['status'];
        if(status){
          merchantTransactionRequestsList.clear();
          List<dynamic> data=apiResponse['requests'];
          for(int i=0; i<data.length;i++){
             merchantTransactionRequestsList.add(MerchantTransactionRequestsModel.fromJson(data[i]));
          }
        }
      }
    }catch(e){

    }
  }

  Future accepteOrNotStatusRequest(BuildContext context,String token,String status,int transaction_id,int index) async {
    Uri url = Uri.parse(SERVER_URL + 'update-transaction-request-status');
    //String token='27|RttDuIFEcRlrBNtVvkDqG1vEYZBLQ1nZsFT7fSaZ';
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      Map data = {
        'status': status,
        'transaction_id': transaction_id,
      };
      var body = jsonEncode(data);
      var response = await http.post(url, body: body, headers: header);
      if(response.statusCode==200){
        Map<String,dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
          print(apiResponse['message']);
          showSnackbar(context, apiResponse['message']);
          //merchantTransactionRequestsList.removeAt(index);
        }
      }

    }catch(e){
      print('try catch error from accepterOrNotStatusRequest $e');
    }
  }
  Future acceptedRequests(BuildContext context, String token) async{
    Uri url=Uri.parse(SERVER_URL + "accepted-transaction-request");
    try{
      var header={
        "Content-Type":"application/json",
        "Authorization": "Bearer $token"
      };
      var response=await http.post(url,headers: header);
      if(response.statusCode==200){
        Map<String,dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
          acceptedRequestMerchantsList.clear();
          List<dynamic> data=apiResponse['transaction_requests'];
          for(int i=0;i<data.length;i++){
            acceptedRequestMerchantsList.add(AcceptedRequestMerchantsModel.fromJson(data[i]));
          }
        }
      }else{
        print('status code is not 200');
        showSnackbar(context, 'Something went wrong');
      }
    }catch(e){
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

  Future customerTrancationHistory(BuildContext context,String token,) async{
    Uri url=Uri.parse(SERVER_URL + "customer-transaction-history");
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.post(url, headers: header);
      if(response.statusCode==200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];

        if(status){
          usersHavingChatList.clear();
          List<dynamic> data=apiResponse['transaction_history'];
          for(int i=0;i<data.length;i++){
            customerTransactionHistoryList.add(CustomerTransactionHistoryModel.fromJson(data[i]));
          }
        }
      }else{
        print('status is not 200');
      }
    }catch(e){
      print('try catch error from customerTrancationHistory $e');
    }
  }

  Future getAppData(BuildContext context,String token,) async{
    Uri url=Uri.parse(SERVER_URL + "get-app-data");
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      var response = await http.post(url, headers: header);
      if(response.statusCode==200) {
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];

        if(status){
          appSetting=apiResponse['app_settings'];
          aboutUs=apiResponse['about_us'];
          List<dynamic> data=apiResponse['faqs'];
          for(int i=0;i<data.length;i++){
            faqsList.add(FaqsModel.fromJson(data[i]));
          }
        }
      }else{
        print('status is not 200');
      }
    }catch(e){
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
  Future contactUs(BuildContext context, String token, String message) async{
    Uri url=Uri.parse(SERVER_URL + "store-contact-message");
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData={
        "message":message
      };
      var body=jsonEncode(bodyData);
      var response = await http.post(url, headers: header,body: body);
      if(response.statusCode==200){
        Map<String, dynamic> apiResponse=jsonDecode(response.body);
        bool status=apiResponse['status'];
        if(status){
          String m=apiResponse['message'];
          showSnackbar(context, m);
        }
      }
    }catch(e){
      print('try catch error from contactUs $e');
    }
  }

  Future sendMessage(BuildContext context, String token, int recieverid, String message,String filePath,String name) async{
    Uri url=Uri.parse(SERVER_URL + "send-message");
    try {
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      Map bodyData={
        "receiver_id":recieverid,
        "message":message
      };
      Map bodyData2={
        "receiver_id":recieverid,
      };
      var body;
      var response;
      if(message != ''){
        body=jsonEncode(bodyData);
        response=await http.post(url, headers: header,body: body);
      }else{
        var request=await http.MultipartRequest('POST',url);
        request.headers['Authorization']="Bearer $token";
        request.fields['receiver_id']='$recieverid';
        request.files.add(
            await http.MultipartFile.fromPath(
                'file',
                filePath
            )
        );

        response=await request.send();
        //print(response.body);
        print(response.statusCode);
      }


      Map<String, dynamic> apiResponse;
      if(message==''){
        final res = await http.Response.fromStream(response);
        apiResponse=jsonDecode(res.body);
      }else{
        apiResponse=jsonDecode(response.body);
      }
      if(response.statusCode==200){


        bool status=apiResponse['status'];
        if(status){
          String m=apiResponse['message'];
          showSnackbar(context, m);
        }else{
          print('status is not true from sendMessage');
        }
      }else{
        print('status from send message ${apiResponse['error']}');
      }
    }catch(e){
      print('try catch error from sendMessage $e');
    }
    }

  Stream<http.Response> chatMenu(BuildContext context,String token) async* {
    var header={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    };
    //print('stream builder 4');
    yield* Stream.periodic(Duration(milliseconds: 1000), (_) async{
      return await http.post(Uri.parse(SERVER_URL + 'chat-menu'),headers:header);
    }).asyncMap((event) async {
      //print('stream builder 4');
      // event.then((value) => print('stream builder 4 ${value.body}'));
      return await event;
    });
  }

  Stream<http.Response> showChat(BuildContext context,String token,int recieverId) async* {
    var header={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    };
    Map bodyData={
      'receiver_id':recieverId
    };
    var body=jsonEncode(bodyData);
    //print('stream builder 4');
    yield* Stream.periodic(Duration(milliseconds: 1000), (_) async{
      return await http.post(Uri.parse(SERVER_URL + 'show-chat'),headers:header,body: body);
    }).asyncMap((event) async {
      return await event;
    });
  }


  Future<void> otpRequest(phoneNumber, BuildContext context) async {
    otp_check=true;
    var auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(
              verificationIdRecieved: verificationIdRecieved,
            ),
          ),
        );
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
        print('Verification Failed ${exception.message}');
        showSnackbar(context, 'Verification Failed');

      },
      codeSent: (String verificationId, int? resendToken) async{
        verificationIdRecieved = verificationId;
        print('verification id  is $verificationId');
        otp_check=false;

      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificatioId) {
        verificationIdRecieved = verificatioId;
      },
    );
  }



  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(text),
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }



  //getters
  String get firstName => _firstName!;
  String get lastName => _lastName!;
  String get email => _email!;
  String get password => _password!;
  String get userId => _userId!;
  int get roleId => _roleId!;
  String get contact => _contact!;
  String get countryCode => _countryCode!;
  String get deviceToken => _deviceToken!;
  String get balance => _balance!;
  List<String> get countryNameForTopFiveMerchantes =>
      _countryNameForTopFiveMerchantes;
  String get bearerToken => _bearerToken!;

  String get default_currency => _default_currency!;
  String get photoUrl => _photoUrl!;
  String get rating => _rating!;
}

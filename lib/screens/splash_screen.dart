import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/onboarding_content.dart';
import 'package:fx_pluses/model/user_wallets_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:fx_pluses/screens/customer/cbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/home.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  static final String id = 'SplashScreen_Screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  // int? userId;
  // String? firstName;
  // String? lastName;
  // String? email;
  // String? balance;
  //
  // String? countryCode;
  // String? rating;
  // String? photoUrl;
  // int? defaultCurrenceyId;
  // String? defaultCurrenceyName;
  // String? defaultCurrenceySymbol;
  // String? listData;
  // List<UserWalletsModel>? list;
  String deviceToken='test';
  String bearerToken='';






  startApp() async {

    await getNotificationSettings();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // initScreen = await preferences.getInt('initScreen');
    // roleId=await preferences.getInt(SharedPreference.roleIdKey);



      print('get data');
      //SharedPreferences preferences=await SharedPreferences.getInstance();
      bearerToken=await preferences.getString(SharedPreference.bearerTokenKey) ?? "";
      int? initScreen=await preferences.getInt('initScreen');
      if(initScreen != 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())
        );
      }else{
        await Provider.of<ApiDataProvider>(context,listen: false).validateToken(context, bearerToken);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startApp();
    //setupInteractedMessage();
  }

  Future<void> _handleMessage(RemoteMessage message) async{
  print('notification opened');
  }
  Future getNotificationSettings() async{

    if(Platform.isIOS) {
      await getIosNotificationsPermissions();
    }else{

        deviceToken = (await FirebaseMessaging.instance.getToken())!;

    }

    print(deviceToken);

    await Provider.of<ApiDataProvider>(context,listen: false).setToken(deviceToken);
    await SharedPreference.saveDeviceToken(deviceToken);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('data from get initial message ${message.messageId}');
        // Navigator.pushNamed(
        //   context,
        //   ChatScreen.id
        //   arguments: MessageArguments(message, true),
        // );
      }
    });

    FirebaseMessaging.onMessage.listen((event) async{

      print('data recieved ${event.data}');
      if(event.data.containsKey('wallet')){
        //int balance=int.parse(event.data['wallet']['id']);
        Map<String, dynamic> wallet=jsonDecode(event.data['wallet']);
        if(wallet['user_id']==Provider.of<ApiDataProvider>(Get.context!,listen: false).id && event.data['wallet_action_id']=='3'){

          SharedPreferences pref = await SharedPreferences.getInstance();
          String? wallletList = await pref.getString(
              SharedPreference.userWalletsKey);
          List<UserWalletsModel> list = UserWalletsModel.decode(wallletList!);
          list.forEach((element) async {
            if(element.currency_id == wallet['currency_id']){
              String amount1 = element.wallet;
              List a = amount1.split('.');
              int amount2 = int.parse(a[0]);
              int amount3 = double.parse(wallet['wallet'].toString()).round();
              // int total = amount2 + amount3;
              element.wallet=amount3.toString();
              Provider.of<ApiDataProvider>(Get.context!,listen: false).setBalance(amount3.toString());
              Provider.of<ApiDataProvider>(Get.context!,listen: false).setSelectedWalletBalance(amount3.toString());

            }
          });
          await Provider.of<ApiDataProvider>(Get.context!,listen: false).setUserWalletModelList(list);
          final String encodedData = UserWalletsModel.encode(list);
          await SharedPreference.saveUserWalletsSharedPreferences(
              encodedData);
        }



      }




      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: buttonColor,
                  playSound: true,
                icon: '@mipmap/ic_launcher'
                //icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
      print('Notification recieved');
      // Local Notifications Library will be showing with event.notification.title & event.notification.body
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    // FirebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );

  }
  getIosNotificationsPermissions() {
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
          deviceToken = (await FirebaseMessaging.instance.getToken())!

        }
    });
  }
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF8F38FF)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/logo.png',
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          )),
          CircularProgressIndicator(color: whiteColor,)
        ],
      ),
    );
  }
}

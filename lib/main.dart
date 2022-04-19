import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/l10n/l10n.dart';
import 'package:fx_pluses/model/onboarding_content.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/providers/language_provider.dart';
import 'package:fx_pluses/screens/about.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:fx_pluses/screens/contact.dart';
import 'package:fx_pluses/screens/customer/cbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/ccreate_account.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend2.dart';
import 'package:fx_pluses/screens/customer/cmerchant_profile.dart';
import 'package:fx_pluses/screens/customer/cmessages.dart';
import 'package:fx_pluses/screens/customer/creciever_info.dart';
import 'package:fx_pluses/screens/customer/crefer_code.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/wallet_to_wallet_transfer.dart';
import 'package:fx_pluses/screens/customer/cwithdraw.dart';
import 'package:fx_pluses/screens/customer/profile.dart';
import 'package:fx_pluses/screens/faq.dart';
import 'package:fx_pluses/screens/help_support.dart';
import 'package:fx_pluses/screens/home.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/login_signup/signup.dart';
import 'package:fx_pluses/screens/merchant/mbottom_navigation_bar.dart';
import 'package:fx_pluses/screens/merchant/mcreate_account.dart';
import 'package:fx_pluses/screens/merchant/mexchange_rates.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/mtransaction_requests.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';
import 'package:fx_pluses/screens/splash_screen.dart';
import 'package:fx_pluses/screens/terms_conditions.dart';
import 'package:fx_pluses/screens/test.dart';
import 'package:fx_pluses/screens/transaction_history.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future notificationSelected(String? payload) async {

}

Future<void> _firbaseHandler(RemoteMessage message) async{
await Firebase.initializeApp();
print('a bg msg is showed up ${message.messageId}');

}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firbaseHandler);

  var initilizationsSettings =
  InitializationSettings(android: AndroidInitializationSettings('ic_launcher'),iOS: IOSInitializationSettings());
  await flutterLocalNotificationsPlugin.initialize(initilizationsSettings,
      onSelectNotification: notificationSelected);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );



  Stripe.publishableKey =
      'pk_test_51KUTspLzsnFu9r8sQ875Kw4dt72c3zSKZSIWf8MuNTp1tZSAY8kLTZWEqoNt3OeZ7P2h1eay3PkIpLedJ2aDGN5000lPap05Pc';
  HttpOverrides.global=MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ApiDataProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider())
    ],

    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // delegate from flutter_localization
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: Provider.of<LanguageProvider>(context, listen: true).locale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }

        // define pt_BR as default when de language code is 'pt'
        if (locale?.languageCode == 'pt') {
          return Locale('pt', 'BR');
        }

        // default language
        return Locale('en', 'US');
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   /* dark theme settings */
      // ),

      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        Home.id: (context) => Home(),
        Login.id: (context) => Login(),
        CBottomNavigationBar.id: (context)=>CBottomNavigationBar(index: 0,),
        CCreateAccount.id: (context) => CCreateAccount(),
        CHome.id: (context) => CHome(),
        CInviteFriend.id: (context) => CInviteFriend(),
        //CInviteFriend2.id: (context) => CInviteFriend2(),
        //CMerchantProfile.id: (context) => CMerchantProfile(),
        CMessages.id: (context) => CMessages(),
        //CRecieverInfo.id: (context) => CRecieverInfo(),
        CReferCode.id: (context) => CReferCode(),
        CWallet.id: (context) => CWallet(),
        WalletToWalletTransfer.id: (context) => WalletToWalletTransfer(),
        CProfile.id: (context) => CProfile(backButtonEnabled: false,),
        Signup.id: (context) => Signup(),
        MCreateAccount.id: (context) => MCreateAccount(),
        MHome.id: (context) => MHome(),
        MTransactionRequests.id: (context) => MTransactionRequests(),
        About.id: (context) => About(),
        // ChatScreen.id: (context) => ChatScreen(),
        ContactUs.id: (context) => ContactUs(),
        FAQ.id: (context) => FAQ(),
        HelpSupport.id: (context) => HelpSupport(),
        TermsConditions.id: (context) => TermsConditions(),
        TransactionHistory.id: (context) => TransactionHistory()
      },
      //home: SplashScreen(),
      //navigatorObservers: [NavigationHistoryObserver()],
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
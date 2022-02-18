import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/customer/bottom_navigation_bar.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/home.dart';
import 'package:fx_pluses/screens/login_signup/create_account/create_account.dart';
import 'package:fx_pluses/screens/login_signup/create_account/signup.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';
import 'package:fx_pluses/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey='pk_test_51KUTspLzsnFu9r8sQ875Kw4dt72c3zSKZSIWf8MuNTp1tZSAY8kLTZWEqoNt3OeZ7P2h1eay3PkIpLedJ2aDGN5000lPap05Pc';
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context)=>ApiDataProvider())
      ],
      child: MyApp(),)
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Bottomnavigationbar(),
    );
  }
}
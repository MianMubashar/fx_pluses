import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/top_container.dart';
import 'package:fx_pluses/screens/login_signup/create_account/create_account.dart';
import 'package:fx_pluses/screens/login_signup/create_account/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(
                title: "Hey, Welcome Back!",
                description1: 'Don\'t have an account ',
                size: size,
                onPress: () {
                  print('Create an account clicked');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (contet) => Signup(),
                    ),
                  );
                },
                description2: 'Create an accounnt',
              ),
              Text(
                'Email Address',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              const Text(
                'Password',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  obscureText: obscure,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset('assets/svgs/peye.svg'),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      ),
                      hintText: 'xxxxxxxxxxxx',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  print('forgot password clicked');
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgotten Password?',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: newColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              MainButton(text: 'Log in', onPress: () {})
            ],
          ),
        ),
      ),
    );
  }
}

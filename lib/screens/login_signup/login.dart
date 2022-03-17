import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/top_container.dart';
import 'package:fx_pluses/screens/login_signup/signup.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  static final String id='Login_Screen';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscure = true;
  String email='';
  String password='';
  String deviceToken='';
  bool check=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  getDeviceToken() async {
    deviceToken = (await FirebaseMessaging.instance.getToken())!;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ApiDataProvider>(context,listen: false).check,
        child: SafeArea(
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
                    Navigator.push(
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
                    onChanged: (value){
                      email=value;
                    },
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
                    onChanged: (value){
                      password=value;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if(email==''){
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter email', redColor);
                    }else{
                      final bool isValid = EmailValidator.validate(email);
                      if(!isValid){
                        Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid email', redColor);
                      }else{
                    Provider.of<ApiDataProvider>(context,listen: false).forgotPassword(context,
                         email);
                    //print('forgot password clicked');
                  }
                    }
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
                MainButton(text: 'Log in', onPress: () {
                  print('login clicked');
                  if(email==''){
                    Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter email',redColor);
                  }else{
                    if(password==''){
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter password',redColor);
                    }else{
                      final bool isValid = EmailValidator.validate(email);
                      if(isValid){
                        print('isValid $isValid');
                        setState(() {
                          Provider.of<ApiDataProvider>(context,listen: false).check=true;

                        });

                       Provider.of<ApiDataProvider>(context,listen: false).loginRequest(context, email, password, deviceToken);
                       setState(() {
                         Provider.of<ApiDataProvider>(context,listen: false).check=false;
                       });
                      }else{
                        Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid email address',redColor);
                      }

                    }
                  }

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

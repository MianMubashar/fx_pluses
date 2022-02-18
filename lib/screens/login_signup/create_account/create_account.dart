import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fx_pluses/currency_codes.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/top_container.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';

import '../../../constants.dart';
import '../login.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool obscure = true;
  String _value = "1";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Icon(Icons.flag),value: "1",alignment: Alignment.center,),
      DropdownMenuItem(child: Text("Canada"),value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
      DropdownMenuItem(child: Text("England"),value: "England"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(
                title: "Tell us about you...",
                description1: 'Already have an account? ',
                size: size,
                onPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                description2: 'Log in Now',
              ),
              Text(
                'Enter Phone Number',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: DropdownButton(
                      items: dropdownItems,
                      value: _value,
                      onChanged: (String? value){
                        setState(() {
                          _value=value!;
                        });
                      },
                    ),
                      hintText: 'Phone Number',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              Text(
                'First Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              Text(
                'Last Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
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
                margin: EdgeInsets.only(bottom: 10),
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
              Text(
                'Password',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
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
              Center(
                child: RichText(
                    text: TextSpan(
                        text:
                            'By creating an account, you’re agreeing to our\n',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                        text: '        ',
                      ),
                      TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: newColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Terms and Conditions clicked');
                            }),
                      TextSpan(
                        text: 'and',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: newColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Privacy and Policy clicked');
                            }),
                    ])),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              MainButton(
                  text: 'Continue',
                  onPress: () {
                    print('continue presses');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTP(),
                      ),
                    );
                  })
            ],
          ),
        ),
      )),
    );
  }
}

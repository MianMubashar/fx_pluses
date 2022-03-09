import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/top_container.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/otp.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';

import '../../../constants.dart';

class MCreateAccount extends StatefulWidget {
  static final String id='MCreateAccount_Screen';
  const MCreateAccount({Key? key}) : super(key: key);

  @override
  _MCreateAccountState createState() => _MCreateAccountState();
}

class _MCreateAccountState extends State<MCreateAccount> {
  bool obscure = true;
  String _value = "1";
  PhoneNumber? phoneNumber;
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String countryCode = '';
  String currencyCode='';
  String deviceToken = '';
  String userId = '';
  bool numberValid = false;
  String verificationIdRecieved = '';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumbercontroller = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  getDeviceToken() async {
    deviceToken = (await FirebaseMessaging.instance.getToken())!;
  }

  // Future<void> otpRequest(phoneNumber, BuildContext context) async {
  //   var auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber.toString(),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       auth.signInWithCredential(credential).then((value) {
  //         print('You are signed in succefully');
  //         Provider.of<ApiDataProvider>(context, listen: false).registerRequest(
  //           context,
  //           firstName,
  //           lastName,
  //           email,
  //           password,
  //           phoneNumber.toString(),
  //           countryCode,
  //           userId,
  //           4,
  //           deviceToken,
  //         );
  //       });
  //
  //     },
  //     verificationFailed: (FirebaseAuthException exception) {
  //       print('Verification Failed ${exception.message}');
  //       Provider.of<ApiDataProvider>(context, listen: false)
  //           .showSnackbar(context, 'Verification Failed');
  //     },
  //     codeSent: (String verificationId, int? resendToken) async{
  //       verificationIdRecieved = verificationId;
  //       print('verification id  is $verificationId');
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setContact(phoneNumber.toString());
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setUserId(userId);
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setFirstName(firstName);
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setLastName(lastName);
  //       await Provider.of<ApiDataProvider>(context, listen: false).setEmail(email);
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setPassword(password);
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setCountryCode(countryCode);
  //       await Provider.of<ApiDataProvider>(context, listen: false).setRoleId(4);
  //       await Provider.of<ApiDataProvider>(context, listen: false)
  //           .setToken(deviceToken);
  //
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OTP(
  //             verificationIdRecieved: verificationIdRecieved,
  //           ),
  //         ),
  //       );
  //     },
  //     timeout: Duration(seconds: 60),
  //     codeAutoRetrievalTimeout: (String verificatioId) {
  //       verificationIdRecieved = verificatioId;
  //     },
  //   );
  // }

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
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InternationalPhoneNumberInput(
                  countries: ['PK'],
                  //formatInput: true,
                  initialValue: phoneNumber,
                  errorMessage: 'Invalid Phone Nummber',
                  hintText: '3150001320',
                  textFieldController: phoneNumbercontroller,

                  spaceBetweenSelectorAndTextField: 0,
                  selectorButtonOnErrorPadding: 0,
                  inputDecoration: InputDecoration(
                    // filled: true,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 0,
                    useEmoji: true,
                    showFlags: true,
                    //trailingSpace: true
                  ),
                  onInputValidated: (bool value) {
                    numberValid = value;
                  },
                  onInputChanged: (value) async{
                    print('${value.phoneNumber}');
                    countryCode = value.isoCode.toString();
                    print('${CountryPickerUtils.getCountryByIsoCode(countryCode).name.toString()}');
                    currencyCode=CountryPickerUtils.getCountryByIsoCode(countryCode).currencyCode.toString();
                    //CountryPickerUtils.getDefaultFlagImage('country');
                   // currencyCode= await NumberFormat.simpleCurrency(locale: Platform.localeName).currencyName.toString();

                    print('phone number is $value');
                    print(countryCode+" and "+currencyCode);
                    phoneNumber = value;
                  },
                ),
              ),
              Text(
                'Username',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: 'Username',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    userId = value;
                  },
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
                  controller: firstNameController,
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    firstName = value;
                  },
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
                  controller: lastNameController,
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    lastName = value;
                  },
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
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    email = value;
                  },
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
                  controller: passwordController,
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
                  onChanged: (value) {
                    password = value;
                  },
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
                          text: 'Terms&Conditions',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: newColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Terms and Conditions clicked');
                            }),
                      TextSpan(
                        text: ' and ',
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
                  onPress: () async{
                    print('continue presses');
                    if (firstName == '') {
                      Provider.of<ApiDataProvider>(context, listen: false)
                          .showSnackbar(context, 'Please enter first name');
                    } else {
                      if (lastName == '') {
                        Provider.of<ApiDataProvider>(context, listen: false)
                            .showSnackbar(context, 'Please enter last name');
                      } else {
                        if (email == '') {
                          Provider.of<ApiDataProvider>(context, listen: false)
                              .showSnackbar(context, 'Please enter email');
                        } else {
                          final bool isValid = EmailValidator.validate(email);
                          if (!isValid) {
                            Provider.of<ApiDataProvider>(context, listen: false)
                                .showSnackbar(context,
                                    'Please enter valid email address');
                          } else {
                            if (password == '') {
                              Provider.of<ApiDataProvider>(context,
                                      listen: false)
                                  .showSnackbar(
                                      context, 'Please enter password');
                            } else {
                              if (phoneNumber.toString().length <=
                                  countryCode.toString().length) {
                                Provider.of<ApiDataProvider>(context,
                                        listen: false)
                                    .showSnackbar(
                                        context, 'Please enter phone number');
                              } else {
                                if (!numberValid) {
                                  Provider.of<ApiDataProvider>(context,
                                          listen: false)
                                      .showSnackbar(context,
                                          'Please enter valid phone number');
                                } else {
                                  if (deviceToken == '') {
                                    const CircularProgressIndicator(
                                      color: newColor,
                                    );
                                  } else {
                                    Provider.of<ApiDataProvider>(context, listen: false).setContact(phoneNumbercontroller.text);
                                    Provider.of<ApiDataProvider>(context, listen: false).setFirstName(firstName);
                                    Provider.of<ApiDataProvider>(context, listen: false).setLastName(lastName);
                                    Provider.of<ApiDataProvider>(context, listen: false).setEmail(email);
                                    Provider.of<ApiDataProvider>(context, listen: false).setPassword(password);
                                    Provider.of<ApiDataProvider>(context, listen: false).setToken(deviceToken);
                                    Provider.of<ApiDataProvider>(context, listen: false).setCountryCode(countryCode);
                                    Provider.of<ApiDataProvider>(context, listen: false).setRoleId(4);
                                    Provider.of<ApiDataProvider>(context, listen: false).setUserId(usernameController.text);
                                     // Provider.of<ApiDataProvider>(context, listen: false).otp_check==false
                                     Provider.of<ApiDataProvider>(context, listen: false)
                                         .otpRequest(phoneNumber, context);
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }

                  })
            ],
          ),
        ),
      )),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/top_container.dart';
import 'package:fx_pluses/reuseable_widgets/unordered_list.dart';
import 'package:fx_pluses/screens/customer/ccreate_account.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mcreate_account.dart';

import '../../constants.dart';

class Signup extends StatefulWidget {
  static final String id='CSignup_Screen';
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool customerSelected = true;
  bool merchantSelected = false;
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
                title: "Hello!",
                description1: 'Please Select Account Type... ',
                size: size,
                onPress: () {},
                description2: '',
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    customerSelected = !customerSelected;
                    if (customerSelected == true) {
                      merchantSelected = false;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CCreateAccount(),
                      ),
                    );
                  });
                },
                child: Container(
                  height: size.height * 0.23,
                  width: size.width * 0.8,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: customerSelected
                          ? Border.all(color: newColor)
                          : Border.all(color: Colors.white),
                      color: whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/customer.png',
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Customer Account',
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      UnorderedList([
                        'Faster,cheaper global money tranfers',
                        'In publishing and graphic design, Lorem',
                        'In publishing and graphic design, Lorem',
                        'In publishing and graphic design, Lorem'
                      ])
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  merchantSelected = !merchantSelected;
                  setState(() {
                    if (merchantSelected == true) {
                      customerSelected = false;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MCreateAccount(),
                      ),
                    );
                  });
                },
                child: Container(
                  height: size.height * 0.23,
                  width: size.width * 0.8,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: merchantSelected
                          ? Border.all(color: newColor)
                          : Border.all(color: Colors.white),
                      color: whiteColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/merchant.png',
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Merchant Account',
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      UnorderedList([
                        'Faster,cheaper global money tranfers',
                        'In publishing and graphic design, Lorem',
                        'In publishing and graphic design, Lorem',
                        'In publishing and graphic design, Lorem'
                      ])
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              MainButton(text: 'Log in', onPress: () {})
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/onboarding_content.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/login_signup/create_account/create_account.dart';
import 'package:fx_pluses/screens/login_signup/create_account/signup.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.7,
              child: PageView.builder(
                  itemCount: contents.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/back.png',
                              width: size.width * 0.7,
                              height: size.height * 0.5,
                            ),
                            Positioned(
                                left: size.width * 0.0,
                                top: size.height * 0.09,
                                child: Image.asset(
                                  contents[i].image!,
                                  fit: BoxFit.contain,
                                  width: size.width * 0.7,
                                  height: size.height * 0.33,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.002,
                        ),
                        Text(
                          contents[i].title!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.002,
                        ),
                        Text(
                          contents[i].description!,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }),
            ),
            Column(
              children: [
                buildDot(currentIndex),
                SizedBox(
                  height: size.height * 0.06,
                ),
                MainButton(
                    text: 'Get Started',
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup(),
                        ),
                      );
                    }),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Aleady have an account  ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                                color: Color(0xFF8F38FF),
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('login clicked');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              })
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            contents.length,
            (index) => Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == index
                          ? Color(0xFF8F38FF)
                          : greyColor),
                )),
      ),
    );
  }
}

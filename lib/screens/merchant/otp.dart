import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/otp.png',
                  height: size.height * 0.35,
                  width: size.width * 0.8,
                ),
                const Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  'We have sent you access code via SMS \n for Mobile Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: greyColor
                  ),
                ),

                SizedBox(height: size.height * 0.03,),

                Center(
                  child: OtpTextField(
                    numberOfFields: 5,
                    borderColor: Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    margin: EdgeInsets.only(bottom: 40,left: 10),
                    borderRadius: BorderRadius.circular(10),

                    fieldWidth: size.width * 0.14,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content: Text('Code entered is $verificationCode'),
                            );
                          }
                      );
                    }, // end onSubmit
                  ),
                ),

                MainButton(text: 'Verify', onPress: (){}),

                SizedBox(height: size.height * 0.07,),
                Text('Don\'t Recieve the OTP?',style: TextStyle(
                  color: Colors.black,
                  fontSize: 13
                ),),
                InkWell(
                  onTap: (){
                    print('Resend Code clicked');
                  },
                  child: Text('Resend Code',style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

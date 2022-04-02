import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:provider/provider.dart';

class OTP extends StatefulWidget {
  static final String id='OTP_Screen';
  String verificationIdRecieved;
  int from;
  OTP({required this.verificationIdRecieved,required this.from});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  String smsCode='';

  verifyOtpCode() async{
    if(widget.verificationIdRecieved==''){
      print('verification id is null');
    }else{
      try{
        PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: widget.verificationIdRecieved, smsCode: smsCode);
        print('credentials are ${credential.smsCode}');

        if(widget.from==0) {
          await FirebaseAuth.instance.signInWithCredential(credential).then((
              value) async {
            await Provider.of<ApiDataProvider>(context, listen: false)
                .registerRequest(
                context,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .firstName,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .lastName,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .email,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .password,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .contact,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .countryCode,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .userId,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .roleId,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .deviceToken,
                Provider
                    .of<ApiDataProvider>(context, listen: false)
                    .countryName
            );
          });
        }else{
          await Provider.of<ApiDataProvider>(context,listen: false).updateProfile(context,
              Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
              '', '', Provider.of<ApiDataProvider>(context,listen: false).idFileForlocal, 'id_file',
              Provider.of<ApiDataProvider>(context, listen: false).updatedContact,
              Provider.of<ApiDataProvider>(context, listen: false).buisnessName,
              Provider.of<ApiDataProvider>(context, listen: false).countryCode,
              Provider.of<ApiDataProvider>(context, listen: false).countryName);
          Navigator.pop(context);
        }
      }catch(e){
        print('error exception is $e');
      }

    }
  }


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
                    numberOfFields: 6,
                    borderColor: Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    margin: EdgeInsets.only(bottom: 40,left: 10),
                    borderRadius: BorderRadius.circular(10),
                    fieldWidth: size.width * 0.1,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      smsCode=verificationCode;
                      // showDialog(
                      //     context: context,
                      //     builder: (context){
                      //       return AlertDialog(
                      //         title: Text("Verification Code"),
                      //         content: Text('Code entered is $verificationCode'),
                      //       );
                      //     }
                      // );
                    }, // end onSubmit
                  ),
                ),

                MainButton(text: 'Verify', onPress: () async{
                  if(smsCode.length < 6){
                    Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid code',redColor);
                  }else{
                    await verifyOtpCode();
                  }
                }),

                SizedBox(height: size.height * 0.07,),
                Text('Don\'t Recieve the OTP?',style: TextStyle(
                  color: Colors.black,
                  fontSize: 13
                ),),
                InkWell(
                  onTap: (){
                    print('Resend Code clicked');
                    Provider.of<ApiDataProvider>(context,listen: false).otpRequest(Provider.of<ApiDataProvider>(context,listen: false).contact, context,widget.from);
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

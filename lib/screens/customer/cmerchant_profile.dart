import 'package:flutter/material.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/creciever_info.dart';

import '../../constants.dart';

class CMerchantProfile extends StatelessWidget {
  static final String id='CMerchantProfile_Screen';
  const CMerchantProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(size: size, onPress: () {}, text: 'John Snow'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 5,top: 15),
        child: Column(
          children: [
            Container(
              height: size.height * 0.13,
              width: size.width,
             // margin: EdgeInsets.only(bottom: 1, left: 10, right: 10, top: 10),
              //padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 0.5,
                //     spreadRadius: 0.5,
                //     offset: Offset(
                //       1,
                //       0,
                //     ),
                //   ),
                // ],
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: size.height * 0.08,
                      width: size.width * 0.18,
                      //color: Colors.black,
                      child: Image.asset('assets/svgs/jon.jpg'),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                     width: size.width * 0.68,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'John Snow',
                              style: TextStyle(
                                  color: textBlackColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            RichText(
                                text: TextSpan(
                                    text: '5,000',
                                    style: TextStyle(color: buttonColor, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: 'PKR',
                                        style: TextStyle(color: buttonColor, fontSize: 12),
                                      )
                                    ]))
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'United State',
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: greyColor,),

            SizedBox(height: 56,),
            MainButton(text: 'Add Payment', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CRecieverInfo()));
            })

          ],
        ),
      ),
    );
  }
}

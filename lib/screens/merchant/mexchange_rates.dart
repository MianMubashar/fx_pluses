import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';

class MExchangeRates extends StatefulWidget {
  const MExchangeRates({Key? key}) : super(key: key);

  @override
  _MExchangeRatesState createState() => _MExchangeRatesState();
}

class _MExchangeRatesState extends State<MExchangeRates> {
  
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){
            Navigator.pop(context);
          },text: 'Exchange Rates',check: true,)),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text('Please Add Exchange Rate for Naira'),
            Container(
              height: size.height * 0.2,
              color: Colors.black12.withOpacity(0.06),
              margin: EdgeInsets.only(top: 10,bottom: 30),

              child: Center(
                child: Row(
                  children: [
                    Container(

                      margin: EdgeInsets.only(left: 30),
                      height: size.height * 0.06,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(

                        color: buttonColor,
                        borderRadius: BorderRadius.circular(5
                        )
                      ),
                      child: Center(
                        child: Text('\$ 1 Dollar',style: TextStyle(
                          color: textWhiteColor
                        ),),
                      ),
                    ),
                    Text(' =',style: TextStyle(
                      fontSize: 35
                    ),),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15
                      ),
                      padding: EdgeInsets.only(left:9,right: 9),
                      decoration:BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      height: size.height * 0.06,
                      width: size.width * 0.4,
                      child: Row(
                        children: [
                          Flexible(child: TextField(

                            decoration: InputDecoration(
                              hintText: '-------',
                              isDense: true,
                              border: InputBorder.none
                            ),
                          )), Text('\$ Naire')
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            Text('Please Add Exchange Rate for Dollar'),
            Container(
              height: size.height * 0.2,
              color: Colors.black12.withOpacity(0.06),
              margin: EdgeInsets.only(top: 10),

              child: Center(
                child: Row(
                  children: [
                    Container(

                      margin: EdgeInsets.only(left: 30),
                      height: size.height * 0.06,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(

                          color: buttonColor,
                          borderRadius: BorderRadius.circular(5
                          )
                      ),
                      child: Center(
                        child: Text('\$ 1 Dollar',style: TextStyle(
                            color: textWhiteColor
                        ),),
                      ),
                    ),
                    Text(' =',style: TextStyle(
                        fontSize: 35
                    ),),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15
                      ),
                      padding: EdgeInsets.only(left:9,right: 9),
                      decoration:BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      height: size.height * 0.06,
                      width: size.width * 0.4,
                      child: Row(
                        children: [
                          Flexible(child: TextField(

                            decoration: InputDecoration(
                                hintText: '-------',
                                isDense: true,
                                border: InputBorder.none
                            ),
                          )), Text('\$ Naire')
                        ],
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

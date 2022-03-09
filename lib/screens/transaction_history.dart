import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatelessWidget {
  static final String id='TransactionHistory_Screen';
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: 'Transactions History',
            check: true,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15,),
        child: ListView.builder(
            itemCount: Provider.of<ApiDataProvider>(context,listen: false).customerTransactionHistoryList.length,
            itemBuilder: (context,index){
          return Container(
            height: size.height * 0.25,
            width: size.width,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0,
                    1,
                  ),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.18,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thu, 25 jun,2020',
                            style: TextStyle(
                                color: textBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: Provider.of<ApiDataProvider>(context,listen: false).customerTransactionHistoryList[index].amount,
                                  style: TextStyle(color: buttonColor, fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: 'USD',
                                      style: TextStyle(color: buttonColor, fontSize: 12),
                                    )
                                  ]))
                        ],
                      ),
                      Text(
                        'Slip # ' +Provider.of<ApiDataProvider>(context,listen: false).customerTransactionHistoryList[index].slip_no,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: textBlackColor, fontSize: 18),
                      ),
                      // Flexible(
                          // child: Text(
                          //   'In publishing and graphic design, Lorem ipsum is a '
                          //       'placeholder text commonly used to demonstrate the'
                          //       ' visual form of a document or a typeface without '
                          //       'relying on meaningful content.',maxLines: 5,style: TextStyle(
                          //     color: greyColor
                          // ),))
                    ],
                  ),
                ),
                Container(
                  width: size.width ,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      color: profileColor.withOpacity(0.08),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                  ),
                  child: Center(
                    child: Text(
                      Provider.of<ApiDataProvider>(context,listen: false).customerTransactionHistoryList[index].transaction_status['title'],style: TextStyle(
                        color: buttonColor
                    ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

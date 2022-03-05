import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CTransferDialog extends StatelessWidget {
  var size;
  int index;
  CTransferDialog({required this.size,required this.index});

  TextEditingController amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.0,
      width: 320.0,
      padding: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 40),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/transfer_dialog_image.png',height: size.height * 0.12,width: size.width * 0.2,),
              Text('Transfer to Wallet',style: TextStyle(
                  color: textBlackColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600
              )),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Amount',
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25, top: 5),
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                      hintText: '400',

                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onChanged: (value) {
                    //email=value;
                  },
                ),
              ),
              InkWell(
                onTap: () async{
                  await Provider.of<ApiDataProvider>(context,listen: false).updateWallet(context,
                      Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                      3, amountController.text,
                      Provider.of<ApiDataProvider>(context,listen: false).acceptedRequestMerchantsList[index].from_user['id'],
                      '', '');
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: gradient,
                    ),
                    child: Center(child: Text('Send',style: TextStyle(
                        color: Colors.white
                    ),)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

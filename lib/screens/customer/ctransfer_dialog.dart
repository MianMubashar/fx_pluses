import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CTransferDialog extends StatefulWidget {
  var size;
  int index;
  int currency_id;

  CTransferDialog({required this.size,required this.index,required this.currency_id});

  @override
  State<CTransferDialog> createState() => _CTransferDialogState();
}

class _CTransferDialogState extends State<CTransferDialog> {
  double charges=0;
  double? balance=0;

  TextEditingController amountController=TextEditingController();

  TextEditingController serviceFeeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width ,
      padding: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 40),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/transfer_dialog_image.png',height: widget.size.height * 0.12,width: widget.size.width * 0.2,),
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
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                    controller: amountController,
                    decoration: InputDecoration(
                        hintText: 'amount',
                        prefixIcon: Padding(
                          padding:  EdgeInsets.only(left: 20.0,top: 15),
                          child: Text(Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol,),
                        ),
                        helperStyle: TextStyle(color: blackColor),
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onChanged: (value) {
                      print(amountController.text);
                      if(amountController.text.isNotEmpty){
                        balance=0;
                        charges=0;
                      Provider.of<ApiDataProvider>(context, listen: false).serviceFeeModelList.forEach((element) {
                        if(double.parse(value) >= double.parse(element.min.toString()) && double.parse(value) <= double.parse(element.max.toString())){
                          charges=double.parse(element.charges!.toString());
                        }
                      });
                      if(Provider.of<ApiDataProvider>(context,listen: false).roleId == 5) {
                        balance = double.parse(amountController.text) +
                            charges;
                      }
                      if(Provider.of<ApiDataProvider>(context,listen: false).roleId == 4) {
                        balance = double.parse(amountController.text);
                      }
                      setState(() {

                      });
                      }else{
                        if(amountController.text.isEmpty){
                          balance=0;
                          charges=0;
                          setState(() {

                          });
                        }
                      }
                      // email=value;
                    },
                  ),
                ),
                Provider.of<ApiDataProvider>(context,listen: false).roleId == 5 ?
                Text(
                  'Service Fee',
                  style: TextStyle(
                    color: greyColor,
                  ),
                ) : SizedBox(),
                Provider.of<ApiDataProvider>(context,listen: false).roleId == 5 ?
                Container(
                  margin: EdgeInsets.only(bottom: 25, top: 5),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width ,
                  padding: EdgeInsets.only(left: 20,top: 18),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Text(Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol + '       ' + charges.toString()) ,
                ) : SizedBox(),
                Provider.of<ApiDataProvider>(context,listen: false).roleId == 5 ?
                Text(
                  'Total',
                  style: TextStyle(
                    color: greyColor,
                  ),
                ) : SizedBox(),
                Provider.of<ApiDataProvider>(context,listen: false).roleId == 5 ?
                Container(
                  margin: EdgeInsets.only(bottom: 25, top: 5),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width ,
                  padding: EdgeInsets.only(left: 20,top: 18),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Text(Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol + '       ' + balance.toString()) ,
                ) : SizedBox(),
                InkWell(
                  onTap: () async{
                    if(amountController.text.isEmpty){
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter amount',redColor);
                    }else {
                      // if (amountController.text.contains('.')) {
                      //   Provider.of<ApiDataProvider>(context, listen: false)
                      //       .showSnackbar(
                      //       context, 'Please enter valid amount', redColor);
                      // } else {

                        // balance = int.parse(amountController.text) + int.parse(charges.toString());
                        //List a = Provider.of<ApiDataProvider>(context, listen: false).balance.split('.');
                        double b = double.parse(Provider.of<ApiDataProvider>(context, listen: false).balance);
                        double balance2 = b;
                        if(balance2 >= balance!) {
                          Navigator.pop(context);
                          await Provider.of<ApiDataProvider>(
                              context, listen: false)
                              .updateWallet(
                              context,
                              Provider
                                  .of<ApiDataProvider>(context, listen: false)
                                  .bearerToken,
                              3,
                              balance.toString(),
                              Provider
                                  .of<ApiDataProvider>(context, listen: false)
                                  .acceptedRequestMerchantsList[widget.index]
                                  .from_user['id'],
                              '',
                              '',
                              widget.currency_id,
                          null,
                              Provider.of<ApiDataProvider>(context, listen: false).roleId == 5 ?charges.toString(): '0');
                        }else{
                          Provider.of<ApiDataProvider>(context, listen: false).showSnackbar(
                              context, 'Your wallet balance is insufficient', redColor);
                        }
                      // }
                    }


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
      ),
    );
  }
}

import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'ctransfer_dialog.dart';

class CWalletToWalletTransfer extends StatefulWidget {
  static final String id='CWalletToWalletTransfer_Screen';

  @override
  State<CWalletToWalletTransfer> createState() => _CWalletToWalletTransferState();
}

class _CWalletToWalletTransferState extends State<CWalletToWalletTransfer> {
  TextEditingController searcchFieldController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){
            Navigator.pop(context);
          },text: 'Merchants',check: true,)),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.09,
              child: TextField(
                controller: searcchFieldController,
                decoration: InputDecoration(
                  hintText: 'Search Merchants',
                  isDense: true,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 10),
                    child: Image.asset('assets/icons/searchicon.png',width: size.width * 0.01,height: size.height * 0.01,),
                  ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
          ),
              ),
                onChanged: (value){

                },
            ),
            ),

            Text(
              'Select Merchant',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: textBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: Provider.of<ApiDataProvider>(context,listen: false).acceptedRequestMerchantsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: size.height * 0.13,
                      width: size.width,
                      margin: EdgeInsets.only(
                          bottom: 1, left: 10, right: 10, top: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            offset: Offset(
                              1,
                              0,
                            ),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage((Provider.of<ApiDataProvider>(context,listen: false)
                                    .acceptedRequestMerchantsList[index].from_user['profile_photo_path'].toString().contains('https') ||
                                    Provider.of<ApiDataProvider>(context,listen: false)
                                        .acceptedRequestMerchantsList[index].from_user['profile_photo_path'].toString().contains('http'))?
                                Provider.of<ApiDataProvider>(context,listen: false)
                                    .acceptedRequestMerchantsList[index].from_user['profile_photo_path']:
                                profile_url + Provider.of<ApiDataProvider>(context,listen: false)
                                    .acceptedRequestMerchantsList[index].from_user['profile_photo_path']),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:size.width * 0.18,
                                          child: Text(
                                            Provider.of<ApiDataProvider>(context,listen: false).acceptedRequestMerchantsList[index].from_user['first_name']+" "+Provider.of<ApiDataProvider>(context,listen: false).acceptedRequestMerchantsList[index].from_user['last_name'],
                                              maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(
                                                color: textBlackColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.asset(
                                          'icons/flags/png/${Provider.of<ApiDataProvider>(context, listen: false).acceptedRequestMerchantsList[index].from_user['country_code'].toLowerCase()}.png',
                                          package: 'country_icons',
                                          height: 20,
                                          width: 20,
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${CountryPickerUtils.getCountryByIsoCode(Provider.of<ApiDataProvider>(context,listen: false).acceptedRequestMerchantsList[index].from_user['country_code']).name}',
                                      style: TextStyle(
                                          color: greyColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap:(){
                              setState(() {
                                showDialog(context: context, builder: (BuildContext context)=>Dialog(

                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
                                  child: CTransferDialog(size:size,index:index,
                                    currency_id: Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencyId,),
                                ));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: size.height * 0.05,
                              width: size.width * 0.26,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Transfer',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],

        ),
      ),
    );
  }
}

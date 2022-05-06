import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/get_countries_for_merchants.dart';
import 'package:fx_pluses/model/get_currencies_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:provider/provider.dart';

class MExchangeRates extends StatefulWidget {
  const MExchangeRates({Key? key}) : super(key: key);

  @override
  _MExchangeRatesState createState() => _MExchangeRatesState();
}

class _MExchangeRatesState extends State<MExchangeRates> {
  String toCurrencyIcon = '';
  int? fromCountryId;
  int? toCountryId;
  TextEditingController amount=TextEditingController();
 // TextEditingController exchangeRate=TextEditingController();
  String updatedRate='';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              MainButton(text: 'Create Exchange Rate', onPress: (){
                showDialog(context: context, builder:(context){
                  return Dialog(
                    child: Container(
                      height: size.height * 0.45,
                      width:  size.width * 0.6,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(

                            decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            margin: EdgeInsets.only( top: 20,left: 10,right: 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                // enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              iconSize: 30,
                              isExpanded: true,
                              items: Provider.of<ApiDataProvider>(context, listen: false)
                                  .getCurrenciesList
                                  .map((e) => DropdownMenuItem<GetCurrenciesModel>(
                                  value: e, child: Text("   "+e.name + " "+e.symbol)))
                                  .toList(),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hint: Text('From currency'),
                              onChanged: (GetCurrenciesModel? value) {
                                fromCountryId=value!.id;
                                print('fromcountryId is $fromCountryId');
                              },
                              onSaved: (value) {
                                print('bbbbbbbbbbbbbbbbbbbbbbb ${value}');
                                //selectedValue = value.toString();
                              },
                            ),
                          ),
                          Container(

                            decoration: BoxDecoration(
                                color: Colors.black12.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            margin: EdgeInsets.only(bottom: 20, top: 20,left: 10,right: 10),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                // enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              iconSize: 30,
                              isExpanded: true,
                              items: Provider.of<ApiDataProvider>(context, listen: false)
                                  .getCurrenciesList
                                  .map((e) => DropdownMenuItem<GetCurrenciesModel>(
                                  value: e, child: Text("   "+e.name + " "+e.symbol)))
                                  .toList(),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hint: Text('To currency'),
                              onChanged: (GetCurrenciesModel? value) {
                                toCountryId=value!.id;
                                Provider.of<ApiDataProvider>(context, listen: false).setcurrencySymbolForExchangeRateScreen(value.symbol);
                                print('tocountryId is $toCountryId');

                              },
                              onSaved: (value) {
                                print('bbbbbbbbbbbbbbbbbbbbbbb ${value}');
                                //selectedValue = value.toString();
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 25,left: 10,right: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              controller: amount,
                              decoration: Provider.of<ApiDataProvider>(context, listen: true).currencySymbolForExchangeRateScreen=='' ?
                  InputDecoration(
                  hintText: 'amount',
                  helperStyle: TextStyle(color: blackColor),
                  isDense: true,
                  filled: true,
                  border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                  ))
                                  :InputDecoration(
                                  prefixIcon: Padding(
                                    padding:  EdgeInsets.only(left: 20.0,top: 15),
                                    child: Provider.of<ApiDataProvider>(context, listen: true).currencySymbolForExchangeRateScreen==''
                                        ?Text('0')
                                        :Text(Provider.of<ApiDataProvider>(context, listen: true).currencySymbolForExchangeRateScreen),
                                  ),
                                  hintText: 'amount',
                                  helperStyle: TextStyle(color: blackColor),
                                  isDense: true,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              onChanged: (value) {

                              },
                            ),
                          ),

                  InkWell(
                  onTap: () async{
                    if(fromCountryId != null){
                      if(toCountryId != null){
                        if(amount.text.isNotEmpty){
                          Navigator.pop(context);
                          await Provider.of<ApiDataProvider>(context,listen: false).CreateRate(context,
                              Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                              fromCountryId!, toCountryId!,
                              amount.text);
                          setState(() {

                          });
                        }else{
                          Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter amount', redColor);
                        }
                      }else{
                        Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please select currency', redColor);
                      }
                    }else{
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please select  currency', redColor);
                    }

                  },
                  child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,

                  margin: EdgeInsets.only(left: 20,right: 20),
                  //padding:EdgeInsets.only(left:10,right:10),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: gradient,
                  ),
                  child: Center(child: Text('Add',style: TextStyle(
                  color: Colors.white
                  ),)),
                  ),
                  )
                        ],
                      ),
                    ),
                  );
                });
              }),
              Container(
                height: size.height * 0.71,
                child: ListView.builder(
                    itemCount: Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList.length,
                    itemBuilder: (context,index){
                  return Container(
                    height: size.height * 0.2,
                    color: Colors.black12.withOpacity(0.06),
                    margin: EdgeInsets.only(top: 10,bottom: 30),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: () async{
                             await Provider.of<ApiDataProvider>(context,listen: false).DeleteRate(context,
                                  Provider.of<ApiDataProvider>(context,listen: false).bearerToken  ,
                                  Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].id,
                             index);
                             setState(() {

                             });
                            }, icon: Icon(Icons.delete,color: buttonColor,)),
                            IconButton(onPressed: () async{
                              if(updatedRate != ''){
                                await Provider.of<ApiDataProvider>(context,listen: false).UpdateRate(context,
                                    Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                                    Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].from_currency_id,
                                    Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].to_currency_id,
                                    updatedRate,
                                    Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].id);
                              }else{
                                Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter rate to update', redColor);
                              }

                            }, icon: Icon(Icons.check,color: buttonColor,)),
                          ],
                        ),
                        Center(
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
                                  child: Text('${Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].from_currency['symbol']}'+
                                      ' 1 ${Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].from_currency['name']}',style: TextStyle(
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
                                      keyboardType: TextInputType.number,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      decoration: InputDecoration(
                                          hintText: Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].exchange_rate,
                                          isDense: true,
                                          border: InputBorder.none
                                      ),
                                      onChanged: (value){
                                  updatedRate=value;
                                      },
                                    )),
                                    Text('${Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].to_currency['symbol']}'+
                                        ' ${Provider.of<ApiDataProvider>(context,listen: false).getCurrencyRateModelList[index].to_currency['name']}')
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              // Text('Please Add Exchange Rate for Dollar'),
              // Container(
              //   height: size.height * 0.2,
              //   color: Colors.black12.withOpacity(0.06),
              //   margin: EdgeInsets.only(top: 10),
              //
              //   child: Center(
              //     child: Row(
              //       children: [
              //         Container(
              //
              //           margin: EdgeInsets.only(left: 30),
              //           height: size.height * 0.06,
              //           width: size.width * 0.25,
              //           decoration: BoxDecoration(
              //
              //               color: buttonColor,
              //               borderRadius: BorderRadius.circular(5
              //               )
              //           ),
              //           child: Center(
              //             child: Text('\$ 1 Dollar',style: TextStyle(
              //                 color: textWhiteColor
              //             ),),
              //           ),
              //         ),
              //         Text(' =',style: TextStyle(
              //             fontSize: 35
              //         ),),
              //         Container(
              //           margin: EdgeInsets.only(
              //               left: 15
              //           ),
              //           padding: EdgeInsets.only(left:9,right: 9),
              //           decoration:BoxDecoration(
              //               color: whiteColor,
              //               borderRadius: BorderRadius.circular(5)
              //           ),
              //           height: size.height * 0.06,
              //           width: size.width * 0.4,
              //           child: Row(
              //             children: [
              //               Flexible(child: TextField(
              //
              //                 decoration: InputDecoration(
              //                     hintText: '-------',
              //                     isDense: true,
              //                     border: InputBorder.none
              //                 ),
              //               )), Text('\$ Naire')
              //             ],
              //           ),
              //         )
              //
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

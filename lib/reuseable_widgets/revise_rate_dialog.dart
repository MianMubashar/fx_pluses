import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/get_currencies_model.dart';
import '../providers/api_data_provider.dart';

class ReviseRateDialog extends StatelessWidget {
   ReviseRateDialog({Key? key,required this.reciever_id,required this.transaction_id}) : super(key: key);
   int reciever_id;
   int? transaction_id;

   String fromCountry='';
   String toCountry='';
   String rate='';

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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
                  fromCountry=value!.name;
                  // fromCountryId=value!.id;
                  // print('fromcountryId is $fromCountryId');
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
                  toCountry=value!.name;
                  // toCountryId=value!.id;
                  // Provider.of<ApiDataProvider>(context, listen: false).setcurrencySymbolForExchangeRateScreen(value.symbol);
                  // print('tocountryId is $toCountryId');

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
                // controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:  EdgeInsets.only(left: 20.0,top: 15),
                      child: Provider.of<ApiDataProvider>(context, listen: true).currencySymbolForExchangeRateScreen==''
                          ?Text(Provider.of<ApiDataProvider>(context,listen: false).selectedCurrencySymbol,)
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
                  rate=value;
                },
              ),
            ),
            InkWell(
              onTap:(){
                if(fromCountry !=''){
                  if(toCountry !=''){
                    if(rate !='' && !rate.contains('.')){

                      Navigator.pop(context);
                      Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                          Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                          reciever_id,
                          fromCountry+' to '+ toCountry +'\n'+'Rate: '+rate,

                          '','',transaction_id );
                    }else{
                      Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid amount',redColor);
                    }
                  }else{
                    Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please select to currency',redColor);
                  }
                }else{
                  Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please select from currency',redColor);
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
                child: Center(child: Text('Send',style: TextStyle(
                    color: Colors.white
                ),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

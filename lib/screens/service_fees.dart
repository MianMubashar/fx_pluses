import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../reuseable_widgets/appbar.dart';

class ServiceFees extends StatelessWidget {
  const ServiceFees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              // centerTitle: true,
               backgroundColor: Colors.white.withOpacity(0),
              elevation: 0,
              // title: Text(
              //   'Service Fee',
              //   style: TextStyle(
              //       color: whiteColor, fontSize: 23, fontWeight: FontWeight.w600),
              // ),
              leading: Container(),
              actions: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,right: 20),
                    child: Text('Cancel',style: TextStyle(
                      color: textBlackColor
                    ),),
                  ),
                )
              ],


            )),
        body: Container(
          height: size.height * 0.4,
          width: size.width,
          child: ListView.builder(
              itemCount: Provider.of<ApiDataProvider>(context,listen: false).serviceFeeModelList.length,
              itemBuilder: (context, index) {
                ApiDataProvider provider=Provider.of<ApiDataProvider>(context,listen: false);
            return Container(
              height: size.height * 0.13,
              width: size.width * 0.6,
              margin: EdgeInsets.only(bottom: 20,left: 15,right: 15),
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: buttonColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text(provider.serviceFeeModelList[index].currency?['name'])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('min: ${provider.serviceFeeModelList[index].currency?['symbol']}${provider.serviceFeeModelList[index].min}',),
                      ),
                      Text('----->',style: TextStyle(
                        color: whiteColor
                      ),),
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('max: ${provider.serviceFeeModelList[index].currency?['symbol']}${provider.serviceFeeModelList[index].max}'),
                      ),
                      Text(' = ',style: TextStyle(
                          color: whiteColor
                      ),),
                      Container(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('${provider.serviceFeeModelList[index].currency?['symbol']}${provider.serviceFeeModelList[index].charges}'),
                      ),
                    ],
                  ),
                  // Text('Charges: ${provider.serviceFeeModelList[index].currency?['symbol']}${provider.serviceFeeModelList[index].charges}',style: TextStyle(
                  //     color: textWhiteColor
                  // ),)
                ],
              ),
            );
          })),
        ),
    );
  }
}

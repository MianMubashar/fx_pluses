import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
class MTransactionRequests extends StatefulWidget {
  static final String id='MTransactionRequests_Screen';
  const MTransactionRequests({Key? key}) : super(key: key);

  @override
  State<MTransactionRequests> createState() => _MTransactionRequestsState();
}

class _MTransactionRequestsState extends State<MTransactionRequests> {

  getData() async{
    await Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequests(context,
        Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){},text: 'Transaction Requests',check: false,)),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
      child: Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.length==0?
          Center(
            child:Text('No request recieved')
          )
          :ListView.builder(
          itemCount: Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.length,
          itemBuilder: (context, index) {
            return transactionRequestWidget(size: size,index: index,);
          }),
      ),
    );
  }
}

class transactionRequestWidget extends StatefulWidget {
   transactionRequestWidget({
    Key? key,
    required this.size,
    required this.index
  }) : super(key: key);

  final Size size;
  int index;

  @override
  State<transactionRequestWidget> createState() => _transactionRequestWidgetState();
}

class _transactionRequestWidgetState extends State<transactionRequestWidget> {
  bool isAccepted=false;

  bool isDeclined=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDeclined=false;
    isAccepted=false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.13,
      width: widget.size.width,
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
                backgroundColor: Colors.black12,

                backgroundImage: Provider.of<ApiDataProvider>(context,listen: false).
                merchantTransactionRequestsList[widget.index]==null?
                NetworkImage('https://img.freepik.com/free-vector/modern-dark-texture-background_1035-11632.jpg?t=st=1647339303~exp=1647339903~hmac=2d2fa81f16ba6f4b37e6fc9953915a1ac7ab6512f7a4cd718beb408efa4c3793&w=1380'):
                NetworkImage((
                    Provider.of<ApiDataProvider>(context,listen: false).
                    merchantTransactionRequestsList[widget.index].from_user['profile_photo_path'].contains('http') ||

                        Provider.of<ApiDataProvider>(context,listen: false).
                        merchantTransactionRequestsList[widget.index].from_user['profile_photo_path'].contains('https'))?

                Provider.of<ApiDataProvider>(context,listen: false).
                merchantTransactionRequestsList[widget.index].from_user['profile_photo_path'] :

                profile_url + Provider.of<ApiDataProvider>(context,listen: false).
                merchantTransactionRequestsList[widget.index].from_user['profile_photo_path']
                ),
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
                        Padding(
                          padding:EdgeInsets.only(right: 5),
                          child: SizedBox(
                            width: widget.size.width * 0.18,
                            child: Text(
                              Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList[widget.index].from_user['first_name']+" " +Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList[widget.index].from_user['last_name'],maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: textBlackColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Image.asset(
                          'icons/flags/png/${Provider.of<ApiDataProvider>(context, listen: false).merchantTransactionRequestsList[widget.index].from_user['country_code'].toLowerCase()}.png',
                          package: 'country_icons',
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "${CountryPickerUtils.getCountryByIsoCode(Provider.of<ApiDataProvider>(context, listen: false).merchantTransactionRequestsList[widget.index].from_user['country_code']).name.toString()}",
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),

          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$${Provider.of<ApiDataProvider>(context, listen: false).merchantTransactionRequestsList[widget.index].amount}',
                      style: TextStyle(
                          color: textBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                       isDeclined ==true ?   Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                         margin: EdgeInsets.only(top: 5),
                            height: widget.size.height * 0.034,
                            width: widget.size.width * 0.28,
                            decoration: BoxDecoration(
                                color: buttonColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/icons/acceptedicon.png',
                                    height: widget.size.height * 0.02,
                                  ),
                                  Text(
                                    'Declined',
                                    style: TextStyle(
                                        color: buttonColor, fontSize: 12),
                                  )
                                ]),
                          ):
                    InkWell(
                      onTap: () async{
                        isDeclined=true;
                        isAccepted=false;
                        await Provider.of<ApiDataProvider>(context,listen: false).accepteOrNotStatusRequest(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                            'declined',Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList[widget.index].id,widget.index );
                        setState(() {

                        });
                        //Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.removeAt(widget.index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right:5),
                        margin: EdgeInsets.only(top: 5,right: 5),
                        height: isAccepted==true?0:widget.size.height * 0.034,
                        width: isAccepted==true?0:widget.size.width * 0.14,
                        decoration: BoxDecoration(
                            color: buttonColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Decline',
                            style: TextStyle(
                                color: buttonColor, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                    isAccepted==true ? Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      margin: EdgeInsets.only(top: 5),
                      height: widget.size.height * 0.034,
                      width: widget.size.width * 0.28,
                      decoration: BoxDecoration(
                          color: buttonColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/icons/acceptedicon.png',
                              height: widget.size.height * 0.02,
                            ),
                            Text(
                              'Accepted',
                              style: TextStyle(
                                  color: buttonColor, fontSize: 12),
                            )
                          ]),
                    ):
                    InkWell(
                      onTap: ()async{
                        isAccepted=true;
                        isDeclined=false;
                        await Provider.of<ApiDataProvider>(context,listen: false).accepteOrNotStatusRequest(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                            'accepted',Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList[widget.index].id ,widget.index);
                        setState(() {

                        });
                        //Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.removeAt(widget.index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right:5),
                        margin: EdgeInsets.only(top: 5),
                        height: isDeclined == true ? 0 : widget.size.height * 0.034,
                        width: isDeclined == true ? 0 :widget.size.width * 0.14,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 10,bottom: 10),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //    mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text('\$100',style: TextStyle(
          //         color: greyColor
          //       ),),
          //       Container(
          //         padding: EdgeInsets.only(left: 10, right: 10),
          //         height: size.height * 0.04,
          //         width: size.width * 0.26,
          //         decoration: BoxDecoration(
          //             color: buttonColor,
          //             borderRadius: BorderRadius.circular(10)),
          //         child: Row(
          //             mainAxisAlignment:
          //             MainAxisAlignment.spaceBetween,
          //             children: [
          //               Image.asset(
          //                 'assets/images/messageicon.png',
          //                 height: size.height * 0.02,
          //               ),
          //               Text(
          //                 'Chat Now',
          //                 style: TextStyle(
          //                     color: Colors.white, fontSize: 12),
          //               )
          //             ]),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

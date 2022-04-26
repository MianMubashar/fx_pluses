import 'package:flutter/material.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/api_data_provider.dart';
class ListOfUsersHavingChat extends StatefulWidget {
  ListOfUsersHavingChat({Key? key,required this.firstName,required this.lastName,
    required this.message,required this.recieverId,required this.profile,
    required this.transaction_id,required this.transaction,required this.unread_msg,
    required this.buisness,required this.transaction_status_id,required this.isOnline}) : super(key: key);
  final String firstName;
  final String lastName;
   String? message;
  final int recieverId;
  String? profile; 
  int? transaction_id;
  Map<dynamic,dynamic>? transaction;
  int? unread_msg;
  String? buisness;
  int? transaction_status_id;
  int? isOnline;

  @override
  State<ListOfUsersHavingChat> createState() => _ListOfUsersHavingChatState();
}

class _ListOfUsersHavingChatState extends State<ListOfUsersHavingChat> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    setState(() {

    });

    return InkWell(
      onTap: () async{
        await Provider.of<ApiDataProvider>(context, listen: false)
            .setScreenIndex(6);
        await Provider.of<ApiDataProvider>(context, listen: false).showChatFirst(context,
            Provider.of<ApiDataProvider>(context, listen: false).bearerToken,
            widget.recieverId, widget.transaction_id);
        pushNewScreen(Get.context!,
            screen: ChatScreen(buisnessName: widget.buisness,reciever_id: widget.recieverId,name: widget.firstName+" "+widget.lastName,transactionId: widget.transaction_id,rateOffer: null,transaction: widget.transaction,),
            withNavBar: false,
            pageTransitionAnimation:
            PageTransitionAnimation.cupertino);

      },
      child: Container(
        height: size.height * 0.13,
        width: size.width,
        margin: EdgeInsets.only(
            bottom: 1, right: 10, top: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.profile==null ?
                      NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuSMA98U5nhBmtcdj2hmFD4ijUIue_fCxNWw&usqp=CAU')
                          :NetworkImage((widget.profile!.contains('http') || widget.profile!.contains('https'))? widget.profile!:
                      profile_url+widget.profile!,),
                    ),
                    // Container(
                    //   height: size.height * 0.1,
                    //   width: size.width * 0.22,
                    //   // color:Colors.blue,
                    //   child: Center(
                    //     child: Stack(
                    //       children: [
                    //         ClipRRect(
                    //           borderRadius:
                    //           BorderRadius.circular(15.0),
                    //           child: Container(
                    //             height: size.height * 0.08,
                    //             width: size.width * 0.18,
                    //             color: Colors.black,
                    //             child: Image.network((profile!.contains('http') || profile!.contains('https'))?profile!:
                    //             profile_url+profile!,fit: BoxFit.fill,),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                     Positioned(
                      //bottom: 10,
                      top: 2,
                      left: 40,
                      child: Container(
                        height: size.height * 0.022,
                        width:  size.width * 0.05,
                        decoration: widget.isOnline == 1 ?
                        BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green
                        )
                            :BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:size.width * 0.45,
                                child: Text(
                                  widget.firstName+" "+widget.lastName,
                                  maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(
                                    color: textBlackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                                ),
                              ),
                              widget.transaction_status_id != null && widget.transaction_status_id == 5 ?
                               Icon(Icons.star,size: size.height * 0.02,color: buttonColor,)
                                  :Container(),
                            ],
                          ),
                          widget.unread_msg != null && widget.unread_msg != 0 ?Container(
                            height: 15,
                            width: 15,
                            child: Center(child: Text('${widget.unread_msg}',style: TextStyle(
                              color: whiteColor,
                              fontSize: 10
                            ),)),

                            decoration: BoxDecoration(
                              color: buttonColor,
                              shape: BoxShape.circle
                            ),
                          ):SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Text(
                          widget.message==null ?'': widget.message!,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
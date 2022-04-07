import 'package:flutter/material.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/api_data_provider.dart';
class ListOfUsersHavingChat extends StatelessWidget {
  ListOfUsersHavingChat({Key? key,required this.firstName,required this.lastName,required this.message,required this.recieverId,required this.profile,required this.transaction_id}) : super(key: key);
  final String firstName;
  final String lastName;
   String? message;
  final int recieverId;
  String? profile; 
  int? transaction_id;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return InkWell(
      onTap: () async{
        pushNewScreen(context,
            screen: ChatScreen(reciever_id: recieverId,name: firstName+" "+lastName,transactionId: transaction_id,rateOffer: null,),
            withNavBar: false,
            pageTransitionAnimation:
            PageTransitionAnimation.cupertino);
        await Provider.of<ApiDataProvider>(context, listen: false)
            .setScreenIndex(6);
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
                      backgroundImage: profile==null ?
                      NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuSMA98U5nhBmtcdj2hmFD4ijUIue_fCxNWw&usqp=CAU')
                          :NetworkImage((profile!.contains('http') || profile!.contains('https'))? profile!:
                      profile_url+profile!,),
                    )
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
                    // Positioned(
                    //   //bottom: 10,
                    //   top: 2,
                    //   left: 55,
                    //   child: Image.asset(
                    //     'assets/icons/statusicon.png',
                    //     height: 20,
                    //     width: 20,
                    //   ),
                    // )
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
                        children: [
                          SizedBox(
                            width:size.width * 0.5,
                            child: Text(
                              firstName+" "+lastName,
                              maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(
                                color: textBlackColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Text(
                          message==null ?'': message!,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
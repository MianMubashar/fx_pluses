import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fx_pluses/model/chat_menu_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/list_of_users_having_chat.dart';
import 'package:fx_pluses/screens/chat_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class CMessages extends StatefulWidget {
  static final String id = 'CMessages_Screen';
  const CMessages({Key? key}) : super(key: key);

  @override
  _CMessagesState createState() => _CMessagesState();
}

class _CMessagesState extends State<CMessages> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  TextEditingController searcchFieldController = TextEditingController();

  // getData()async{
  //   await Provider.of<ApiDataProvider>(context,listen: false).chatMenu(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {

            },
            text: 'Messages',
            check: false,
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
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
                    padding: const EdgeInsets.only(left: 15.0, right: 10),
                    child: Image.asset(
                      'assets/icons/searchicon.png',
                      width: size.width * 0.01,
                      height: size.height * 0.01,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Stream_Builder(size: size,)
          ],
        ),
      ),
    );
  }
}
class Stream_Builder extends StatelessWidget {
   Stream_Builder({Key? key,required this.size
  }) : super(key: key);
var size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<http.Response>(
          stream: Provider.of<ApiDataProvider>(context,listen: false).chatMenu(
            context,
            Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
          ),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Container(
                  height: 40,width: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  ),
                ),
              );
            }else{
              var response= snapshot.data!;
              List<ListOfUsersHavingChat> list=[];
              print('stream builder 1');
              if(response.statusCode==200){
                print('stream builder 2');
                Map<String, dynamic> apiResponse = jsonDecode(response.body);
                bool status = apiResponse['status'];
                if(status){
                  Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList.clear();
                  List<dynamic> data=apiResponse['chats'];

                  for(int i=0;i<data.length;i++) {

                    Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList.add(ChatMenuModel.fromJson(data[i]));
                    ChatMenuModel menuModel = Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i];
                    if(menuModel.receiver_id == Provider.of<ApiDataProvider>(context,listen: false).id){
                      final firstName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender['first_name'];
                      final lastName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender['last_name'];
                      final message=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].message;
                      final recieverId=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender_id;

                      final profile_url=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['profile_photo_path'];
                      final listWidget=ListOfUsersHavingChat(firstName: firstName,lastName: lastName,message: message,recieverId: recieverId,profile: profile_url,);
                      list.add(listWidget);
                    }else{
    final firstName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['first_name'];
    final lastName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['last_name'];
    final message=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].message;
    final recieverId=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver_id;
    final profile_url=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['profile_photo_path'];
    final listWidget=ListOfUsersHavingChat(firstName: firstName,lastName: lastName,message: message,recieverId: recieverId,profile: profile_url,);
    list.add(listWidget);
                    }

                  }
                }
              }else{
                List<dynamic> data=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList;
                for(int i=0;i<data.length;i++) {
                  ChatMenuModel menuModel = Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i];
                  if(menuModel.receiver_id == Provider.of<ApiDataProvider>(context,listen: false).id){
                    final firstName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender['first_name'];
                    final lastName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender['last_name'];
                    final message=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].message;
                    final recieverId=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].sender_id;
                    final profile_url=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['profile_photo_path'];
                    final listWidget=ListOfUsersHavingChat(firstName: firstName,lastName: lastName,message: message,recieverId: recieverId,profile: profile_url,);
                    list.add(listWidget);
                  }else{
                    final firstName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['first_name'];
                    final lastName=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['last_name'];
                    final message=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].message;
                    final recieverId=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver_id;
                    final profile_url=Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[i].receiver['profile_photo_path'];
                    final listWidget=ListOfUsersHavingChat(firstName: firstName,lastName: lastName,message: message,recieverId: recieverId,profile: profile_url,);
                    list.add(listWidget);
                  }

                }
              }
              print('stream builder 3');

              return ListView(
                children: list,
              );
            }
          },
        )

    );
  }
}





// class Listview_Builder extends StatelessWidget {
//   const Listview_Builder({
//     Key? key,
//     required this.size,
//   }) : super(key: key);
//
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//           itemCount: Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () async{
//                 await Provider.of<ApiDataProvider>(context,listen: false).showChat(context,
//                     Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
//                     Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[index].receiver_id);
//                 pushNewScreen(context,
//                     screen: ChatScreen(),
//                     withNavBar: false,
//                     pageTransitionAnimation:
//                         PageTransitionAnimation.cupertino);
//               },
//               child: Container(
//                 height: size.height * 0.13,
//                 width: size.width,
//                 margin: EdgeInsets.only(
//                     bottom: 1, left: 10, right: 10, top: 10),
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 decoration: BoxDecoration(
//                   //color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   // boxShadow: [
//                   //   BoxShadow(
//                   //     color: Colors.black12,
//                   //     blurRadius: 0.5,
//                   //     spreadRadius: 0.5,
//                   //     offset: Offset(
//                   //       1,
//                   //       0,
//                   //     ),
//                   //   ),
//                   // ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Stack(
//                           children: [
//                             Container(
//                               height: size.height * 0.1,
//                               width: size.width * 0.22,
//                               // color:Colors.blue,
//                               child: Center(
//                                 child: Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(15.0),
//                                       child: Container(
//                                         height: size.height * 0.08,
//                                         width: size.width * 0.18,
//                                         //color: Colors.black,
//                                         child: Image.asset(
//                                             'assets/svgs/jon.jpg'),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               //bottom: 10,
//                               top: 2,
//                               left: 55,
//                               child: Image.asset(
//                                 'assets/icons/statusicon.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             )
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   SizedBox(
//                                     width:size.width * 0.5,
//                                     child: Text(
//                                       Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[index].receiver['first_name']+" "+Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[index].receiver['last_name'],
//                                       maxLines: 1,softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(
//                                           color: textBlackColor,
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               SizedBox(
//                                 width: size.width * 0.4,
//                                 child: Text(
//                                   Provider.of<ApiDataProvider>(context,listen: false).usersHavingChatList[index].message,
//                                   softWrap: false,
//                                   overflow: TextOverflow.fade,
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       color: greyColor,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

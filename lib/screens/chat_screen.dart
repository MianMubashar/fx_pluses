import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/model/show_chat_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/text_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static final String id='ChatScreen_Screen';
   ChatScreen({Key? key,required this.reciever_id,required this.name}) : super(key: key);
  int reciever_id;
  String name;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageText=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: widget.name,
            check: true,
          )),
      body: Column(
        children: [
          Stream_Builder(recieverId: widget.reciever_id),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(

            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 1,
                  onPressed: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any,allowedExtensions: null,allowMultiple: false);
                      if (result == null) {
                        print("No file selected");
                      } else {
                        Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                            Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                            widget.reciever_id, '',result.files.single.path.toString(),'image' );
                        print(result.files.single.name);
                        print(result.files.single.path);
                      }

                  },
                  icon: Image.asset('assets/icons/attach_fileicon.png',height: size.height * 0.03,),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.05,
                // ),
                Expanded(
                  child: TextField(
                    controller: messageText,
                    maxLines: null,
                   minLines:1,
                   // controller: textEditingController,
                    onChanged: (value) {
                      //text = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      isDense: true
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if(messageText.text.isNotEmpty){
                      await Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                          Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                          widget.reciever_id, messageText.text,'','' );
                      messageText.clear();
                    }else{

                    }

                    // showDialog(context: context, builder: (context){
                    //   return TextBubble();
                    // });
                    // createChatMessages();
                    // String chatId=Provider.of<ProviderClass>(context,listen: false).chatRoomId;
                    // databaseMethods.createFriends(chatId,widget.email, widget.image, widget.friendName, text);
                    // // Provider.of<ProviderClass>(context, listen: false)
                    // //             .dataCame ==
                    // //         true
                    // //     ? CircularProgressIndicator()
                    // //     : Provider.of<ProviderClass>(context, listen: false)
                    // //         .getMessageData();
                    // textEditingController.clear();
                  },
                  icon: Image.asset('assets/icons/sendicon.png',height: size.height * 0.03,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Stream_Builder extends StatelessWidget {
   Stream_Builder({Key? key,required this.recieverId}) : super(key: key);
  final int recieverId;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<http.Response>(
          stream: Provider.of<ApiDataProvider>(context,listen: false).showChat(
            context,
            Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
            recieverId
          ),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Container(
                  height: 40,width: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }else{
              var response= snapshot.data!;
              List<TextBubble> list=[];
              print('stream builder 4');
              if(response.statusCode==200){
                print('stream builder 5');
                Map<String, dynamic> apiResponse = jsonDecode(response.body);
                bool status = apiResponse['status'];
                if(status){
                  Provider.of<ApiDataProvider>(context,listen: false).showChatList.clear();
                  List<dynamic> data=apiResponse['messages'];

                  for(int i=0;i<data.length;i++) {
                    Provider.of<ApiDataProvider>(context,listen: false).showChatList.add(ShowChatModel.fromJson(data[i]));
                    String? message=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].message;
                    String? filePath=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].file;
                    final isMe=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].sender_id==Provider.of<ApiDataProvider>(context,listen: false).id?true:false;
                    final listWidget=TextBubble(message: message,isMe:isMe,filePath: filePath,);
                    list.add(listWidget);
                  }
                }
              }else{
                List<dynamic> data=Provider.of<ApiDataProvider>(context,listen: false).showChatList;

                for(int i=0;i<data.length;i++) {
                  String? message=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].message;
                  String? filePath=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].file;
                  final isMe=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].sender_id==Provider.of<ApiDataProvider>(context,listen: false).id?true:false;
                  final listWidget=TextBubble(message: message,isMe: isMe,filePath: filePath,);
                  list.add(listWidget);
                }
              }
              print('stream builder 6');

              return ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: list,
              );
            }
          },
        )

    );
  }
}


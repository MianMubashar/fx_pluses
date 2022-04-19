import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fx_pluses/model/show_chat_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/revise_rate_dialog.dart';
import 'package:fx_pluses/reuseable_widgets/text_bubble.dart';
import 'package:fx_pluses/screens/customer/creciever_info.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../constants.dart';

import '../model/get_currencies_model.dart';
import '../reuseable_widgets/customloader.dart';

String? msg='';
class ChatScreen extends StatefulWidget {
  static final String id='ChatScreen_Screen';
   ChatScreen({Key? key,required this.reciever_id,required this.name,required this.transactionId,required this.transaction,required this.rateOffer}) : super(key: key);
  int reciever_id;
  String name;
  Map<String,dynamic>? rateOffer;
  Map<dynamic,dynamic>? transaction;
  int? transactionId;




  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageText=TextEditingController();
  bool messageSentCheck=false;
  double ratingBar=0;


  List<String> emailCheck(String message){
    RegExp regExpForEmail=RegExp(
      r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
      caseSensitive: false,
      multiLine: false,
    );

    final matches=regExpForEmail.allMatches(message);

    List<String> emails=[];
    if (matches != null) {
      for (final Match match in matches) {
        emails.add(message.substring(match.start, match.end));
      }
    }
    return emails;
  }

  Widget getAppropriateWidget(){

    if(Provider.of<ApiDataProvider>(context,listen: false).roleId == 5 && Provider.of<ApiDataProvider>(context,listen: true).chatOffers != null ) {
      var size = MediaQuery.of(context).size;

      if(widget.transactionId != null) {
        if (Provider.of<ApiDataProvider>(context, listen: true).chatOffers?['title'] == 'pending') {
          print('pending');


          return IconButton(
            icon: Icon(Icons.thumbs_up_down, color: whiteColor,),
            onPressed: () async {
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.5,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15)

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 15,),
                            Text(
                              'Are you sure you want to accept this offer? \n'
                              '$msg',
                              textAlign: TextAlign.center, style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: buttonColor
                                      ), onPressed: () async {
                                        Navigator.pop(context);
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CRecieverInfo(reciever_id: widget.reciever_id, transaction_id: widget.transactionId)));
                                    // bool checkStatus = await Provider.of<ApiDataProvider>(context, listen: false).completeTransaction(context,
                                    //     Provider.of<ApiDataProvider>(context, listen: false).bearerToken,
                                    //     widget.transactionId,
                                    //     'completed');
                                    // if (!checkStatus) {
                                    //   return;
                                    // }
                                    // Navigator.pop(context);
                                    // showDialog(context: context,
                                    //     barrierDismissible: false,
                                    //     builder: (context) {
                                    //       return Dialog(
                                    //         child: Container(
                                    //           height: size.height * 0.2,
                                    //           width: size.width * 0.3,
                                    //           decoration: BoxDecoration(
                                    //               color: whiteColor,
                                    //               borderRadius: BorderRadius
                                    //                   .circular(15)
                                    //           ),
                                    //           child: Column(
                                    //             mainAxisAlignment: MainAxisAlignment
                                    //                 .spaceAround,
                                    //             children: [
                                    //               Text(
                                    //                 'Rating', style: TextStyle(
                                    //                   color: blackColor,
                                    //                   fontWeight: FontWeight
                                    //                       .bold,
                                    //                   fontSize: 15
                                    //               ),),
                                    //               Center(
                                    //                 child: RatingBar.builder(
                                    //                   initialRating: ratingBar,
                                    //                   minRating: 1,
                                    //                   direction: Axis
                                    //                       .horizontal,
                                    //                   allowHalfRating: false,
                                    //                   itemCount: 5,
                                    //                   itemPadding: EdgeInsets
                                    //                       .symmetric(
                                    //                       horizontal: 4.0),
                                    //                   itemBuilder: (context,
                                    //                       _) =>
                                    //                       Icon(
                                    //                         Icons.star,
                                    //                         color: Colors.amber,
                                    //                       ),
                                    //                   onRatingUpdate: (rating) {
                                    //                     ratingBar = rating;
                                    //                     setState(() {
                                    //
                                    //                     });
                                    //                     print(rating);
                                    //                   },
                                    //                 ),
                                    //               ),
                                    //               InkWell(
                                    //                 onTap: () {
                                    //                   Provider.of<
                                    //                       ApiDataProvider>(
                                    //                       context,
                                    //                       listen: false)
                                    //                       .rateMerchant(context,
                                    //                       Provider
                                    //                           .of<
                                    //                           ApiDataProvider>(
                                    //                           context,
                                    //                           listen: false)
                                    //                           .bearerToken,
                                    //                       widget.reciever_id,
                                    //                       ratingBar);
                                    //                 },
                                    //                 child: Container(
                                    //                   height: MediaQuery
                                    //                       .of(context)
                                    //                       .size
                                    //                       .height * 0.04,
                                    //                   width: MediaQuery
                                    //                       .of(context)
                                    //                       .size
                                    //                       .width * 0.5,
                                    //                   //margin: EdgeInsets.only(bottom: bottomMargin==null ? 2 : bottomMargin!),
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius: BorderRadius
                                    //                         .circular(20),
                                    //                     gradient: gradient,
                                    //                   ),
                                    //                   child: Center(child: Text(
                                    //                     'Rate',
                                    //                     style: TextStyle(
                                    //                         color: Colors.white
                                    //                     ),)),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     });
                                  }, child: Text('Yes')),
                                ),
                                SizedBox(width: 5,),
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: buttonColor
                                      ),
                                      onPressed: () async{

                                        Navigator.pop(context);

                                        await Provider.of<ApiDataProvider>(context, listen: false).UpdateOfferStatus(context,
                                            Provider.of<ApiDataProvider>(context, listen: false).bearerToken,
                                            Provider.of<ApiDataProvider>(context, listen: false).chatOfferId,
                                            3,
                                            widget.reciever_id);

                                        await Provider.of<ApiDataProvider>(Get.context!, listen: false).showChatFirst(Get.context!,
                                            Provider.of<ApiDataProvider>(Get.context!, listen: false).bearerToken,
                                            widget.reciever_id,
                                        widget.transactionId);




                                      }, child: Text('No')),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        } else {
          return Container();
        }
      }else{
        return Container();
      }

    }else{
      if(widget.transactionId != null && Provider.of<ApiDataProvider>(context,listen: false).roleId == 4){
        if(Provider.of<ApiDataProvider>(context,listen: true).chatOffers == null || Provider.of<ApiDataProvider>(context,listen: true).chatOffers?['title']=='declined') {
          return IconButton(onPressed: () {
            showDialog(context: context,
                barrierDismissible: true,
                builder: (dialogContext) {
                  return ReviseRateDialog(reciever_id: widget.reciever_id,
                    transaction_id: widget.transactionId,);
                });
          }, icon: Icon(Icons.local_offer_outlined, color: whiteColor,));
        }else{
          return Container();
        }
      }else{
        return Container(
        );
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        setState(() {

        });
        Provider.of<ApiDataProvider>(context, listen: false).setChatOffers(null);
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              centerTitle: true,
              backgroundColor: buttonColor,
              title: Text(
                widget.name,
                style: TextStyle(
                    color: whiteColor, fontSize: 23, fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                icon: Image.asset(
                  'assets/images/backbutton.png',
                  height: size.height * 0.08,
                  width: size.width * 0.08,
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions: [
                getAppropriateWidget()
              ],
            ),
        ),
        body: SafeArea(
          child: Column(

            children: [
              // Provider.of<ApiDataProvider>(context,listen: false).roleId == 5?
              // widget.transactionId != null?
              // InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CRecieverInfo(transaction_id: widget.transactionId,reciever_id: widget.reciever_id,)));
              //   },
              //   child: Container(
              //     height: size.height * 0.05,
              //     width: size.width,
              //     decoration: BoxDecoration(
              //         color: buttonColor
              //     ),
              //     child: Center(child: Text('Enter Receiver Detail',style: TextStyle(
              //       color: whiteColor,
              //
              //     ),)),
              //   ),
              // )
              //     :Container()
              //     :Container(),
              Stream_Builder(recieverId: widget.reciever_id,transactionId: widget.transactionId,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(

                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Provider.of<ApiDataProvider>(context,listen: false).roleId == 4?
                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   splashRadius: 1,
                    //   onPressed: () async{
                    //       FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any,allowedExtensions: null,allowMultiple: false);
                    //       if (result == null) {
                    //         print("No file selected");
                    //       } else {
                    //         Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                    //             Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                    //             widget.reciever_id, '',result.files.single.path.toString(),'image',widget.transactionId );
                    //         print(result.files.single.name);
                    //         print(result.files.single.path);
                    //       }
                    //
                    //   },
                    //   icon: Image.asset('assets/icons/attach_fileicon.png',height: size.height * 0.03,),
                    // ):Container(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
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



                          // String pattern = r'\b[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*\b';
                          String pattern = r'\b[+]*[(]{0,1}[6-9]{1,4}[)]{0,1}[-\s\.0-9]*\b';
                          RegExp regExp = new RegExp(pattern,caseSensitive: false,multiLine: false);

                          final phoneNumberMatches=regExp.allMatches(messageText.text);
                          List<String> phoneNumbers=[];
                          if(phoneNumberMatches != null){
                            for(final Match match in phoneNumberMatches){
                              phoneNumbers.add(messageText.text.substring(match.start,match.end));
                            }
                          }
                          print('number is ${phoneNumberMatches}');


                          List<String> emails=emailCheck(messageText.text);
                          print('email is is $emails');
                          if(emails.isNotEmpty){
                            showDialog(context: context, builder: (dialogContext){
                              return AlertDialog(
                                title: Text('You cannot send email or phone number here',style: TextStyle(
                                    color: buttonColor
                                ),),
                                backgroundColor: whiteColor,
                                actions: [
                                  Center(
                                    child: ElevatedButton(onPressed: (){
                                      Navigator.pop(dialogContext);
                                    },child: Text('Close'),style: ElevatedButton.styleFrom(
                                        primary: buttonColor
                                    ),),
                                  )
                                ],
                              );
                            });
                          }else{
                            if(phoneNumbers.isNotEmpty){
                              showDialog(context: context, builder: (dialogContext){
                                return AlertDialog(
                                  title: Text('You cannot send email or phone number here',style: TextStyle(
                                      color: buttonColor
                                  ),),
                                  backgroundColor: whiteColor,
                                  actions: [
                                    Center(
                                      child: ElevatedButton(onPressed: (){
                                        Navigator.pop(dialogContext);
                                      },child: Text('Close'),style: ElevatedButton.styleFrom(
                                          primary: buttonColor
                                      ),),
                                    )
                                  ],
                                );
                              });
                            }else{
                              messageSentCheck=true;
                              setState(() {

                              });
                              await Provider.of<ApiDataProvider>(context,listen: false).sendMessage(context,
                                  Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                                  widget.reciever_id, messageText.text,'','',widget.transactionId,null,null,null,null,null);
                              messageText.clear();
                              messageSentCheck=false;
                              setState(() {

                              });
                            }

                          }

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
                      icon: messageSentCheck?CircularProgressIndicator(color: buttonColor,):Image.asset('assets/icons/sendicon.png',height: size.height * 0.03,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stream_Builder extends StatelessWidget {
   Stream_Builder({Key? key,required this.recieverId,required this.transactionId}) : super(key: key);
  final int recieverId;
  final int? transactionId;
  int a=0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<http.Response>(
          stream: Provider.of<ApiDataProvider>(context,listen: false).showChat(
            context,
            Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
            recieverId,
            transactionId
          ),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Container(
                  height: 40,width: 40,
                  child: const Center(
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
                  List<dynamic> data;
                  if(transactionId == null){
                     data=apiResponse['messages'];
                  }else{
                    List<dynamic> data1=apiResponse['messages'];

                    data1.removeLast();
                    data=data1;

                    Map<String, dynamic>? offer=apiResponse['rate_offer'];
                    if(offer != null) {
                      msg =
                          offer['from_country']['currency']['name'] + " to " +
                              offer['to_country']['currency']['name'] + "\n" +
                              "Rate: " + offer['rate'];
                    }
                    // WidgetsBinding.instance!.addPostFrameCallback((_) {
                    //   // Add Your Update Code here.
                    // if(a==0){
                    //  Provider.of<ApiDataProvider>(context,listen: false).setChatOffers(apiResponse['rate_offer']);
                    //   a=a+1;
                    // }

                    // });
                  }



                  for(int i=0;i<data.length;i++) {
                    Provider.of<ApiDataProvider>(context,listen: false).showChatList.add(ShowChatModel.fromJson(data[i]));
                    String? message=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].message;
                    String? filePath=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].file;
                    String? isAdmin=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].isAdmin;
                    String? firstName=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].sender['first_name'];
                    final isMe;
                    isAdmin=='1'? isMe=false:
                    isMe=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].sender_id==Provider.of<ApiDataProvider>(context,listen: false).id?true:false;
                    final listWidget=TextBubble(message: message,isMe:isMe,filePath: filePath,isAdmin: isAdmin,firstName: firstName,);
                    list.add(listWidget);
                  }
                }
              }else{
                List<dynamic> data=Provider.of<ApiDataProvider>(context,listen: false).showChatList;

                for(int i=0;i<data.length;i++) {
                  String? message=data[i].message;
                  String? filePath=data[i].file;
                  String? isAdmin=data[i].isAdmin;
                  String? firstName=data[i].sender['first_name'];
                  final isMe;
                  isAdmin=='1'? isMe=false:
                  isMe=Provider.of<ApiDataProvider>(context,listen: false).showChatList[i].sender_id==Provider.of<ApiDataProvider>(context,listen: false).id?true:false;
                  final listWidget=TextBubble(message: message,isMe: isMe,filePath: filePath,isAdmin: isAdmin,firstName: firstName,);
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


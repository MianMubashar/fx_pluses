import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class CInviteFriend2 extends StatelessWidget {
  static final String id = 'CInviteFriend2_Screen';
  int check = 0;
  final items = ['Select All', 'Deselect All'];
  List<Contact> contacts = [];
  CInviteFriend2({required this.contacts});
  TextEditingController messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          backgroundColor: buttonColor,
          title: const Text(
            'Invite a friend',
            style: TextStyle(
                color: whiteColor, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: Image.asset(
              'assets/images/backbutton.png',
              height: size.height * 0.08,
              width: size.width * 0.08,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 10.0),
            //   child: DropdownButton(
            //     borderRadius: BorderRadius.circular(10),
            //     //value: dropdownvalue,
            //     icon: Image.asset(
            //       'assets/icons/actionicon.png',
            //       height: size.height * 0.08,
            //       width: size.width * 0.08,
            //     ),
            //     items:items.map((String items) {
            //       return DropdownMenuItem(
            //           value: items,
            //           child: Text(items)
            //       );
            //     }
            //     ).toList(),
            //     underline: Container(color: Colors.transparent,),
            //     onChanged: (newValue){
            //
            //     },
            //
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {},
                      child: Container(
                        height: size.height * 0.13,
                        width: size.width,
                        margin: EdgeInsets.only(bottom: 1, right: 10, top: 10),
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
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.45,
                                            child: Text(
                                              contacts[index].displayName!,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
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
                                      Text(
                                        contacts[index].phones!.length > 0
                                            ? contacts[index]
                                                .phones![0]
                                                .value
                                                .toString()
                                            : '',
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () async {

                                showDialog(context: context, builder: (dialogContext){
                                  return Dialog(
                                    child: Container(
                                      height: size.height * 0.3,
                                      width:  size.width * 0.3,
                                      padding: EdgeInsets.only(top: size.height * 0.04,left: 20,right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: whiteColor
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:size.height * 0.15,
                                            child: TextField(
                                              controller: messageController,
                                              textInputAction: TextInputAction.newline,
                                              keyboardType: TextInputType.multiline,
                                              maxLines: 50,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                filled: true,
                                                hintText: 'Enter you message here',
                                                isDense: true,

                                              ),
                                            ),
                                          ),
                                      InkWell(
                                        onTap: () async{
                                          Navigator.pop(context);
                                          var whatsappUrl = Uri.encodeFull(
                                              "https://api.whatsapp.com/send?phone=${contacts[index].phones!.length > 0 ? contacts[index].phones![0].value : ''}&text='${messageController.text}'");
                                          if (!await launch(whatsappUrl))
                                            throw 'Could not launch $whatsappUrl';
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          margin: EdgeInsets.only(top: size.height * 0.02),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            gradient: gradient,
                                          ),
                                          child: Center(child: Text('Send',style: TextStyle(
                                              color: Colors.white
                                          ),)),
                                        ),
                                      )
                                        ],
                                      ),
                                    ),
                                  );
                                });

                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: size.height * 0.05,
                                width: size.width * 0.28,
                                decoration: BoxDecoration(
                                    color: Color(0xFF4BC75A),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'assets/icons/whatsappicon.png',
                                        height: size.height * 0.03,
                                      ),
                                      Text(
                                        'watsapp',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend2.dart';
import 'package:get/get.dart';

class CInviteFriend extends StatelessWidget {
  static final String id='CInviteFriend_Screen';
   CInviteFriend({Key? key}) : super(key: key);

  List<Contact> contacts=[];
  Future getData() async{
    contacts=await ContactsService.getContacts(withThumbnails: false);
  }

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
            text: 'Invite a friend',
            check: true,
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/invite.png',
              //fit: BoxFit.contain,
              width: size.width * 0.7,
              height: size.height * 0.33,
            ),
            SizedBox(
              height: size.height * 0.002,
            ),
            Text(
              'Invite your friends',
              style: TextStyle(
                  color: buttonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: size.height * 0.03,
            // ),
            // Flexible(
            //   child: Text(
            //     ' Intive a friend and get 5% off the Merchant Fees on your next transactions.',
            //     maxLines: 2,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.08,
            ),

            MainButton(text: 'Invite', onPress: () async{
              Get.dialog(CustomLoader());
              await getData();
              Get.back();
              print('bbbbbbbbbbbbbbbbbbbbbb${contacts.length}');
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CInviteFriend2(contacts: contacts,)));
            },)
          ],
        ),
      ),
    );
  }
}

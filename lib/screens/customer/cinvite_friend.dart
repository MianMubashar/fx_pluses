
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/customloader.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend2.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


class CInviteFriend extends StatelessWidget {
  static final String id='CInviteFriend_Screen';
   CInviteFriend({Key? key}) : super(key: key);

  List<Contact> contacts=[];
  Future getData(BuildContext context) async{
    Get.dialog(CustomLoader());
  var serviceStatus= await Permission.contacts.status;
  if(serviceStatus==PermissionStatus.granted) {

    contacts = await ContactsService.getContacts(withThumbnails: false);
    Get.back();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CInviteFriend2(contacts: contacts,)));
  }else{
    Get.back();
    Permission.contacts.request().then((value) async{
      if(value.isGranted){
        Get.dialog(CustomLoader());
        contacts = await ContactsService.getContacts(withThumbnails: false);
        Get.back();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CInviteFriend2(contacts: contacts,)));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CInviteFriend()));
      }
    });
   // serviceStatus=await Permission.contacts.status;

  }
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

              await getData(context);

              print('bbbbbbbbbbbbbbbbbbbbbb${contacts.length}');

            },)
          ],
        ),
      ),
    );
  }
}

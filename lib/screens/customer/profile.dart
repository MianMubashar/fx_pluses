import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/main.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/profile_card.dart';
import 'package:fx_pluses/screens/about.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend.dart';
import 'package:fx_pluses/screens/customer/crefer_code.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/help_support.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/transaction_history.dart';
import 'package:fx_pluses/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class CProfile extends StatelessWidget {
  static final String id='CProfile_Screen';
  const CProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {},
            text: 'Profile',
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.1,
                  width: size.width,
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: profileColor.withOpacity(0.08),
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black12,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'John Snow',
                                      style: TextStyle(
                                          color: textBlackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10,),
                                    IconButton(
                                      constraints: BoxConstraints(
                                      ),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/icons/editicon.png',
                                          width: size.width * 0.03,
                                        ))
                                  ],
                                ),
                                Text(
                                  'example@gmail.com',
                                  style: TextStyle(
                                      color: greyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: greyColor,
                ),
                ProfileCard(
                  iconData: 'assets/icons/walleticon.png',
                  size: size,
                  text: 'My Wallet',
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CWallet()));
                  },
                ),
                ProfileCard(
                  iconData: 'assets/icons/transaction_historyicon.png',
                  size: size,
                  text: 'Transactions History',
                  onPress: () async{
                    await Provider.of<ApiDataProvider>(context,listen: false).customerTrancationHistory(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionHistory()));
                  },
                ),
                ProfileCard(
                  iconData: 'assets/icons/couponicon.png',
                  size: size,
                  text: 'Enter Coupon Code',
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CReferCode()));
                  },
                ),
                ProfileCard(
                  iconData: 'assets/icons/inviteicon.png',
                  size: size,
                  text: 'Invite',
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CInviteFriend()));
                  },
                ),
                ProfileCard(
                  iconData: 'assets/icons/helpicon.png',
                  size: size,
                  text: 'Help and support ',
                  onPress: () async{
                    await Provider.of<ApiDataProvider>(context,listen: false).getAppData(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupport()));
                  },
                ),
                ProfileCard(
                  iconData: 'assets/icons/abouticon.png',
                  size: size,
                  text: 'About ',
                  onPress: () async{
                    await Provider.of<ApiDataProvider>(context,listen: false).getAppData(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                  },
                ),
              ],
            ),
            InkWell(
              onTap: () async{
                SharedPreferences pref=await SharedPreferences.getInstance();
                 await pref.remove(SharedPreference.roleIdKey);
                await pref.remove(SharedPreference.userLoggedInKey);
                 await pref.remove(SharedPreference.bearerTokenKey);
                await pref.remove(SharedPreference.walletKey);
                await pref.remove(SharedPreference.isSeenKey);
                await pref.remove(SharedPreference.firstNameKey);
                await pref.remove(SharedPreference.lastNameKey);
                await Provider.of<ApiDataProvider>(context,listen: false).setBearerToken('');
                Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: profileColor.withOpacity(0.08)),
                child: Center(
                    child: Text(
                  'Logout',
                  style: TextStyle(color: buttonColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

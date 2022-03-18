import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/mmessages.dart';
import 'package:fx_pluses/screens/merchant/mtransaction_requests.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences.dart';
import '../../utils/mcustom_navbar.dart';
class MBottomNavigationBar extends StatefulWidget {
  MBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MBottomNavigationBar> createState() => _MBottomNavigationBarState();
}

class _MBottomNavigationBarState extends State<MBottomNavigationBar> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  String? bearerToken;
  String? balance;

  List<Widget> _buildScreens() {
    return [
      MHome(), MTransactionRequests(), MWallet(), MMessages()
    ];
  }

  getData() async{
    await Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequests(context,
        Provider.of<ApiDataProvider>(context,listen: false).bearerToken);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: _buildScreens().length, // This is required in case of custom style! Pass the number of items for the nav bar.
      screens: _buildScreens(),
      confineInSafeArea: false,
      handleAndroidBackButtonPress: false,


      // onItemSelected: (int) {
      //   setState(() {}); // This is required to update the nav bar if Android back button is pressed
      // },
      customWidget: CustomNavBarWidget( // Your custom widget goes here

        items: [
          PersistentBottomNavBarItem(

            icon: Image.asset(_controller.index==0?'assets/images/bhome.png':'assets/images/home.png',
              height: size.height * 0.04,
              width: size.width * 0.07,),
            title: ("Home"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(_controller.index==1?'assets/images/brequest.png':'assets/images/request.png',
              height: size.height * 0.04,
              width: size.width * 0.06,),
            title: ("Requests"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(_controller.index==2?'assets/images/bwallet.png':'assets/images/wallet.png',
              height: size.height * 0.04,
              width: size.width * 0.07,),
            title: ("Wallet"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(_controller.index==3?'assets/images/bmessage.png':'assets/images/message.png',
              height: size.height * 0.04,
              width: size.width * 0.07,),
            title: ("Message\'s"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),

        ],
        selectedIndex: _controller.index,
        onItemSelected: (index) async{
          _controller.index = index;// NOTE: THIS IS CRITICAL!! Don't miss it!

          if(index==0 || index == 1){
            await getData();
          }
          setState(() {

          });


        },
      ),
    );
  }
}

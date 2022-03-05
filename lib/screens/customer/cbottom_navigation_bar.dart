import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/customer/cmessages.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/customer/profile.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/mmessages.dart';
import 'package:fx_pluses/screens/merchant/mtransaction_requests.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences.dart';
import '../../utils/mcustom_navbar.dart';
class CBottomNavigationBar extends StatefulWidget {
  static final String id ='CBottomNavigationBar_screen';
  CBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CBottomNavigationBar> createState() => _CBottomNavigationBarState();
}

class _CBottomNavigationBarState extends State<CBottomNavigationBar> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  String? bearerToken;
  String? balance;
  String? firstName;
  String? lastName;

  List<Widget> _buildScreens() {
    return [
      CHome(), CWallet(), CMessages(), CProfile()
    ];
  }
  getData() async{
    print('get data');
    SharedPreferences preferences=await SharedPreferences.getInstance();
    bearerToken=await preferences.getString(SharedPreference.bearerTokenKey);
    balance=await preferences.getString(SharedPreference.walletKey);
    firstName=await preferences.getString(SharedPreference.firstNameKey);
    lastName=await preferences.getString(SharedPreference.lastNameKey);
    await Provider.of<ApiDataProvider>(context,listen: false).setBearerToken(bearerToken!);
    await Provider.of<ApiDataProvider>(context,listen: false).setFirstName(firstName!);
    await Provider.of<ApiDataProvider>(context,listen: false).setLastName(lastName!);
    await Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
    await Provider.of<ApiDataProvider>(context, listen: false)
        .getCountries(context, bearerToken!);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
    setState(() {

    });
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: 4, // This is required in case of custom style! Pass the number of items for the nav bar.
      screens: _buildScreens(),
      confineInSafeArea: false,
      handleAndroidBackButtonPress: true,


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
            icon: Image.asset(_controller.index==1?'assets/images/bwallet.png':'assets/images/wallet.png',
              height: size.height * 0.04,
              width: size.width * 0.06,),
            title: ("Wallet"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(_controller.index==2?'assets/images/bmessage.png':'assets/images/message.png',
              height: size.height * 0.04,
              width: size.width * 0.07,),
            title: ("Message\'s"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(_controller.index==3?'assets/images/bprofile.png':'assets/images/profile.png',
              height: size.height * 0.04,
              width: size.width * 0.07,),
            title: ("Profile"),
            activeColorPrimary: CupertinoColors.activeBlue,
            inactiveColorPrimary: CupertinoColors.systemGrey,
          ),

        ],
        selectedIndex: _controller.index,
        onItemSelected: (index) {
          setState(() {
         //   getData();
            _controller.index = index;// NOTE: THIS IS CRITICAL!! Don't miss it!
            print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${_controller.index}');
          });
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/customer/chome.dart';
import 'package:fx_pluses/screens/customer/cmessages.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/customer/profile.dart';
import 'package:fx_pluses/screens/home.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/mmessages.dart';
import 'package:fx_pluses/screens/merchant/mtransaction_requests.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:fx_pluses/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preferences.dart';
import '../../utils/mcustom_navbar.dart';

class CBottomNavigationBar extends StatefulWidget {
  static final String id ='CBottomNavigationBar_screen';
  int index = 0;
  CBottomNavigationBar({required this.index,Key? key}) : super(key: key);

  @override
  State<CBottomNavigationBar> createState() => _CBottomNavigationBarState();
}

class _CBottomNavigationBarState extends State<CBottomNavigationBar> {

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  String? bearerToken;
  String? balance;
  String? firstName;
  String? lastName;
  bool exit=false;


  List<Widget> _buildScreens() {
    return [
      CHome(), CWallet(), CMessages(), CProfile(backButtonEnabled: false,)
    ];
  }


  // getData() async{
  //   print('get data');
  //   SharedPreferences preferences=await SharedPreferences.getInstance();
  //   bearerToken=await preferences.getString(SharedPreference.bearerTokenKey);
  //   balance=await preferences.getString(SharedPreference.walletKey);
  //   firstName=await preferences.getString(SharedPreference.firstNameKey);
  //   lastName=await preferences.getString(SharedPreference.lastNameKey);
  //   await Provider.of<ApiDataProvider>(context,listen: false).setBearerToken(bearerToken!);
  //   await Provider.of<ApiDataProvider>(context,listen: false).setFirstName(firstName!);
  //   await Provider.of<ApiDataProvider>(context,listen: false).setLastName(lastName!);
  //   await Provider.of<ApiDataProvider>(context,listen: false).setBalance(balance!);
  //   await Provider.of<ApiDataProvider>(context, listen: false)
  //       .getCountries(context, bearerToken!);
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
    _controller = PersistentTabController(initialIndex : widget.index);
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    // Widget child;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            child: WillPopScope(
              onWillPop: () async
              {
                if(_controller.index==0){
                  if(Provider.of<ApiDataProvider>(context,listen: false).screenIndex==0){

                    return false;
                  }else {
                    setState(() {

                    });
                    return true;
                  }
                }else{

                  setState(() {

                  });
                  //Get.back();
                  return true;
                }
              },
              child: PersistentTabView.custom(

                context,
                controller: _controller,
                itemCount: _buildScreens().length, // This is required in case of custom style! Pass the number of items for the nav bar.
                screens: _buildScreens(),
                confineInSafeArea: false,
                handleAndroidBackButtonPress: true,
                stateManagement: true,
                // selectedTabScreenContext: (selectedTabContext) {
                //   Future.delayed(Duration.zero, () {
                //     Navigator.of(selectedTabContext!).popUntil((route) {
                //       return route.isFirst;
                //     });
                //   });
                //
                // },
                // routeAndNavigatorSettings: CutsomWidgetRouteAndNavigatorSettings(
                //   initialRoute: CHome.id,
                //   // navigatorObservers: [NavigationHistoryObserver()],
                //
                //   routes: {
                //     CHome.id: (context) => CHome(),
                //     CWallet.id: (context) => CWallet(),
                //     CMessages.id: (context) => CMessages(),
                //     CProfile.id: (context) => CProfile(backButtonEnabled: false,),
                //   }
                //
                // ),
                onWillPop: (value) async{
                  showDialog(context: context,barrierDismissible: false, builder: (context){
                    return AlertDialog(
                      title: Text('Are you sure you want to close the app'),
                      actions: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: (){
                                  SystemNavigator.pop();
                                },
                                child: Text('Yes'),
                              ),

                              FlatButton(
                                onPressed: (){
                                  exit=false;
                                  Get.back();
                                },
                                child: Text('No'),
                              )
                            ],
                          ),
                        )
                      ],
                    );

                  });
                  return exit;
                },


                //stateManagement: false,
                // onWillPop: (value) async{
                //   Provider.of<ApiDataProvider>(context,listen: false).chatMenu(
                //     context,
                //     Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                //   ).listen((event) {}).cancel();
                //   return true;
                // },




                // onItemSelected: (int) {
                //   setState(() {}); // This is required to update the nav bar if Android back button is pressed
                // },
                customWidget: CustomNavBarWidget(
                  // Your custom widget goes here

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
                      icon: Stack(
                        children: [
                          Image.asset(_controller.index==2?'assets/images/bmessage.png':'assets/images/message.png',
                            height: size.height * 0.04,
                            width: size.width * 0.07,),
                          Provider.of<ApiDataProvider>(context,listen: true).unread_total_msg == 0 ? SizedBox() :  Positioned(
                            // draw a red marble
                            top: 0.0,
                            right: 0.0,
                            child: Container(
                              height: 12,
                                width: 12,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(Provider.of<ApiDataProvider>(context,listen: true).unread_total_msg.toString(),
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize:6
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),
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
                  onItemSelected: (index) async{

                    if(index==2){
                      Provider.of<ApiDataProvider>(context,listen: false).setUnreadTotalMsg(0);
                    }


                    if(_controller.index == index){
                      int screen= await Provider.of<ApiDataProvider>(context,listen: false).screenIndex;
                      print("same tab");
                      if(screen != index) {
                        print("pop now");
                        await Provider.of<ApiDataProvider>(context, listen: false)
                            .setScreenIndex(index);

                        // NOTE: THIS IS CRITICAL!! Don't miss it!

                        Navigator.pushAndRemoveUntil(
                          Get.context!, MaterialPageRoute(builder: (context) {
                          return CBottomNavigationBar(index: index);
                        }), (route) => false,);

                      }
                    }else{
                      print("different tab");
                      _controller.index =
                          index;

                      setState(() {

                      });
                    }



                  },
                ),
              ),
            )
        ),
      ),
    );
  }

}

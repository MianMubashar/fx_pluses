import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/merchant/mhome.dart';
import 'package:fx_pluses/screens/merchant/mmessages.dart';
import 'package:fx_pluses/screens/merchant/mtransaction_requests.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../shared_preferences.dart';
import '../../utils/mcustom_navbar.dart';

class MBottomNavigationBar extends StatefulWidget {
  MBottomNavigationBar({Key? key,required this.index}) : super(key: key);
  int index=0;
  @override
  State<MBottomNavigationBar> createState() => _MBottomNavigationBarState();
}

class _MBottomNavigationBarState extends State<MBottomNavigationBar> {
  PersistentTabController _controller = PersistentTabController();
  String? bearerToken;
  String? balance;
  bool exit=false;

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
    _controller = PersistentTabController(initialIndex : widget.index);
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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
                  }else{
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
                      icon: Stack(
                        children: [
                          Image.asset(_controller.index==3?'assets/images/bmessage.png':'assets/images/message.png',
                            height: size.height * 0.04,
                            width: size.width * 0.07,),
                          Provider.of<ApiDataProvider>(context,listen: true).unread_total_msg == 0 ? SizedBox() :Positioned(
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
                                child: Text(Provider.of<ApiDataProvider>(context,listen: false).unread_total_msg.toString(),
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

                  ],
                  selectedIndex: _controller.index,
                  onItemSelected: (index) async{


                    if(index==3){
                      Provider.of<ApiDataProvider>(context,listen: false).setUnreadTotalMsg(0);
                    }

                    if(_controller.index == index) {
                      int screen= await Provider.of<ApiDataProvider>(context,listen: false).screenIndex;
                      if(screen != index) {

                        await Provider.of<ApiDataProvider>(context, listen: false)
                            .setScreenIndex(index);
                        if (index == 0 || index == 1) {
                          await getData();
                        }

                        Navigator.pushAndRemoveUntil(
                            Get.context!, MaterialPageRoute(builder: (context) {
                          return MBottomNavigationBar(index: index);
                        }), (route) => false);

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

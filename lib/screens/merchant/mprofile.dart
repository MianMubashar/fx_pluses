import 'dart:ffi';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:fx_pluses/reuseable_widgets/profile_card.dart';
import 'package:fx_pluses/screens/about.dart';
import 'package:fx_pluses/screens/customer/cinvite_friend.dart';
import 'package:fx_pluses/screens/customer/crefer_code.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/help_support.dart';
import 'package:fx_pluses/screens/login_signup/login.dart';
import 'package:fx_pluses/screens/merchant/mexchange_rates.dart';
import 'package:fx_pluses/screens/merchant/mwallet.dart';
import 'package:fx_pluses/screens/transaction_history.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../shared_preferences.dart';
import '../update_profile.dart';

class MProfile extends StatelessWidget {
  static final String id='MProfile_Screen';
   MProfile({Key? key}) : super(key: key);
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: 'Profile',
            check: true,
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: size.height * 0.75,
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
                              InkWell(
                                onTap:() async{
                                  final ImagePicker _picker = ImagePicker();
                                  final XFile? result=await _picker.pickImage(source: ImageSource.gallery);
                                  //FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any,allowedExtensions: null,allowMultiple: false);
                                  if (result == null) {
                                    print("No file selected");
                                  }else{
                                    Provider.of<ApiDataProvider>(context,listen: false).updateProfile(context,
                                        Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                                        '', '', result.path.toString(),'photo',null,null,null,null);

                                  }
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  // backgroundColor: Colors.black12,
                                  backgroundImage: NetworkImage((Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("https") ||
                                      Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("http")) ?
                                  Provider.of<ApiDataProvider>(context,listen: true).photoUrl :
                                  (profile_url + Provider.of<ApiDataProvider>(context,listen: true).photoUrl)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width * 0.45,
                                          child: Text(
                                            Provider.of<ApiDataProvider>(context,listen: true).firstName +" "+ Provider.of<ApiDataProvider>(context,listen: true).lastName,
                                            softWrap: false,overflow: TextOverflow.fade,style: TextStyle(
                                              color: textBlackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        IconButton(
                                            constraints: BoxConstraints(
                                            ),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showDialog(context: context, builder: (context){
                                                return Dialog(
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                                                    height: size.height * 0.3,
                                                    width:  size.width * 0.3,
                                                    decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        TextField(
                                                          controller:firstNameController,
                                                          decoration: InputDecoration(
                                                              hintText: 'First name',
                                                              helperStyle: TextStyle(color: blackColor),
                                                              isDense: true,
                                                              filled: true,
                                                              border: OutlineInputBorder(
                                                                borderSide: BorderSide.none,
                                                                borderRadius: BorderRadius.circular(20),
                                                              )),

                                                        ),
                                                        TextField(
                                                          controller:lastNameController,
                                                          decoration: InputDecoration(

                                                              hintText: 'Last name',
                                                              helperStyle: TextStyle(color: blackColor),
                                                              isDense: true,
                                                              filled: true,
                                                              border: OutlineInputBorder(
                                                                borderSide: BorderSide.none,
                                                                borderRadius: BorderRadius.circular(20),
                                                              )),

                                                        ),
                                                        MainButton(text: 'Update', onPress: (){
                                                          if(firstNameController.text.isEmpty || lastNameController.text.isEmpty){
                                                            Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Please enter valid data',redColor);
                                                          }else{
                                                            Navigator.pop(context);
                                                            Provider.of<ApiDataProvider>(context,listen: false).updateProfile(context,
                                                                Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                                                                firstNameController.text, lastNameController.text, '','',null,null,null,null);
                                                          }
                                                        })
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              );
                                            },
                                            icon: Image.asset(
                                              'assets/icons/editicon.png',
                                              width: size.width * 0.03,
                                            ))
                                      ],
                                    ),
                                    Text(
                                      Provider.of<ApiDataProvider>(context,listen: false).email,
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
                    ProfileCard(iconData:'assets/icons/inviteicon.png', size: size, text: 'My Profile',
                        onPress: () async{
                          await Provider.of<ApiDataProvider>(context,listen: false).setScreenIndex(6);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile(
                          )));
                        }),
                    ProfileCard(
                      iconData: 'assets/icons/transaction_historyicon.png',
                      size: size,
                      text: 'Transactions History',
                      onPress: () async{
                        await Provider.of<ApiDataProvider>(context,listen: false).customerTrancationHistory(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                        await Provider.of<ApiDataProvider>(context,listen: false).setScreenIndex(6);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionHistory()));
                      },
                    ),
                    ProfileCard(
                      iconData: 'assets/icons/couponicon.png',
                      size: size,
                      text: 'Exchange Rates',
                      onPress: () async{
                        await Provider.of<ApiDataProvider>(context,listen: false).GetRate(context,
                            Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                        await Provider.of<ApiDataProvider>(context,listen: false).setScreenIndex(6);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MExchangeRates()));
                      },
                    ),
                    ProfileCard(
                      iconData: 'assets/icons/helpicon.png',
                      size: size,
                      text: 'Help and support ',
                      onPress: () async{
                        await Provider.of<ApiDataProvider>(context,listen: false).getAppData(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                        await Provider.of<ApiDataProvider>(context,listen: false).setScreenIndex(6);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupport()));
                      },
                    ),
                    ProfileCard(
                      iconData: 'assets/icons/abouticon.png',
                      size: size,
                      text: 'About ',
                      onPress: () async{
                        await Provider.of<ApiDataProvider>(context,listen: false).getAppData(context, Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
                        await Provider.of<ApiDataProvider>(context,listen: false).setScreenIndex(6);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async{
                    await Provider.of<ApiDataProvider>(context,listen: false).UpdateOnlineStatus(context,
                        Provider.of<ApiDataProvider>(context,listen: false).bearerToken, 0);
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
        ),
      ),
    );
  }
}

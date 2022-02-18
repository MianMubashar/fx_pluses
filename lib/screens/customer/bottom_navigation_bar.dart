import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/screens/customer/cwallet.dart';
import 'package:fx_pluses/screens/customer/home.dart';
import 'package:fx_pluses/screens/customer/messages.dart';
import 'package:fx_pluses/screens/customer/profile.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({Key? key}) : super(key: key);

  @override
  _BottomnavigationbarState createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  int _selectedIndex = 0;

  List _pages = [Home(), CWallet(), Messages(), Profile()];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          //canvasColor: Colors.white,
          primaryColor: Colors.black,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.black)
          )
        ),
        child: BottomNavigationBar(
          //backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
         selectedItemColor: buttonColor,
         selectedFontSize: 14,
         unselectedFontSize: 14,
         //  fixedColor: Colors.blue,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex==0?'assets/images/bhome.png':
                'assets/images/home.png',
                height: size.height * 0.06,
                width: size.width * 0.1,
              ),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  _selectedIndex==1?'assets/images/bwallet.png':
                  'assets/images/wallet.png',
                  height: size.height * 0.06,
                  width: size.width * 0.1,
                ),
                label: 'Wallet'
                ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex==2?'assets/images/bmessage.png':
                'assets/images/message.png',
                height: size.height * 0.06,
                width: size.width * 0.1,
              ),
                label: 'Message\'s',
                ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  _selectedIndex==3?'assets/images/bprofile.png':
                  'assets/images/profile.png',
                  height: size.height * 0.06,
                  width: size.width * 0.1,
                ),
                label: 'Profile'
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            print('aaaaaaaaaaaaaaaaaa $index');
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/help_support_card.dart';
import 'package:fx_pluses/screens/contact.dart';
import 'package:fx_pluses/screens/faq.dart';
import 'package:fx_pluses/screens/terms_conditions.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

class HelpSupport extends StatelessWidget {
  static final String id='HelpSupport_Screen';
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(size: size,onPress: (){
            Navigator.pop(context);
          },text: 'Help and Support',check: true,)),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            HelpSupportCard(size: size, text: 'FAQ', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
            }),
            HelpSupportCard(size: size, text: 'Terms and conditions', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsConditions()));
            }),
            HelpSupportCard(size: size, text: 'Contact Us', onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(preferredSize:Size.fromHeight(60),child: appbar(text: 'Merchant\'s',size: size,onPress: (){},)),
    );
  }
}

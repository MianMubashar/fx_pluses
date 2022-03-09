
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';

class CustomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: blackColor.withAlpha(50),
      child: Center(
        child: PhysicalModel(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: const SizedBox(
            width: 150,
            height: 150,
            child: SpinKitChasingDots(
              color: buttonColor,
            ),
          ),

        ),
      ),
    );
  }
}
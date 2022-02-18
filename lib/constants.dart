

import 'package:flutter/cupertino.dart';

const buttonColor=Color(0xFF8F38FF);
const linearColor=Color(0xFF2E80FF);
const primaryColor=Color(0xFF0FC0FF);
const secondaryTextColor=Color(0xFF2C83FF);
const blackColor=Color(0xFF0A0B10);
const whiteColor=Color(0xFFFFFFFF);
const greyColor=Color(0xFF666666);
const newColor=Color(0xFF5861FF);

Gradient gradient=LinearGradient(
  colors: [
    const Color(0xFF8F38FF),
    const Color(0xFF5861FF),
  ],
  begin: const FractionalOffset(0.0, 0.0),
  end: const FractionalOffset(0.0, 1.0),
  stops: [0.0, 1.0],
  tileMode: TileMode.clamp,
);

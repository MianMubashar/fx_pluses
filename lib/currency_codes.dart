import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyCodes{
  int? code;
  IconData flag;
  CurrencyCodes({this.code,required this.flag});
}

List<CurrencyCodes> currencyCodes=[
  CurrencyCodes(code: 92,flag: Icons.flag),
  CurrencyCodes(code: 44,flag: Icons.flag_outlined),
  CurrencyCodes(code: 54,flag: Icons.emoji_flags_sharp),
];
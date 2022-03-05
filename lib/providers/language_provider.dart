
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  Locale? _locale=Locale(Platform.localeName.substring(0,2),'');

  Locale get locale =>_locale!;

  setLocale(Locale locale){
    _locale=locale;
    notifyListeners();
  }

  // clearLocale(){
  //   _locale=null;
  //   notifyListeners();
  // }
}
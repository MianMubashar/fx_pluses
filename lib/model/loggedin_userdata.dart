import 'package:flutter/material.dart';
class LoggedInUserData{
  int user_id;
  String firstName;
  String lastName;
  String email;
  String wallet;
  int role_id;
  String country_code;
  String rating;
  String default_currency;
  String photo_url;
  String token;
  LoggedInUserData({required this.user_id,required this.firstName,required this.lastName,required this.email,required this.wallet,required this.role_id,
  required this.country_code,required this.rating,required this.default_currency,required this.photo_url,required this.token});

  factory LoggedInUserData.fromJson(Map<String, dynamic> data){
    return LoggedInUserData(user_id: data['user_id'], firstName: data['firstName'], lastName: data['lastName'], email: data['email'], wallet: data['wallet'], role_id: data['role_id'], country_code: data['country_code'], rating: data['rating'], default_currency: data['default_currency'], photo_url: data['photo_url'], token: data['token']);
  }


}
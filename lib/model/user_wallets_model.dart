import 'dart:convert';

import 'package:fx_pluses/main.dart';

class UserWalletsModel{
  int id;
  String wallet;
  int currency_id;
  int user_id;

  UserWalletsModel({required this.id,required this.wallet,required this.currency_id,required this.user_id});

  factory UserWalletsModel.fromJson(Map<String, dynamic> data){
    return UserWalletsModel(id: data['id'], wallet: data['wallet'], currency_id: data['currency_id'], user_id: data['user_id']);
  }

  static Map<String, dynamic> toMap(UserWalletsModel userWalletsModel) => {
    'id':userWalletsModel.id,
    'wallet':userWalletsModel.wallet,
    'currency_id':userWalletsModel.currency_id,
    'user_id':userWalletsModel.user_id
  };

  static String encode(List<UserWalletsModel> userWalletModel) => jsonEncode(
    userWalletModel
        .map<Map<String, dynamic>>((walletModel) => UserWalletsModel.toMap(walletModel))
        .toList(),
  );

  static List<UserWalletsModel> decode(String userWalletModel) =>
      (jsonDecode(userWalletModel) as List<dynamic>)
          .map<UserWalletsModel>((item) => UserWalletsModel.fromJson(item))
          .toList();
}
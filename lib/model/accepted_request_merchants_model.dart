import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AcceptedRequestMerchantsModel {
  int id;
  String amount;
  int from_user_id;
  int to_user_id;
  int transaction_status_id;
  String slip_no;
  Map from_user;
  AcceptedRequestMerchantsModel(
      {required this.id,
        required this.amount,
        required this.from_user_id,
        required this.to_user_id,
        required this.transaction_status_id,
        required this.slip_no,
        required this.from_user});

  factory AcceptedRequestMerchantsModel.fromJson(Map<String, dynamic> data) {
    return AcceptedRequestMerchantsModel(
        id: data['id'],
        amount: data['amount'],
        from_user_id: data['from_user_id'],
        to_user_id: data['to_user_id'],
        transaction_status_id: data['transaction_status_id'],
        slip_no: data['slip_no'],
        from_user: Provider.of<ApiDataProvider>(Get.context!,listen: false).roleId==5? data['to_user']: data['from_user']);
  }
}

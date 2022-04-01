class MerchantTransactionRequestsModel {
  int id;
  String amount;
  int from_user_id;
  int to_user_id;
  int transaction_status_id;
  String? slip_no;
  Map from_user;
  MerchantTransactionRequestsModel(
      {required this.id,
      required this.amount,
      required this.from_user_id,
      required this.to_user_id,
      required this.transaction_status_id,
      required this.slip_no,
      required this.from_user});

  factory MerchantTransactionRequestsModel.fromJson(Map<String, dynamic> data) {
    return MerchantTransactionRequestsModel(
        id: data['id'],
        amount: data['amount'],
        from_user_id: data['from_user_id'],
        to_user_id: data['to_user_id'],
        transaction_status_id: data['transaction_status_id'],
        slip_no: data['slip_no'],
        from_user: data['from_user']);
  }
}

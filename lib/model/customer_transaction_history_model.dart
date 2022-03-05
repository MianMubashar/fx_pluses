class CustomerTransactionHistoryModel{
  int id;
  String amount;
  int from_user_id;
  int to_user_id;
  int transaction_status_id;
  String slip_no;
  Map transaction_status;

  CustomerTransactionHistoryModel({required this.id,required this.amount,required this.from_user_id,required this.to_user_id,required this.transaction_status_id,required this.slip_no,required this.transaction_status});

  factory CustomerTransactionHistoryModel.fromJson(Map<String,dynamic> data){
    return CustomerTransactionHistoryModel(id: data['id'], amount: data['amount'], from_user_id: data['from_user_id'], to_user_id: data['to_user_id'], transaction_status_id: data['transaction_status_id'], slip_no: data['slip_no'], transaction_status: data['transaction_status']);
  }
}
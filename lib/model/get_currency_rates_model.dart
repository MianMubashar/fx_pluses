class GetCurrencyRatesModel{
  int id;
  int from_currency_id;
  int to_currency_id;
  String exchange_rate;
  int user_id;
  Map from_currency;
  Map to_currency;

  GetCurrencyRatesModel({required this.id,required this.from_currency_id,required this.to_currency_id,required this.exchange_rate,required this.user_id,required this.from_currency,required this.to_currency});
  factory GetCurrencyRatesModel.fromJson(Map<String, dynamic> data){
    return GetCurrencyRatesModel(id: data['id'], from_currency_id: data['from_currency_id'], to_currency_id: data['to_currency_id'], exchange_rate: data['exchange_rate'], user_id: data['user_id'],from_currency: data['from_currency'],to_currency: data['to_currency']);
  }
}
class TopFiveMerchants {
  int user_id;
  int id;
  String exchange_rate;
  Map user;
  Map fromCurrency;
  Map toCurrency;
  TopFiveMerchants(
      {required this.exchange_rate,
      required this.user_id,
      required this.user,
        required this.id,
        required this.fromCurrency,
        required this.toCurrency
      });

  factory TopFiveMerchants.fromJson(Map<String, dynamic> data) {
    return TopFiveMerchants(exchange_rate: data['exchange_rate'], user_id: data['user_id'], user: data['user'],id: data['id'],fromCurrency: data['from_currency'],toCurrency: data['to_currency']);
  }
}

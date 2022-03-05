class TopFiveMerchants {
  int id;
  String first_name;
  String last_name;
  String email;
  String wallet;
  String countryCode;
  TopFiveMerchants(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.wallet,required this.countryCode});

  factory TopFiveMerchants.fromJson(Map<String, dynamic> data) {
    return TopFiveMerchants(
        id: data['id'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
        wallet: data['wallet'], countryCode: data['country_code'],);
  }
}

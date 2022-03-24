class GetCountriesForMerchants {
  int id;
  String country;
  String country_code;
  Map currency;
  GetCountriesForMerchants(
      {required this.id, required this.country, required this.country_code,required this.currency});

  factory GetCountriesForMerchants.fromJson(Map<String, dynamic> data) {
    return GetCountriesForMerchants(
        id: data['id'], country: data['name'], country_code: data['code'],currency: data['currency']);
  }
}

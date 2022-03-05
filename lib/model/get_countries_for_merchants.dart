class GetCountriesForMerchants {
  int id;
  String country;
  String country_code;
  GetCountriesForMerchants(
      {required this.id, required this.country, required this.country_code});

  factory GetCountriesForMerchants.fromJson(Map<String, dynamic> data) {
    return GetCountriesForMerchants(
        id: data['id'], country: data['name'], country_code: data['code']);
  }
}

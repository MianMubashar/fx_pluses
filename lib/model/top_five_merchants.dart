class TopFiveMerchants {
  int id;
  String first_name;
  String last_name;
  String email;
  String profile;
  String countryCode;
  String rating;
  TopFiveMerchants(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.profile,
        required this.countryCode,
        required this.rating});

  factory TopFiveMerchants.fromJson(Map<String, dynamic> data) {
    return TopFiveMerchants(
        id: data['id'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
        profile: data['profile_photo_path'],
      countryCode: data['country_code'],
    rating: data['rating']);
  }
}

class GetCurrenciesModel{
  int id;
  String name;
  String symbol;
  GetCurrenciesModel({required this.id,required this.name,required this.symbol});

  factory GetCurrenciesModel.fromJson(Map<String, dynamic> data){
    return GetCurrenciesModel(id: data['id'], name: data['name'], symbol: data['symbol']);
  }
}
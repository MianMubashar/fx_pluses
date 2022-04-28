class ServiceFeeModel{
  int? id;
  int? min;
  int? max;
  int? charges;
  int? currency_id;
  Map? currency;

  ServiceFeeModel({required this.id, required this.currency_id,required this.charges,required this.max,required this.min,required this.currency});

  factory ServiceFeeModel.fromJson(Map<String, dynamic> data){
    return ServiceFeeModel(id: data['id'], currency_id: data['currency_id'], charges: data['charges'], max: data['max'], min: data['min'],currency: data['currency']);
  }
}
class FaqsModel{
  int id;
  String question;
  String answer;
  String isActive;
  FaqsModel({required this.id,required this.question,required this.answer,required this.isActive});
  factory FaqsModel.fromJson(Map<String, dynamic> data){
    return FaqsModel(id: data['id'], question: data['question'], answer: data['answer'], isActive: data['isActive']);
  }
}
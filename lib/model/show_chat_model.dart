class ShowChatModel{
  int id;
  String? message;
  int sender_id;
  int receiver_id;
  String isAdmin;
  String? file;
  String created_at;
  String updated_at;
  Map receiver;
  Map sender;
  ShowChatModel({required this.id,required this.message,required this.sender_id,required this.receiver_id,required this.isAdmin,
    required this.file,
    required this.created_at,required this.updated_at,required this.receiver,required this.sender});
factory ShowChatModel.fromJson(Map<String , dynamic> data){
  return ShowChatModel(id: data['id'], message: data['message'], sender_id: data['sender_id'], receiver_id: data['receiver_id'], isAdmin: data['isAdmin'],
      file: data['file'],
      created_at: data['created_at'], updated_at: data['updated_at'], receiver: data['receiver'], sender: data['sender']);
}
}
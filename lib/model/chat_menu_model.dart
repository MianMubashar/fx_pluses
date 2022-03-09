class ChatMenuModel{
  int sender_id;
  int receiver_id;
  String? message;
  String? file;
  Map receiver;
  Map sender;
  String? profile_url;
  ChatMenuModel({required this.sender_id,required this.receiver_id,required this.message,required this.receiver,required this.sender,required this.file,required this.profile_url});
  factory ChatMenuModel.fromJson(Map<String,dynamic> data){
    return ChatMenuModel(sender_id: data['sender_id'], receiver_id: data['receiver_id'], message: data['message'], receiver: data['receiver'],sender: data['sender'],file: data['file'],profile_url: data['profile_photo_url']);
  }
}
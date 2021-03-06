class ChatMenuModel{
  int sender_id;
  int receiver_id;
  String? message;
  String? file;
  Map receiver;
  Map sender;
  Map? transaction;
  String? profile_url;
  ChatMenuModel({required this.sender_id,required this.receiver_id,required this.message,required this.receiver,required this.sender,required this.file,required this.profile_url,required this.transaction});
  factory ChatMenuModel.fromJson(Map<String,dynamic> data){
    return ChatMenuModel(sender_id: data['sender_id'], receiver_id: data['receiver_id'], message: data['message'], receiver: data['receiver'],sender: data['sender'],file: data['file'],profile_url: data['profile_photo_url'],transaction: data['transaction'] );
  }
}
class UnreadMsgModel{
  Map? unread_messages;
  UnreadMsgModel({required this.unread_messages});

  factory UnreadMsgModel.fromJson(Map<String, dynamic> data){
    return UnreadMsgModel(unread_messages: data['unread_messages']);
  }
}
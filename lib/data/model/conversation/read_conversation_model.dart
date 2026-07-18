class ReadConversationModel {
  final String conversationId;
  final String user1Id;
  final String user2Id;
  final String recipientName;
  final String recipientAvatar;

  ReadConversationModel({
    required this.conversationId, 
    required this.user1Id, 
    required this.user2Id, 
    required this.recipientName, 
    required this.recipientAvatar});

    factory ReadConversationModel.fromJson(Map<String,dynamic>json){
return ReadConversationModel(
  conversationId:json['conversationId'] as String? ?? '',
  user1Id:json['user1Id']as String? ?? '',
  user2Id:json['user2Id']as String? ?? '',
  recipientName:json['recipientName']as String? ?? '',
  recipientAvatar:json['recipientAvatar']as String? ?? '',

);
    }
}
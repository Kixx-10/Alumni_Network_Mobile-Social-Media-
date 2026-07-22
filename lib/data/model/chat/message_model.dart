class MessageModel {
  final String messageId;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String content;
  final String messageStatus;
  final String? attachmentUrl;
  final DateTime createdDate;

  MessageModel({
    required this.messageId,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.messageStatus,
    this.attachmentUrl,
    required this.createdDate,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      content: json['content'] ?? '',
      messageStatus: json['messageStatus'] ?? 'Sent',
      attachmentUrl: json['attachmentUrl'],
      createdDate: json['createdDate'] != null 
          ? DateTime.parse(json['createdDate']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'messageStatus': messageStatus,
      'attachmentUrl': attachmentUrl,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
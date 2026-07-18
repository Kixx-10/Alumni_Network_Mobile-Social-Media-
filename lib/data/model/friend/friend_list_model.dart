class UserDiscoveryModel {
  final String userId;
  final String name;
  final String avatarUrl;
  UserDiscoveryModel({
    required this.userId,
    required this.name,
    required this.avatarUrl,
  });
  factory UserDiscoveryModel.fromJson(Map<String, dynamic> json) {
    return UserDiscoveryModel(
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }
}
class FriendRequestToMeModel{
final String id;
final String senderId;
final String senderName;
final String senderAvatarUrl;
final String status;

  FriendRequestToMeModel({
    required this.id, 
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.status});
  factory FriendRequestToMeModel.fromJson(Map<String,dynamic>json){
    return FriendRequestToMeModel(
      id: json['id'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      senderAvatarUrl: json['senderAvatarUrl'] as String? ?? '', 
      status: json['status'] as String? ?? '',
      );
  }

}
class SendFriendRequstModel{
  final String receiverId;

  SendFriendRequstModel({required this.receiverId});
  Map<String,dynamic>toJson(){
    return{
      'receiverId':receiverId,
    };
  }
}

class AcceptFriendRequestModel{
  final String requestId;

  AcceptFriendRequestModel(
    {required this.requestId});
    Map<String,dynamic>toJson(){
      return{
        'requstId':requestId,
      };
    }
}
class RejectFriendRequestModel{
  final String requestId;

  RejectFriendRequestModel(
    {required this.requestId});
    Map<String,dynamic>toJson(){
      return{
        'requstId':requestId,
      };
    }
}
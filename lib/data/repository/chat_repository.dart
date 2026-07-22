import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/chat/message_model.dart';
import 'package:alumni_network/data/model/chat/user_status_model.dart';

class ChatRepository {
  final ApiClient _apiClient;
  ChatRepository(this._apiClient);

  Future<List<MessageModel>> getChatHistory(String conversationId, {int limit = 50}) async {
    try {
      final response = await _apiClient.get(
        ApiEndPoints.getChatHistory(conversationId, limit: limit)
      );
      
      if (response.data != null && response.data['isSuccess'] == true) {
        final List list = response.data['data'] ?? [];
        return list.map((json) => MessageModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception("Failed to load chat history: $e");
    }
  }
  Future<bool> markAsRead(String messageId) async {
    try {
      final response = await _apiClient.post(ApiEndPoints.markMessageAsRead(messageId));
      return response.data != null && response.data['isSuccess'] == true;
    } catch (e) {
      return false;
    }
  }

    // receiver ရဲ့ initial online/last-seen status ကို fetch လုပ်ဖို့
  Future<UserStatusModel?> getUserStatus(String userId) async {
    try {
      final response = await _apiClient.get(ApiEndPoints.getUserStatus(userId));

      if (response.data != null) {
        return UserStatusModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
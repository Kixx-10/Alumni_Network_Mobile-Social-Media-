import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/conversation/read_conversation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReadConversationRepository {
  final ApiClient _apiClient;
  ReadConversationRepository(this._apiClient);

  Future<List<ReadConversationModel>> fetchConversations() async {
    try {
      final response = await _apiClient.get(ApiEndPoints.fetchConversation);
      
      if (response.statusCode == 200 && response.data != null) {
       
        final List<dynamic> conversationDataList = response.data['data'] ?? [];
        return conversationDataList
            .map((json) => ReadConversationModel.fromJson(json))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      debugPrint("======== FETCH ALL CONVERSATIONS ERROR ========");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response Data: ${e.response?.data}");
      debugPrint("===============================================");
      throw e.response?.data['message'] ?? "Failed to fetch conversations from server";
    } catch (e) {
      rethrow;
    }
  }
}
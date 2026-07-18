import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SendFriendRequestRepository {
  final ApiClient _apiClient;
  SendFriendRequestRepository(this._apiClient);
  Future<bool>sendFriendRequest(SendFriendRequstModel receiverId)async{
    try{
      final response=await _apiClient.post(ApiEndPoints.sendRequests,data: receiverId.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    }
    on DioException catch (e){
    debugPrint("Response Data: ${e.response?.data}");
    throw e.response?.data?? "Something want wrong";
    }
    catch (e){
      rethrow;
    }
  }
}
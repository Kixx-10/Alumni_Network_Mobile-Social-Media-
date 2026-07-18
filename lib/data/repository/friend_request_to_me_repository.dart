import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FriendRequestToMeRepository {
  final ApiClient _apiClient;
  FriendRequestToMeRepository(this._apiClient);
  Future<List<FriendRequestToMeModel>>getRequestList()async{
    try{
      final response=await _apiClient.get(ApiEndPoints.friendRequestToMe);
      if(response.statusCode==200 && response.data != null){
        final List<dynamic>friendRequestList=response.data['data']??[];
        return friendRequestList.map((json)=>FriendRequestToMeModel.fromJson(json)).toList();
      }
      return [];
    }on DioException catch(e){
      debugPrint("======== FETCH ALL FRIEND REQUEST TO ME ERROR ========");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response Data: ${e.response?.data}");
      throw Exception(e.response?.data?['message'] ?? "Failed to fetch friend requests");
    }
    catch(e){
      rethrow;
    }
  }
}
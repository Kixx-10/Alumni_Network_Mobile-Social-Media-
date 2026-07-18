import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FriendListRepository{
 final ApiClient _apiClient;
  FriendListRepository(this._apiClient);
  Future <List<UserDiscoveryModel>>getAllUser()async{
    try{
      final response=await _apiClient.get(ApiEndPoints.getAllUsers);
    if(response.statusCode == 200 && response.data != null){
      final List<dynamic>userList=response.data['data'] ?? [];
      return userList.map((json)=>UserDiscoveryModel.fromJson(json)).toList();
    }
    return[];
    }on DioException catch (e){
      debugPrint("======== FETCH ALL USERS ERROR ========");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response Data: ${e.response?.data}");
      throw Exception(e.response?.data?['message'] ?? "Failed to fetch users from server");
    }catch(e){
      rethrow;
    }
  }
}
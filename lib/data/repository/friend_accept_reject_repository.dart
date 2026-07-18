import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FriendAcceptRejectRepository {
final ApiClient _apiClient;
  FriendAcceptRejectRepository(this._apiClient);
  //accept
  Future<bool>acceptFriendRequest(AcceptFriendRequestModel model)async{
try{
  final String id=model.requestId;
  final response=await _apiClient.put(ApiEndPoints.acceptFriendRequest(id));
  if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
}on DioException catch(e){
  debugPrint("Response Data: ${e.response?.data}");
    throw e.response?.data?? "Something went wrong";
}
catch (e){
      rethrow;
    }
  }
  //reject
    Future<bool>rejectFriendRequest(RejectFriendRequestModel model)async{
try{
  final String id=model.requestId;
  final response=await _apiClient.put(ApiEndPoints.rejectFriendRequest(id));
  if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
}on DioException catch(e){
  debugPrint("Response Data: ${e.response?.data}");
    throw e.response?.data?? "Something went wrong";
}
catch (e){
      rethrow;
    }
  }
}
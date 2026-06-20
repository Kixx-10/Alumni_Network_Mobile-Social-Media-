// ignore_for_file: file_names
import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/registration/signin_model.dart';
import 'package:alumni_network/data/model/registration/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegistrationRepository {
  final ApiClient _apiClient;
  RegistrationRepository(this._apiClient);
//New Registraiton
Future<Response>signUp(SignUpModel signUpData)async{
  try{
  final response=await _apiClient.post(
    ApiEndPoints.signUp,data: signUpData.toJson());
    return response;
  }on DioException catch (e){
    debugPrint("======== BACKEND RAW ERROR ========");
    debugPrint("Status Code: ${e.response?.statusCode}");
    debugPrint("Response Data: ${e.response?.data}");
    debugPrint("Message: ${e.message}");
    debugPrint("===================================");
    throw e.response?.data['message'] ?? "Something went wrong during sign up";
  }
 catch (e) {
      rethrow;
    }
  }
 Future<Response> signIn(SignInModel signInData) async {
  try {
    final response = await _apiClient.post(
      ApiEndPoints.signIn,
      data: signInData.toJson(),
    );
    return response;
  } on DioException catch (e) {
    debugPrint("======== BACKEND RAW ERROR ========");
    debugPrint("Status Code: ${e.response?.statusCode}");
    debugPrint("Response Data: ${e.response?.data}");
    debugPrint("Message: ${e.message}");
    debugPrint("===================================");
    throw e.response?.data['message'] ?? "Something went wrong during sign in";
  } catch (e) {
    rethrow;
  }
}
}
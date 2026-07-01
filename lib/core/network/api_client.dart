import 'package:alumni_network/core/network/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  
  static const String ipAddress = "192.168.1.6:5143";
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;
 final TokenStorage _tokenStorage = TokenStorage();
  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://$ipAddress/api/",
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:(options ,handler)async{
          final token =await _tokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            debugPrint(" [ApiClient] Unauthorized! Token might be invalid or expired.");
          }
        return handler.next(e);
        },
      )
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException {
      rethrow; 
    }
  }

 
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException {
      rethrow; 
    }
  }
}
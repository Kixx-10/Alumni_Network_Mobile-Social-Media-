import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/token_storage.dart';
import 'package:alumni_network/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  static const String ipAddress = "192.168.1.9:5143";
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  // Global navigator key — no need BuildContext to navigate 
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

 // lib/core/network/api_client.dart
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
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        final token = await TokenStorage().getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          final String path = error.requestOptions.path;
          final bool isAuthEndpoint =
               path.contains(ApiEndPoints.signIn) ||
              path.contains(ApiEndPoints.signUp);

          if (!isAuthEndpoint) {
            debugPrint('[ApiClient] 401 — Token expired. Redirecting to Login...');
            await TokenStorage().deleteToken();
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );

            final context = navigatorKey.currentContext;
            if (context != null) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Session expired. Please login again.'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        }
        handler.next(error);
      },
    ),
  );
}
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
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

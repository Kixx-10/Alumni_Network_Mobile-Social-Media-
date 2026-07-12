import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alumni_network/core/network/token_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final authCheckProvider = FutureProvider<bool>((ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final token = await storage.getToken();

  if (token == null || token.isEmpty) return false;

  if (JwtDecoder.isExpired(token)) {
    await storage.deleteToken(); 
    return false;
  }

  return true;
});

@riverpod
Future<String> currentUserId(Ref ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final token = await storage.getToken();

  if (token == null || token.isEmpty) return '';
  if (JwtDecoder.isExpired(token)) return '';

  final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  final userId = decodedToken['id'] ??
      decodedToken['Id'] ??
      decodedToken['userId'] ??
      decodedToken['UserId'] ??
      decodedToken['nameid'] ??
      decodedToken['sub'] ??
      '';
  return userId.toString();
}

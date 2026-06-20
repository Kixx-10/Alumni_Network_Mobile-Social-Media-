// lib/data/provider/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alumni_network/core/network/token_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

//check there is token or no from flash page
final authCheckProvider = FutureProvider<bool>((ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final token = await storage.getToken();
  return token != null && token.isNotEmpty;
});
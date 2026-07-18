import 'dart:io';
import 'package:alumni_network/core/constants/api_endpoints.dart';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/profile/create_profile_model.dart';
import 'package:dio/dio.dart';

class CreateProfileRepository {
  final ApiClient _apiClient;

  CreateProfileRepository(this._apiClient);

  Future<String?> uploadProfileImage(File imageFile, String jwtToken) async {
    try {
      final formData = FormData();
      formData.files.add(
        MapEntry(
          'files',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        ),
      );

      final response = await _apiClient.dio.post(
        ApiEndPoints.uploadImages,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
      
        final dynamic rawUrls = response.data['mediaUrls'];

        if (rawUrls == null) return null;

        // Case 1: Backend က List<String> ပြန်သည် → first item ယူ
        if (rawUrls is List && rawUrls.isNotEmpty) {
          return rawUrls.first.toString();
        }

        // Case 2: Backend က String တစ်ကြောင်း ပြန်သည်
        if (rawUrls is String && rawUrls.isNotEmpty) {
          return rawUrls;
        }

        return null;
      }
      return null;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Image upload failed';
    } catch (e) {
      rethrow;
    }
  }

  /// Profile Create
  Future<void> createProfile(
      CreateProfileModel profileModel, String jwtToken) async {
    try {
      final response = await _apiClient.dio.post(
        ApiEndPoints.initialprofile,
        data: profileModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Profile creation failed';
    } catch (e) {
      rethrow;
    }
  }
}

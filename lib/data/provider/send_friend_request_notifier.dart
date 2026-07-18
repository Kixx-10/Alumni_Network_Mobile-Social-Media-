import 'dart:async';
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:alumni_network/data/repository/send_friend_request_repository.dart';
import 'package:alumni_network/data/provider/friend_list_notifier.dart'; 
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_friend_request_notifier.g.dart';

@riverpod 
class SendFriendRequestNotifier extends _$SendFriendRequestNotifier {
  late final SendFriendRequestRepository _friendRequestRepository;

  @override 
  FutureOr<void> build()  {
    _friendRequestRepository = SendFriendRequestRepository(ApiClient());
    state= const AsyncData<void>(null);
  }

  Future<void> sendRequests(String receiverId) async {
    state = const AsyncLoading(); 
    state = await AsyncValue.guard(() async {
      final model = SendFriendRequstModel(receiverId: receiverId);
      await _friendRequestRepository.sendFriendRequest(model);
    });

    if (!state.hasError) {
      ref.invalidate(friendListProvider); 
    }
  }
}
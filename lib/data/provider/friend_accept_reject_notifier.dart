import 'dart:async'; 
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:alumni_network/data/provider/friend_list_notifier.dart';
import 'package:alumni_network/data/provider/friend_request_to_me_notifier.dart'; 
import 'package:alumni_network/data/repository/friend_accept_reject_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_accept_reject_notifier.g.dart';

@riverpod
class FriendAcceptRejectNotifier extends _$FriendAcceptRejectNotifier {
  late final FriendAcceptRejectRepository _acceptRejectRepository;

  @override 
  FutureOr<bool> build() {
    _acceptRejectRepository = FriendAcceptRejectRepository(ApiClient());
    return false; 
  }

  Future<void> acceptFriend(String requestId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = AcceptFriendRequestModel(requestId: requestId);
      return await _acceptRejectRepository.acceptFriendRequest(id);
    });

    if (!state.hasError) {
      ref.invalidate(friendListProvider); 
      ref.invalidate(friendRequestToMeProvider); 
    }
  }

  Future<void> rejectFriend(String requestId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final id = RejectFriendRequestModel(requestId: requestId);
      return await _acceptRejectRepository.rejectFriendRequest(id);
    });

    if (!state.hasError) {
      ref.invalidate(friendListProvider); 
      ref.invalidate(friendRequestToMeProvider); 
    }
  }
}
// import 'package:alumni_network/core/network/api_client.dart';
// import 'package:alumni_network/data/model/friend/friend_list_model.dart';
// import 'package:alumni_network/data/repository/friend_request_to_me_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'friend_request_to_me_notifier.g.dart';

// @riverpod
// class FriendRequestToMeNotifier extends _$FriendRequestToMeNotifier {
//   late final FriendRequestToMeRepository _friendRequestToMeRepository;

//   @override
//   FutureOr<List<FriendRequestToMeModel>> build() async {
//     _friendRequestToMeRepository = FriendRequestToMeRepository(ApiClient());
//     return fetchFriendRequests();
//   }

//   Future<List<FriendRequestToMeModel>> fetchFriendRequests() async {
//     return await _friendRequestToMeRepository.getRequestList();
//   }

//   Future<void> refreshRequest() async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() async {
//       return await fetchFriendRequests();
//     });
//   }
// }
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:alumni_network/data/repository/friend_request_to_me_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_request_to_me_notifier.g.dart';

@riverpod
class FriendRequestToMeNotifier extends _$FriendRequestToMeNotifier {
  FriendRequestToMeRepository get _friendRequestToMeRepository =>
      FriendRequestToMeRepository(ApiClient());

  @override
  FutureOr<List<FriendRequestToMeModel>> build() async {
    return await fetchFriendRequests();
  }

  Future<List<FriendRequestToMeModel>> fetchFriendRequests() async {
    return await _friendRequestToMeRepository.getRequestList();
  }

  Future<void> refreshRequest() async {
    ref.invalidateSelf(); 
    await future;         
  }
}
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/friend/friend_list_model.dart';
import 'package:alumni_network/data/repository/friend_list_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_list_notifier.g.dart';
@riverpod
class FriendListNotifier extends _$FriendListNotifier{
late final FriendListRepository _friendListRepository;
@override 
FutureOr<List<UserDiscoveryModel>>build()async{
  _friendListRepository=FriendListRepository(ApiClient());
  return fetchAllUsers();
}
Future<List<UserDiscoveryModel>>fetchAllUsers()async{
  try {
      final allUsers=await _friendListRepository.getAllUser();
      state=AsyncValue.data(allUsers);
      return allUsers;
}catch (e,stackTrace){
  state = AsyncValue.error(e, stackTrace);
  rethrow;
}

}
Future<void> refreshUsers() async {
    await fetchAllUsers();
  }
}
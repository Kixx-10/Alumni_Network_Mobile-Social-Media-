
import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/model/conversation/read_conversation_model.dart';
import 'package:alumni_network/data/repository/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_conversation_notifier.g.dart';

final conversationRepositoryProvider = Provider<ReadConversationRepository>((ref) {
  return ReadConversationRepository(ApiClient());
});

@riverpod
class ReadConversationNotifier extends _$ReadConversationNotifier {
  
  @override
  FutureOr<List<ReadConversationModel>> build() async {
    final repository = ref.watch(conversationRepositoryProvider);
    return await repository.fetchConversations(); 
  }

  // ── Pull to Refresh Function
  Future<void> refreshConversations() async {
    ref.invalidateSelf();
    await future;
  }

  // ── Local State Update Function
  void markAsReadLocally(String conversationId) {
    if (!state.hasValue) return;

    final updatedConversations = state.value!.map((conversation) {
      if (conversation.conversationId == conversationId) {
      }
      return conversation;
    }).toList();
    
    state = AsyncValue.data(updatedConversations);
  }
}
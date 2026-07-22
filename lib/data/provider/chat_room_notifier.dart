import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/core/network/token_storage.dart'; 
import 'package:alumni_network/data/model/chat/message_model.dart';
import 'package:alumni_network/data/model/chat/user_status_model.dart';
import 'package:alumni_network/data/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

part 'chat_room_notifier.g.dart';

final userStatusProvider =
    StateProvider.family<UserStatusModel?, String>((ref, userId) => null);

@riverpod
class ChatRoomNotifier extends _$ChatRoomNotifier {
  HubConnection? _hubConnection; 
  ChatRepository get _chatRepository => ChatRepository(ApiClient());
  String? _receiverId; 

  @override
  FutureOr<List<MessageModel>> build(String conversationId) async {
    ref.onDispose(() {
      _hubConnection?.stop();
    });

    final history = await _chatRepository.getChatHistory(conversationId);
    history.sort((a, b) => b.createdDate.compareTo(a.createdDate));

    await _initSignalR();
    return history;
  }

  Future<void> initReceiverStatus(String receiverId) async {
    _receiverId = receiverId;
    try {
      final status = await _chatRepository.getUserStatus(receiverId);
      if (status != null) {
        ref.read(userStatusProvider(receiverId).notifier).state = status;
      }
    } catch (e) {
      debugPrint("Error fetching initial user status: $e");
    }
  }

  Future<void> _initSignalR() async {
    // IF ALREADY OPEN CONNECTION NO INVOKE
    if (_hubConnection != null && _hubConnection!.state == HubConnectionState.Connected) {
      return;
    }

    final token = await TokenStorage().getToken(); 

    _hubConnection = HubConnectionBuilder()
        .withUrl(
          'https://alumni-network-backend-a8xa.onrender.com/chathub',
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token ?? '',
          ),
        )
        .withAutomaticReconnect()
        .build();

    _hubConnection?.onclose(({error}) => debugPrint("SignalR Connection Closed: $error"));

    _hubConnection?.on("ReceiveMessage", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        final newRawMessage = arguments.first as Map<String, dynamic>;
        final newMessage = MessageModel.fromJson(newRawMessage);

        if (newMessage.conversationId == conversationId) {
          final currentList = state.value ?? [];

          if (currentList.any((m) => m.messageId == newMessage.messageId)) {
            return;
          }

          final updatedList = [newMessage, ...currentList]
            ..sort((a, b) => b.createdDate.compareTo(a.createdDate));

          state = AsyncValue.data(updatedList);
        }
      }
    });

    _hubConnection?.on("UserStatusChanged", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        final data = arguments.first as Map<String, dynamic>;
        final updatedUserId = data['userId']?.toString();

        if (_receiverId != null && updatedUserId == _receiverId) {
          ref.read(userStatusProvider(_receiverId!).notifier).state =
              UserStatusModel.fromJson(data);
        }
      }
    });

    try {
      await _hubConnection?.start();
      debugPrint("SignalR Connected Successfully!");
    } catch (e) {
      debugPrint("SignalR Connection Error: $e");
    }
  }

  Future<void> sendMessage(
    String receiverId, 
    String content,
    String conversationId, 
    String? attachmentUrl) async {

    //  Message မပို့မီ SignalR Connection အခြေအနေကို စစ်ဆေးပြီး ပြတ်နေပါက Auto-Reconnect လုပ်ပေးခြင်း
    if (_hubConnection == null || _hubConnection!.state != HubConnectionState.Connected) {
      debugPrint("SignalR is disconnected (${_hubConnection?.state}). Reconnecting...");
      try {
        await _initSignalR();
      } catch (e) {
        debugPrint("Failed to reconnect SignalR: $e");
        return;
      }
    }

    //  Message Send Request ပို့ခြင်း
    try {
      await _hubConnection!.invoke("SendMessage", args: [
        receiverId,
        content,
        conversationId,
        attachmentUrl ?? '',
      ]);
      debugPrint("Message invocation sent successfully.");
    } catch (e) {
      debugPrint("Error sending message via SignalR: $e");
    }
  }
}
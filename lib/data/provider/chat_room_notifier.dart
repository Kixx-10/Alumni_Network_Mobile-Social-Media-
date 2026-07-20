
// import 'package:alumni_network/core/network/api_client.dart';
// import 'package:alumni_network/core/network/token_storage.dart'; 
// import 'package:alumni_network/data/model/chat/message_model.dart';
// import 'package:alumni_network/data/repository/chat_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:signalr_netcore/http_connection_options.dart';
// import 'package:signalr_netcore/hub_connection.dart';
// import 'package:signalr_netcore/hub_connection_builder.dart';

// part 'chat_room_notifier.g.dart';

// @riverpod
// class ChatRoomNotifier extends _$ChatRoomNotifier {
//   HubConnection? _hubConnection; 
//   ChatRepository get _chatRepository => ChatRepository(ApiClient());

//   @override
//   FutureOr<List<MessageModel>> build(String conversationId) async {
//     ref.onDispose(() {
//       _hubConnection?.stop();
//     });

//     final history = await _chatRepository.getChatHistory(conversationId);

//     history.sort((a, b) => b.createdDate.compareTo(a.createdDate));

//     await _initSignalR();
//     return history;
//   }

//   Future<void> _initSignalR() async {
//     final token = await TokenStorage().getToken(); 

//     _hubConnection = HubConnectionBuilder()
//         .withUrl(
//           'http://${ApiClient.ipAddress}/chathub',
//           options: HttpConnectionOptions(
//             accessTokenFactory: () async => token ?? '',
//           ),
//         )
//         .withAutomaticReconnect()
//         .build();

//     _hubConnection?.onclose(({error}) => debugPrint("SignalR Connection Closed: $error"));

//     _hubConnection?.on("ReceiveMessage", (arguments) {
//       if (arguments != null && arguments.isNotEmpty) {
//         final newRawMessage = arguments.first as Map<String, dynamic>;
//         final newMessage = MessageModel.fromJson(newRawMessage);

//         if (newMessage.conversationId == conversationId) {
//           final currentList = state.value ?? [];

//           //  Duplicate check - Caller + Receiver ၂ ဖက်စလုံးက event ရနိုင်လို့
//           if (currentList.any((m) => m.messageId == newMessage.messageId)) {
//             return;
//           }

//           //  Insert ပြီးတိုင်း createdDate နဲ့ sort ပြန်လုပ် - network arrival order 
//           // မဟုတ်ဘဲ real timestamp order ဖြစ်အောင်
//           final updatedList = [newMessage, ...currentList]
//             ..sort((a, b) => b.createdDate.compareTo(a.createdDate));

//           state = AsyncValue.data(updatedList);
//         }
//       }
//     });

//     try {
//       await _hubConnection?.start();
//      debugPrint(" SignalR Connected Successfully!");
//     } catch (e) {
//      debugPrint(" SignalR Connection Error: $e");
//     }
//   }

//   Future<void> sendMessage(
//     String receiverId, 
//     String content,
//     String conversationId, 
//     String? attachmentUrl) async {
//     if (_hubConnection == null || _hubConnection!.state != HubConnectionState.Connected) {
//       debugPrint("SignalR is not connected.");
//       return;
//     }

//     try {
//       await _hubConnection!.invoke("SendMessage", args: [
//         receiverId,
//         content,
//         conversationId,
//         attachmentUrl ?? '',
//       ]);
//     } catch (e) {
//       debugPrint("Error sending message via SignalR: $e");
//     }
//   }
// }

import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/core/network/token_storage.dart'; 
import 'package:alumni_network/data/model/chat/message_model.dart';
import 'package:alumni_network/data/model/chat/user_status_model.dart';
import 'package:alumni_network/data/repository/chat_repository.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

part 'chat_room_notifier.g.dart';

// 💡 receiver status ကို message list state နဲ့ ခွဲထားတဲ့ provider
// (update frequency မတူတာမို့ - status က message ထက် ခဏခဏ ပြောင်းနိုင်လို့)
final userStatusProvider =
    StateProvider.family<UserStatusModel?, String>((ref, userId) => null);

@riverpod
class ChatRoomNotifier extends _$ChatRoomNotifier {
  HubConnection? _hubConnection; 
  ChatRepository get _chatRepository => ChatRepository(ApiClient());
  String? _receiverId; // 💡 UserStatusChanged event ကို filter လုပ်ဖို့ သိမ်းထား

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

    // 💡 online/offline status listener - backend ChatHub က broadcast လုပ်တဲ့ event
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
    if (_hubConnection == null || _hubConnection!.state != HubConnectionState.Connected) {
      debugPrint("SignalR is not connected.");
      return;
    }

    try {
      await _hubConnection!.invoke("SendMessage", args: [
        receiverId,
        content,
        conversationId,
        attachmentUrl ?? '',
      ]);
    } catch (e) {
      debugPrint("Error sending message via SignalR: $e");
    }
  }
}
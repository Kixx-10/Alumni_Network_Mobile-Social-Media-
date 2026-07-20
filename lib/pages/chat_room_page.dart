// // lib/pages/chat_room_page.dart
// import 'package:alumni_network/data/provider/chat_room_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ChatRoomPage extends ConsumerStatefulWidget {
//   final String userName;
//   final String userAvatar;
//   final String conversationId;
//   final String receiverId;
//   const ChatRoomPage({
//     super.key,
//     required this.userName,
//     required this.userAvatar,
//     required this.conversationId,
//     required this.receiverId,
//   });

//   @override
//   ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
// }

// class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
//   final TextEditingController _messageController = TextEditingController();

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     ref
//         .read(chatRoomProvider(widget.conversationId).notifier)
//         .sendMessage(widget.receiverId, text, widget.conversationId, null);

//     _messageController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatState = ref.watch(chatRoomProvider(widget.conversationId));
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       // ─── AppBar containing the Back Button ───
//       appBar: AppBar(
//         elevation: 0.5,
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 18.r,
//               backgroundImage: NetworkImage(widget.userAvatar),
//             ),
//             SizedBox(width: 10.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.userName,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Active now",
//                   style: TextStyle(fontSize: 12.sp, color: Colors.green),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),

//       body: GestureDetector(
//         onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Chat history list
//               Expanded(
//                 child: chatState.when(
//                   data: (messages) {
//                     if (messages.isEmpty) {
//                       return const Center(
//                         child: Text("No messages yet. Say hi!"),
//                       );
//                     }
//                     return ListView.builder(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 14.w,
//                         vertical: 10.h,
//                       ),
//                       reverse:
//                           true, //  အောက်ခြေကနေ စာစီဖို့အတွက် 
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         final message = messages[index];
        
//                         final isMe = message.receiverId == widget.receiverId;
        
//                         return _buildMessageBubble(message.content, isMe);
//                       },
//                     );
//                   },
//                   error: (error, stack) => Center(
//                     child: Text(
//                       "Error loading chat: $error",
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                   loading: () => const Center(child: CircularProgressIndicator()),
//                 ),
//               ),
//               _buildChatInput(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageBubble(String text, bool isMe) {
//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Flexible(
//           child: Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.75,
//             ),
//             margin: EdgeInsets.symmetric(vertical: 4.h),
//             padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//             decoration: BoxDecoration(
//               color: isMe ? Colors.blueAccent : Colors.grey[200],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16.r),
//                 topRight: Radius.circular(16.r),
//                 bottomLeft: Radius.circular(isMe ? 16.r : 0),
//                 bottomRight: Radius.circular(isMe ? 0 : 16.r),
//               ),
//             ),
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: isMe ? Colors.white : Colors.black87,
//                 fontSize: 15.sp,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildChatInput() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         border: Border(
//           top: BorderSide(color: Colors.grey.shade300, width: 0.5),
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 14.w),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(24.r),
//               ),
//               child: TextField(
//                 controller: _messageController,
//                 maxLines: null, // allow large messages
//                 keyboardType: TextInputType.multiline,
//                 style: const TextStyle(color: Colors.black87),
//                 decoration: const InputDecoration(
//                   hintText: "Type a message...",
//                   hintStyle: TextStyle(color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 8.w),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 4.0),
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.blueAccent),
//               onPressed: _sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/pages/chat_room_page.dart
import 'package:alumni_network/data/model/chat/user_status_model.dart';
import 'package:alumni_network/data/provider/chat_room_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatRoomPage extends ConsumerStatefulWidget {
  final String userName;
  final String userAvatar;
  final String conversationId;
  final String receiverId;
  const ChatRoomPage({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.conversationId,
    required this.receiverId,
  });

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 💡 page ဖွင့်လိုက်တာနဲ့ receiver ရဲ့ initial status ကို fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(chatRoomProvider(widget.conversationId).notifier)
          .initReceiverStatus(widget.receiverId);
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    ref
        .read(chatRoomProvider(widget.conversationId).notifier)
        .sendMessage(widget.receiverId, text, widget.conversationId, null);

    _messageController.clear();
  }

  String _formatStatusText(UserStatusModel? status) {
    if (status == null) return "";
    if (status.isOnline) return "Active now";
    if (status.lastSeen != null) {
      return "Last seen ${timeago.format(status.lastSeen!)}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatRoomProvider(widget.conversationId));
    final userStatus = ref.watch(userStatusProvider(widget.receiverId));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: NetworkImage(widget.userAvatar),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                // 💡 hardcode "Active now" အစား dynamic status
                Text(
                  _formatStatusText(userStatus),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: userStatus?.isOnline == true ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: chatState.when(
                  data: (messages) {
                    if (messages.isEmpty) {
                      return const Center(child: Text("No messages yet. Say hi!"));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.receiverId == widget.receiverId;
                        return _buildMessageBubble(message.content, isMe);
                      },
                    );
                  },
                  error: (error, stack) => Center(
                    child: Text(
                      "Error loading chat: $error",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
              ),
              _buildChatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isMe ? Colors.blueAccent : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(isMe ? 16.r : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16.r),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.blueAccent),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

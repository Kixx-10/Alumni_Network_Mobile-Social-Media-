//import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/provider/auth_provider.dart';
import 'package:alumni_network/data/provider/read_conversation_notifier.dart';
import 'package:alumni_network/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTab extends ConsumerStatefulWidget {
  const ChatTab({super.key});

  @override
  ConsumerState<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends ConsumerState<ChatTab> {

 String _resolveAvatarUrl(String? rawUrl) {
  if (rawUrl == null || rawUrl.trim().isEmpty) return '';
  if (rawUrl.startsWith('http')) return rawUrl;
  
  // Render Cloud Server Domain
  const String originUrl = 'https://alumni-network-backend-a8xa.onrender.com';
  final String path = rawUrl.startsWith('/') ? rawUrl : '/$rawUrl';
  return '$originUrl$path';
}

  @override
  Widget build(BuildContext context) {
    final conversationState = ref.watch(readConversationProvider);
    final currentUserIdState = ref.watch(currentUserIdProvider);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              ref
                  .read(readConversationProvider.notifier)
                  .refreshConversations(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  conversationState.when(
                    data: (conversations) {
                      if (conversations.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("No conversation found! "),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          final recipient = conversations[index];
                          final recipietImage = _resolveAvatarUrl(
                            recipient.recipientAvatar,
                          );
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: InkWell(
                              onTap: () {
                               currentUserIdState.whenData((myId) {
                                // user1Id က မိမိ ID ဖြစ်နေရင် user2Id က တစ်ဖက်လူ၊ မဟုတ်ရင် user1Id က တစ်ဖက်လူ
                                final String targetReceiverId = (recipient.user1Id == myId)
                                    ? recipient.user2Id
                                    : recipient.user1Id;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatRoomPage(
                                      userName: recipient.recipientName,
                                      userAvatar: recipietImage,
                                      conversationId: recipient.conversationId,
                                      receiverId: targetReceiverId, 
                                    ),
                                  ),
                                );
                              });
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.r,
                                    backgroundImage: recipietImage.isNotEmpty
                                        ? NetworkImage(recipietImage)
                                        : const AssetImage(
                                                'assets/images/profile.jpg',
                                              )
                                              as ImageProvider,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      recipient.recipientName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (err, stack) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Failed to load conversations: $err",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

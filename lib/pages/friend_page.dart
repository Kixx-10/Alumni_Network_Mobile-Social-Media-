import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/provider/friend_list_notifier.dart';
import 'package:alumni_network/data/provider/friend_request_to_me_notifier.dart';
import 'package:alumni_network/data/provider/send_friend_request_notifier.dart';
import 'package:alumni_network/widgets/freind_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendTab extends ConsumerStatefulWidget {
  const FriendTab({super.key});

  @override
  ConsumerState<FriendTab> createState() => _FriendTabState();
}

class _FriendTabState extends ConsumerState<FriendTab> {
  String _resolveAvatarUrl(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return '';
    if (rawUrl.startsWith('http')) return rawUrl;
    final String baseUrl = 'http://${ApiClient.ipAddress}';
    return '$baseUrl$rawUrl';
  }
void _btnSendRequest(String receiverId) {
  ref.read(sendFriendRequestProvider.notifier).sendRequests(receiverId);
}

  @override
  Widget build(BuildContext context) {
    final asyncUsers = ref.watch(friendListProvider);
    final asyncRequests = ref.watch(friendRequestToMeProvider);
ref.listen(sendFriendRequestProvider, (previous, next) {
  if (next.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(next.error.toString())),
    );
  } 
  if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Friend request sent successfully!")),
    );
  }
});
    final int requestCount = asyncRequests.maybeWhen(
      data: (requests) => requests.length,
      orElse: () => 0,
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              ref.read(friendListProvider.notifier).refreshUsers(),
              ref.read(friendRequestToMeProvider.notifier).refreshRequest(),
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
                  Row(
                    children: [
                      Text(
                        "Friend Requests",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "$requestCount",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  asyncRequests.when(
                    data: (requests) {
                      if (requests.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Not Found Requests to you "),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final eachRequest = requests[index];
                          final resolveUrl = _resolveAvatarUrl(
                            eachRequest.senderAvatarUrl,
                          );
                          return FriendUserCard(
                            name: eachRequest.senderName,
                            imagePath: resolveUrl,
                            primaryBtnText: "Confirm",
                            secondaryBtnText: "Delete",
                            onPrimaryPressed: () {
                              debugPrint("Confirm Pressed for index $index");
                            },
                            onSecondaryPressed: () {
                              debugPrint("Delete Pressed for index $index");
                            },
                          );
                        },
                      );
                    },
                    error: (err, stack) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Failed to load requests: $err",
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

                  const Divider(height: 40, thickness: 1, color: Colors.grey),

                  Text(
                    "People you may know",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  asyncUsers.when(
                    data: (users) {
                      if (users.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("No suggestions right now."),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final String resolvedUrl = _resolveAvatarUrl(
                            user.avatarUrl,
                          );

                          return FriendUserCard(
                            name: user.name,
                            imagePath: resolvedUrl,
                            primaryBtnText: "Add Friend",
                            secondaryBtnText: "Remove",
                            onPrimaryPressed: () =>
                                _btnSendRequest(user.userId),
                            onSecondaryPressed: () {
                              debugPrint("Remove Pressed for ${user.userId}");
                            },
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, stack) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Failed to load users: $err",
                        style: const TextStyle(color: Colors.red),
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

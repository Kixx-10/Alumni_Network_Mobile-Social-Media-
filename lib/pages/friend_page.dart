import 'package:alumni_network/core/network/api_client.dart';
import 'package:alumni_network/data/provider/friend_list_notifier.dart';
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
  final int _currentCount = 5;
String _resolveAvatarUrl(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return '';
    if (rawUrl.startsWith('http')) return rawUrl;
    final String baseUrl = 'http://${ApiClient.ipAddress}';
    return '$baseUrl$rawUrl';
  }
  @override
  Widget build(BuildContext context) {
    final asyncUsers = ref.watch(friendListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(friendListProvider.notifier).refreshUsers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Friend Request (unchanged, static for now)
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
                        "$_currentCount",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return FriendUserCard(
                        name: "Aung Thu Hein",
                        imagePath: 'assets/images/profile.jpg',
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
                  ),

                  const Divider(height: 40, thickness: 1, color: Colors.grey),

                  // People you may know — now backed by FriendListNotifier
                  Text(
                    "People you may know",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                          final String resolvedUrl = _resolveAvatarUrl(user.avatarUrl);
                          return FriendUserCard(
                            name: user.name,
                            imagePath: resolvedUrl,
                            primaryBtnText: "Add Friend",
                            secondaryBtnText: "Remove",
                            onPrimaryPressed: () {
                              debugPrint("Add Friend Pressed for ${user.userId}");
                            },
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
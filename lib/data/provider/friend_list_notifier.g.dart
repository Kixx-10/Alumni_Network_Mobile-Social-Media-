// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FriendListNotifier)
final friendListProvider = FriendListNotifierProvider._();

final class FriendListNotifierProvider
    extends
        $AsyncNotifierProvider<FriendListNotifier, List<UserDiscoveryModel>> {
  FriendListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendListNotifierHash();

  @$internal
  @override
  FriendListNotifier create() => FriendListNotifier();
}

String _$friendListNotifierHash() =>
    r'b37ee5a783e42337bd8b6c2e9e66427c24d9a792';

abstract class _$FriendListNotifier
    extends $AsyncNotifier<List<UserDiscoveryModel>> {
  FutureOr<List<UserDiscoveryModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<UserDiscoveryModel>>,
              List<UserDiscoveryModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserDiscoveryModel>>,
                List<UserDiscoveryModel>
              >,
              AsyncValue<List<UserDiscoveryModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

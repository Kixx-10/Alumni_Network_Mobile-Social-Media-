// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_to_me_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FriendRequestToMeNotifier)
final friendRequestToMeProvider = FriendRequestToMeNotifierProvider._();

final class FriendRequestToMeNotifierProvider
    extends
        $AsyncNotifierProvider<
          FriendRequestToMeNotifier,
          List<FriendRequestToMeModel>
        > {
  FriendRequestToMeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendRequestToMeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendRequestToMeNotifierHash();

  @$internal
  @override
  FriendRequestToMeNotifier create() => FriendRequestToMeNotifier();
}

String _$friendRequestToMeNotifierHash() =>
    r'73333f4135e52fadf489d0347895a6ac2a335073';

abstract class _$FriendRequestToMeNotifier
    extends $AsyncNotifier<List<FriendRequestToMeModel>> {
  FutureOr<List<FriendRequestToMeModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<FriendRequestToMeModel>>,
              List<FriendRequestToMeModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FriendRequestToMeModel>>,
                List<FriendRequestToMeModel>
              >,
              AsyncValue<List<FriendRequestToMeModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

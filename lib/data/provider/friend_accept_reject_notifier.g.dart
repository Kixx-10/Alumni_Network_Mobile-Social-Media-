// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_accept_reject_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FriendAcceptRejectNotifier)
final friendAcceptRejectProvider = FriendAcceptRejectNotifierProvider._();

final class FriendAcceptRejectNotifierProvider
    extends $AsyncNotifierProvider<FriendAcceptRejectNotifier, bool> {
  FriendAcceptRejectNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendAcceptRejectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendAcceptRejectNotifierHash();

  @$internal
  @override
  FriendAcceptRejectNotifier create() => FriendAcceptRejectNotifier();
}

String _$friendAcceptRejectNotifierHash() =>
    r'3368f25e224fd5672cc02e42381209a8e5c69afb';

abstract class _$FriendAcceptRejectNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

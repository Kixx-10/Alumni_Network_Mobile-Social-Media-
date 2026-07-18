// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_friend_request_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SendFriendRequestNotifier)
final sendFriendRequestProvider = SendFriendRequestNotifierProvider._();

final class SendFriendRequestNotifierProvider
    extends $AsyncNotifierProvider<SendFriendRequestNotifier, void> {
  SendFriendRequestNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendFriendRequestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendFriendRequestNotifierHash();

  @$internal
  @override
  SendFriendRequestNotifier create() => SendFriendRequestNotifier();
}

String _$sendFriendRequestNotifierHash() =>
    r'e4c32ed9d6c5a7eae6663f2456112039e08e8835';

abstract class _$SendFriendRequestNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

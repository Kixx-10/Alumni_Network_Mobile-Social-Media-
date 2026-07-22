// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatRoomNotifier)
final chatRoomProvider = ChatRoomNotifierFamily._();

final class ChatRoomNotifierProvider
    extends $AsyncNotifierProvider<ChatRoomNotifier, List<MessageModel>> {
  ChatRoomNotifierProvider._({
    required ChatRoomNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatRoomProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatRoomNotifierHash();

  @override
  String toString() {
    return r'chatRoomProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatRoomNotifier create() => ChatRoomNotifier();

  @override
  bool operator ==(Object other) {
    return other is ChatRoomNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatRoomNotifierHash() => r'3e714035c342b7aa5d2c14126333a630118094b2';

final class ChatRoomNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatRoomNotifier,
          AsyncValue<List<MessageModel>>,
          List<MessageModel>,
          FutureOr<List<MessageModel>>,
          String
        > {
  ChatRoomNotifierFamily._()
    : super(
        retry: null,
        name: r'chatRoomProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatRoomNotifierProvider call(String conversationId) =>
      ChatRoomNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'chatRoomProvider';
}

abstract class _$ChatRoomNotifier extends $AsyncNotifier<List<MessageModel>> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<List<MessageModel>> build(String conversationId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MessageModel>>, List<MessageModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MessageModel>>, List<MessageModel>>,
              AsyncValue<List<MessageModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

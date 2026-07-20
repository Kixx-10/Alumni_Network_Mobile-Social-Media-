// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_conversation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReadConversationNotifier)
final readConversationProvider = ReadConversationNotifierProvider._();

final class ReadConversationNotifierProvider
    extends
        $AsyncNotifierProvider<
          ReadConversationNotifier,
          List<ReadConversationModel>
        > {
  ReadConversationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readConversationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readConversationNotifierHash();

  @$internal
  @override
  ReadConversationNotifier create() => ReadConversationNotifier();
}

String _$readConversationNotifierHash() =>
    r'0bbdd83220e8d8d49966d1f754581958b69928de';

abstract class _$ReadConversationNotifier
    extends $AsyncNotifier<List<ReadConversationModel>> {
  FutureOr<List<ReadConversationModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ReadConversationModel>>,
              List<ReadConversationModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ReadConversationModel>>,
                List<ReadConversationModel>
              >,
              AsyncValue<List<ReadConversationModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

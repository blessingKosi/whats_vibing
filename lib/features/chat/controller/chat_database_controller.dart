// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_vibing/features/chat/repositories/chat_database_repository.dart';
import 'package:whats_vibing/common/entity/group.dart';
import 'package:whats_vibing/common/entity/chat_contact.dart';

import '../../../common/entity/message.dart';

final localChatControllerProvider = Provider((ref) {
  final localChatRepository = ref.watch(localChatRepositoryProvider);
  return ChatController(
    localChatRepository: localChatRepository,
    ref: ref,
  );
});

class ChatController {
  final LocalChatRepository localChatRepository;
  final ProviderRef ref;
  ChatController({
    required this.localChatRepository,
    required this.ref,
  });

  Future<List<GroupEntity>> fetchLocalChatGroups() {
    return localChatRepository.getLocalChatGroups();
  }

  Future<List<ChatContact>> fetchLocalchatContacts() {
    return localChatRepository.getLocalChatContacts();
  }

  Future<List<Message>> localChat(String recieverUserId) {
    return localChatRepository.getLocalChats(recieverUserId);
  }

  Future<List<Message>> localGroupChat(String groupId) {
    return localChatRepository.getLocalGroupChats(groupId);
  }

  // void sendTextMessage(
  //   BuildContext context,
  //   String text,
  //   String recieverUserId,
  //   bool isGroupChat,
  // ) {
  //   final messageReply = ref.read(messageReplyProvider);
  //   ref.read(userDataAuthProvider).whenData(
  //         (value) => chatRepository.sendTextMessage(
  //           context: context,
  //           text: text,
  //           recieverUserId: recieverUserId,
  //           senderUser: value!,
  //           messageReply: messageReply,
  //           isGroupChat: isGroupChat,
  //         ),
  //       );
  //   ref.read(messageReplyProvider.state).update((state) => null);
  // }

  // void sendFileMessage(
  //   BuildContext context,
  //   File file,
  //   String recieverUserId,
  //   MessageEnum messageEnum,
  //   bool isGroupChat,
  // ) {
  //   final messageReply = ref.read(messageReplyProvider);
  //   ref.read(userDataAuthProvider).whenData(
  //         (value) => chatRepository.sendFileMessage(
  //           context: context,
  //           file: file,
  //           recieverUserId: recieverUserId,
  //           senderUserData: value!,
  //           messageEnum: messageEnum,
  //           ref: ref,
  //           messageReply: messageReply,
  //           isGroupChat: isGroupChat,
  //         ),
  //       );
  //   ref.read(messageReplyProvider.state).update((state) => null);
  // }

  // void sendGIFMessage(
  //   BuildContext context,
  //   String gifUrl,
  //   String recieverUserId,
  //   bool isGroupChat,
  // ) {
  //   final messageReply = ref.read(messageReplyProvider);
  //   int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
  //   String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
  //   String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

  //   ref.read(userDataAuthProvider).whenData(
  //         (value) => chatRepository.sendGIFMessage(
  //           context: context,
  //           gifUrl: newgifUrl,
  //           recieverUserId: recieverUserId,
  //           senderUser: value!,
  //           messageReply: messageReply,
  //           isGroupChat: isGroupChat,
  //         ),
  //       );
  //   ref.read(messageReplyProvider.state).update((state) => null);
  // }

  // void setChatMessageSeen(
  //   BuildContext context,
  //   String recieverUserId,
  //   String messageId,
  // ) {
  //   chatRepository.setChatMessageSeen(
  //     context,
  //     recieverUserId,
  //     messageId,
  //   );
  // }
}

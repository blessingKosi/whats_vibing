// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_vibing/common/database/database.dart';
import 'package:whats_vibing/common/entity/chat_contact.dart';
import 'package:whats_vibing/common/entity/group.dart';
import 'package:whats_vibing/common/entity/message.dart';

final localChatRepositoryProvider = Provider(
  (ref) => LocalChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class LocalChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  LocalChatRepository({
    required this.firestore,
    required this.auth,
  });

  Future<List<ChatContact>> getLocalChatContacts() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final chatContactDao = database.chatContactDao;

    final chatContactEntities = await chatContactDao.getAllChatContacts();
    final localChatContacts = chatContactEntities.map((entity) {
      return ChatContact(
        name: entity.name,
        profilePic: entity.profilePic,
        contactId: entity.contactId,
        timeSent: entity.timeSent,
        lastMessage: entity.lastMessage,
      );
    }).toList();

    return localChatContacts;
  }

  // Future<List<Group>> getLocalChatGroups() async {
  //   final database =
  //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //   final groupDao = database.groupDao;

  //   final groupEntities = await groupDao.getAllGroups();
  //   final localGroups = groupEntities
  //       .map((entity) => Group(
  //             senderId: entity.senderId,
  //             groupId: entity.groupId,
  //             name: entity.name,
  //             lastMessage: entity.lastMessage,
  //             groupPic: entity.groupPic,
  //             membersUid: entity.membersUid,
  //             timeSent: entity.timeSent,
  //           ))
  //       .toList();

  //   return localGroups;
  // }

  Future<List<GroupEntity>> getLocalChatGroups() async {
    try {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final groupDao = database.groupDao;

      final groupEntities = await groupDao.getAllGroups();
      final localGroups = groupEntities.map((entity) {
        return GroupEntity(
          senderId: entity.senderId,
          groupId: entity.groupId,
          name: entity.name,
          lastMessage: entity.lastMessage,
          groupPic: entity.groupPic,
          membersUid: entity.membersUid,
          timeSent: entity.timeSent,
        );
      }).toList();

      return localGroups;
    } catch (error) {
      print('ERROR GETTING LOCASL CHAT GROUPS: $error');
      return []; // Return an empty list or handle the error as needed
    }
  }

  // Future<List<Message>> getLocalChat(
  //     String receiverUserId, AppDatabase database) async {
  //   try {
  //     final messageDao = database.messageDao;
  //     final localMessages =
  //         await messageDao.getMessagesByReceiverId(receiverUserId);
  //     return localMessages;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  Future<List<Message>> getLocalChats(String receiverUserId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final messageDao = database.messageDao;
    final localMessages =
        await messageDao.getMessagesByReceiverId(receiverUserId);
    return localMessages;
  }

  Future<List<Message>> getLocalGroupChats(String groupId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final messageDao = database.messageDao;
    final localMessages = await messageDao.getMessagesByGroupId(groupId);
    return localMessages;
  }

//   void _saveDataToContactsSubcollection(
//     UserModel senderUserData,
//     UserModel? recieverUserData,
//     String text,
//     DateTime timeSent,
//     String recieverUserId,
//     bool isGroupChat,
//   ) async {
//     if (isGroupChat) {
//       await firestore.collection('groups').doc(recieverUserId).update({
//         'lastMessage': text,
//         'timeSent': DateTime.now().millisecondsSinceEpoch,
//       });
//     } else {
// // users -> reciever user id => chats -> current user id -> set data
//       var recieverChatContact = ChatContact(
//         name: senderUserData.name,
//         profilePic: senderUserData.profilePic,
//         contactId: senderUserData.uid,
//         timeSent: timeSent,
//         lastMessage: text,
//       );
//       await firestore
//           .collection('users')
//           .doc(recieverUserId)
//           .collection('chats')
//           .doc(auth.currentUser!.uid)
//           .set(
//             recieverChatContact.toJson(),
//           );
//       // users -> current user id  => chats -> reciever user id -> set data
//       var senderChatContact = ChatContact(
//         name: recieverUserData!.name,
//         profilePic: recieverUserData.profilePic,
//         contactId: recieverUserData.uid,
//         timeSent: timeSent,
//         lastMessage: text,
//       );
//       await firestore
//           .collection('users')
//           .doc(auth.currentUser!.uid)
//           .collection('chats')
//           .doc(recieverUserId)
//           .set(
//             senderChatContact.toJson(),
//           );
//     }
//   }

  // void _saveMessageToMessageSubcollection({
  //   required String recieverUserId,
  //   required String text,
  //   required DateTime timeSent,
  //   required String messageId,
  //   required String username,
  //   required MessageEnum messageType,
  //   required MessageReply? messageReply,
  //   required String senderUsername,
  //   required String? recieverUserName,
  //   required bool isGroupChat,
  // }) async {
  //   final message = Message(
  //     senderId: auth.currentUser!.uid,
  //     recieverid: recieverUserId,
  //     text: text,
  //     type: messageType,
  //     timeSent: timeSent,
  //     messageId: messageId,
  //     isSeen: false,
  //     repliedMessage: messageReply == null ? '' : messageReply.message,
  //     repliedTo: messageReply == null
  //         ? ''
  //         : messageReply.isMe
  //             ? senderUsername
  //             : recieverUserName ?? '',
  //     repliedMessageType:
  //         messageReply == null ? MessageEnum.text : messageReply.messageEnum,
  //   );
  //   if (isGroupChat) {
  //     // groups -> group id -> chat -> message
  //     await firestore
  //         .collection('groups')
  //         .doc(recieverUserId)
  //         .collection('chats')
  //         .doc(messageId)
  //         .set(
  //           message.toMap(),
  //         );
  //   } else {
  //     // users -> sender id -> reciever id -> messages -> message id -> store message
  //     await firestore
  //         .collection('users')
  //         .doc(auth.currentUser!.uid)
  //         .collection('chats')
  //         .doc(recieverUserId)
  //         .collection('messages')
  //         .doc(messageId)
  //         .set(
  //           message.toMap(),
  //         );
  //     // users -> eciever id  -> sender id -> messages -> message id -> store message
  //     await firestore
  //         .collection('users')
  //         .doc(recieverUserId)
  //         .collection('chats')
  //         .doc(auth.currentUser!.uid)
  //         .collection('messages')
  //         .doc(messageId)
  //         .set(
  //           message.toMap(),
  //         );
  //   }
  // }

  // void sendTextMessage({
  //   required BuildContext context,
  //   required String text,
  //   required String recieverUserId,
  //   required UserModel senderUser,
  //   required MessageReply? messageReply,
  //   required bool isGroupChat,
  // }) async {
  //   try {
  //     var timeSent = DateTime.now();
  //     UserModel? recieverUserData;

  //     if (!isGroupChat) {
  //       var userDataMap =
  //           await firestore.collection('users').doc(recieverUserId).get();
  //       recieverUserData = UserModel.fromMap(userDataMap.data()!);
  //     }

  //     var messageId = const Uuid().v1();

  //     _saveDataToContactsSubcollection(
  //       senderUser,
  //       recieverUserData,
  //       text,
  //       timeSent,
  //       recieverUserId,
  //       isGroupChat,
  //     );

  //     _saveMessageToMessageSubcollection(
  //       recieverUserId: recieverUserId,
  //       text: text,
  //       timeSent: timeSent,
  //       messageType: MessageEnum.text,
  //       messageId: messageId,
  //       username: senderUser.name,
  //       messageReply: messageReply,
  //       recieverUserName: recieverUserData?.name,
  //       senderUsername: senderUser.name,
  //       isGroupChat: isGroupChat,
  //     );
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }

  // void sendFileMessage({
  //   required BuildContext context,
  //   required File file,
  //   required String recieverUserId,
  //   required UserModel senderUserData,
  //   required ProviderRef ref,
  //   required MessageEnum messageEnum,
  //   required MessageReply? messageReply,
  //   required bool isGroupChat,
  // }) async {
  //   try {
  //     var timeSent = DateTime.now();
  //     var messageId = const Uuid().v1();

  //     String imageUrl = await ref
  //         .read(commonFirebaseStorageRepositoryProvider)
  //         .storeFileToFirebase(
  //           'chat/${messageEnum.type}/${senderUserData.uid}/$recieverUserId/$messageId',
  //           file,
  //         );

  //     UserModel? recieverUserData;
  //     if (!isGroupChat) {
  //       var userDataMap =
  //           await firestore.collection('users').doc(recieverUserId).get();
  //       recieverUserData = UserModel.fromMap(userDataMap.data()!);
  //     }

  //     String contactMsg;

  //     switch (messageEnum) {
  //       case MessageEnum.image:
  //         contactMsg = '📷 Photo';
  //         break;
  //       case MessageEnum.video:
  //         contactMsg = '📸 Video';
  //         break;
  //       case MessageEnum.audio:
  //         contactMsg = '🎵 Audio';
  //         break;
  //       case MessageEnum.gif:
  //         contactMsg = 'GIF';
  //         break;
  //       default:
  //         contactMsg = 'GIF';
  //     }
  //     _saveDataToContactsSubcollection(
  //       senderUserData,
  //       recieverUserData,
  //       contactMsg,
  //       timeSent,
  //       recieverUserId,
  //       isGroupChat,
  //     );

  //     _saveMessageToMessageSubcollection(
  //       recieverUserId: recieverUserId,
  //       text: imageUrl,
  //       timeSent: timeSent,
  //       messageId: messageId,
  //       username: senderUserData.name,
  //       messageType: messageEnum,
  //       messageReply: messageReply,
  //       recieverUserName: recieverUserData?.name,
  //       senderUsername: senderUserData.name,
  //       isGroupChat: isGroupChat,
  //     );
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }

  // void sendGIFMessage({
  //   required BuildContext context,
  //   required String gifUrl,
  //   required String recieverUserId,
  //   required UserModel senderUser,
  //   required MessageReply? messageReply,
  //   required bool isGroupChat,
  // }) async {
  //   try {
  //     var timeSent = DateTime.now();
  //     UserModel? recieverUserData;

  //     if (!isGroupChat) {
  //       var userDataMap =
  //           await firestore.collection('users').doc(recieverUserId).get();
  //       recieverUserData = UserModel.fromMap(userDataMap.data()!);
  //     }

  //     var messageId = const Uuid().v1();

  //     _saveDataToContactsSubcollection(
  //       senderUser,
  //       recieverUserData,
  //       'GIF',
  //       timeSent,
  //       recieverUserId,
  //       isGroupChat,
  //     );

  //     _saveMessageToMessageSubcollection(
  //       recieverUserId: recieverUserId,
  //       text: gifUrl,
  //       timeSent: timeSent,
  //       messageType: MessageEnum.gif,
  //       messageId: messageId,
  //       username: senderUser.name,
  //       messageReply: messageReply,
  //       recieverUserName: recieverUserData?.name,
  //       senderUsername: senderUser.name,
  //       isGroupChat: isGroupChat,
  //     );
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }

  // void setChatMessageSeen(
  //   BuildContext context,
  //   String recieverUserId,
  //   String messageId,
  // ) async {
  //   try {
  //     await firestore
  //         .collection('users')
  //         .doc(auth.currentUser!.uid)
  //         .collection('chats')
  //         .doc(recieverUserId)
  //         .collection('messages')
  //         .doc(messageId)
  //         .update({'isSeen': true});

  //     await firestore
  //         .collection('users')
  //         .doc(recieverUserId)
  //         .collection('chats')
  //         .doc(auth.currentUser!.uid)
  //         .collection('messages')
  //         .doc(messageId)
  //         .update({'isSeen': true});
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }
}

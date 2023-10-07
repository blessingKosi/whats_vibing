import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whats_vibing/common/utils/colors.dart';
import 'package:whats_vibing/common/widgets/loader.dart';
import 'package:whats_vibing/features/chat/controller/chat_controller.dart';
import 'package:whats_vibing/features/chat/controller/chat_database_controller.dart';
import 'package:whats_vibing/features/chat/screens/mobile_chat_screen.dart';
import 'package:whats_vibing/common/entity/chat_contact.dart';
import 'package:whats_vibing/common/entity/group.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<GroupEntity>>(
              future:
                  ref.watch(localChatControllerProvider).fetchLocalChatGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }

                if (snapshot.hasError) {
                  return const Text(
                      'Error occurred while fetching local group data');
                }

                final localData = snapshot.data;

                return StreamBuilder<List<GroupEntity>>(
                  stream: ref.watch(chatControllerProvider).chatGroups(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }

                    final firebaseData = snapshot.data;

                    final mergedData = [
                      ...(localData ?? []), // Display local data first
                      ...(firebaseData ?? []),
                    ];

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: mergedData.length,
                      itemBuilder: (context, index) {
                        var groupData = mergedData[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MobileChatScreen.routeName,
                                  arguments: {
                                    'name': groupData.name,
                                    'uid': groupData.groupId,
                                    'isGroupChat': true,
                                    'profilePic': groupData.groupPic,
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListTile(
                                  title: Text(
                                    groupData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      groupData.lastMessage,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      groupData.groupPic,
                                    ),
                                    radius: 30,
                                  ),
                                  trailing: Text(
                                    DateFormat.Hm().format(groupData.timeSent),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: dividerColor,
                              indent: 85,
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            /* StreamBuilder<List<Group>>(
                stream: ref.watch(chatControllerProvider).chatGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var groupData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MobileChatScreen.routeName,
                                arguments: {
                                  'name': groupData.name,
                                  'uid': groupData.groupId,
                                  'isGroupChat': true,
                                  'profilePic': groupData.groupPic,
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                title: Text(
                                  groupData.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    groupData.lastMessage,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    groupData.groupPic,
                                  ),
                                  radius: 30,
                                ),
                                trailing: Text(
                                  DateFormat.Hm().format(groupData.timeSent),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: dividerColor, indent: 85),
                        ],
                      );
                    },
                  );
                }),*/

            FutureBuilder<List<ChatContact>>(
              future: ref
                  .watch(localChatControllerProvider)
                  .fetchLocalchatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }

                if (snapshot.hasError) {
                  return const Text(
                      'Error occurred while fetching local chat contacts data');
                }

                final localData = snapshot.data;
                return StreamBuilder<List<ChatContact>>(
                    stream: ref.watch(chatControllerProvider).chatContacts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      }

                      final firebaseData = snapshot.data;

                      final mergedData = [
                        ...(localData ?? []), // Display local data first
                        ...(firebaseData ?? []),
                      ];

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: mergedData.length,
                        itemBuilder: (context, index) {
                          var chatContactData = mergedData[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MobileChatScreen.routeName,
                                    arguments: {
                                      'name': chatContactData.name,
                                      'uid': chatContactData.contactId,
                                      'isGroupChat': false,
                                      'profilePic': chatContactData.profilePic,
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      chatContactData.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        chatContactData.lastMessage,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        chatContactData.profilePic,
                                      ),
                                      radius: 30,
                                    ),
                                    trailing: Text(
                                      DateFormat.Hm()
                                          .format(chatContactData.timeSent),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: dividerColor, indent: 85),
                            ],
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

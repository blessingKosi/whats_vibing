import 'package:floor/floor.dart';

import '../entity/chat_contact.dart';

@dao
abstract class ChatContactDao {
  @Query('SELECT * FROM ChatContact')
  Stream<List<ChatContact>> getAllChatContactsStream();

  @Query('SELECT * FROM ChatContact')
  Future<List<ChatContact>> getAllChatContacts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> bulkInsertChatContacts(List<ChatContact> chatContacts);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertChatContact(ChatContact chatContact);

  // Additional methods for updating, deleting, etc.
}

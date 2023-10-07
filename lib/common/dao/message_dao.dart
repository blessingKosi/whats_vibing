import 'package:floor/floor.dart';

import '../entity/message.dart';

@dao
abstract class MessageDao {
  @Query('SELECT * FROM Message')
  Stream<List<Message>> getAllMessagesStream();

  @Query('SELECT * FROM Message')
  Future<List<Message>> getAllMessages();

  

  @Query('SELECT * FROM Message WHERE recieverid = :recieverid')
  Future<List<Message>> getMessagesByReceiverId(String recieverid);

    @Query('SELECT * FROM Message WHERE groupId = :groupId')
  Future<List<Message>> getMessagesByGroupId(String groupId);

  @insert
  Future<void> insertMessage(Message message);

  @delete
  Future<void> deleteMessage(Message message);

  @Query('DELETE FROM Message')
  Future<void> deleteAllMessages();
}

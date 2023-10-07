import 'package:floor/floor.dart';

import '../entity/group.dart';

@dao
abstract class GroupDao {
  @Query('SELECT * FROM GroupEntity')
  Stream<List<GroupEntity>> getAllGroupsStream();

  @Query('SELECT * FROM GroupEntity')
  Future<List<GroupEntity>> getAllGroups();

  @Query('SELECT * FROM GroupEntity WHERE groupId = :groupId')
  Future<GroupEntity?> getGroupById(String groupId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> bulkInsertGroup(List<GroupEntity> groups);

  @insert
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGroup(GroupEntity group);

  @update
  Future<void> updateGroup(GroupEntity group);

  @delete
  Future<void> deleteGroup(GroupEntity group);
}

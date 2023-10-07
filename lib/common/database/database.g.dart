// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GroupDao? _groupDaoInstance;

  ChatContactDao? _chatContactDaoInstance;

  MessageDao? _messageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GroupEntity` (`senderId` TEXT NOT NULL, `name` TEXT NOT NULL, `groupId` TEXT NOT NULL, `lastMessage` TEXT NOT NULL, `groupPic` TEXT NOT NULL, `membersUid` TEXT NOT NULL, `timeSent` INTEGER NOT NULL, PRIMARY KEY (`senderId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChatContact` (`name` TEXT NOT NULL, `profilePic` TEXT NOT NULL, `contactId` TEXT NOT NULL, `timeSent` INTEGER NOT NULL, `lastMessage` TEXT NOT NULL, PRIMARY KEY (`name`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Message` (`senderId` TEXT NOT NULL, `recieverid` TEXT NOT NULL, `text` TEXT NOT NULL, `type` INTEGER NOT NULL, `timeSent` INTEGER NOT NULL, `messageId` TEXT NOT NULL, `isSeen` INTEGER NOT NULL, `repliedMessage` TEXT NOT NULL, `repliedTo` TEXT NOT NULL, `repliedMessageType` INTEGER NOT NULL, PRIMARY KEY (`senderId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GroupDao get groupDao {
    return _groupDaoInstance ??= _$GroupDao(database, changeListener);
  }

  @override
  ChatContactDao get chatContactDao {
    return _chatContactDaoInstance ??=
        _$ChatContactDao(database, changeListener);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }
}

class _$GroupDao extends GroupDao {
  _$GroupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _groupEntityInsertionAdapter = InsertionAdapter(
            database,
            'GroupEntity',
            (GroupEntity item) => <String, Object?>{
                  'senderId': item.senderId,
                  'name': item.name,
                  'groupId': item.groupId,
                  'lastMessage': item.lastMessage,
                  'groupPic': item.groupPic,
                  'membersUid': _stringListConverter.encode(item.membersUid),
                  'timeSent': _dateTimeConverter.encode(item.timeSent)
                },
            changeListener),
        _groupEntityUpdateAdapter = UpdateAdapter(
            database,
            'GroupEntity',
            ['senderId'],
            (GroupEntity item) => <String, Object?>{
                  'senderId': item.senderId,
                  'name': item.name,
                  'groupId': item.groupId,
                  'lastMessage': item.lastMessage,
                  'groupPic': item.groupPic,
                  'membersUid': _stringListConverter.encode(item.membersUid),
                  'timeSent': _dateTimeConverter.encode(item.timeSent)
                },
            changeListener),
        _groupEntityDeletionAdapter = DeletionAdapter(
            database,
            'GroupEntity',
            ['senderId'],
            (GroupEntity item) => <String, Object?>{
                  'senderId': item.senderId,
                  'name': item.name,
                  'groupId': item.groupId,
                  'lastMessage': item.lastMessage,
                  'groupPic': item.groupPic,
                  'membersUid': _stringListConverter.encode(item.membersUid),
                  'timeSent': _dateTimeConverter.encode(item.timeSent)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GroupEntity> _groupEntityInsertionAdapter;

  final UpdateAdapter<GroupEntity> _groupEntityUpdateAdapter;

  final DeletionAdapter<GroupEntity> _groupEntityDeletionAdapter;

  @override
  Stream<List<GroupEntity>> getAllGroupsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM GroupEntity',
        mapper: (Map<String, Object?> row) => GroupEntity(
            senderId: row['senderId'] as String,
            name: row['name'] as String,
            groupId: row['groupId'] as String,
            lastMessage: row['lastMessage'] as String,
            groupPic: row['groupPic'] as String,
            membersUid:
                _stringListConverter.decode(row['membersUid'] as String),
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int)),
        queryableName: 'GroupEntity',
        isView: false);
  }

  @override
  Future<List<GroupEntity>> getAllGroups() async {
    return _queryAdapter.queryList('SELECT * FROM GroupEntity',
        mapper: (Map<String, Object?> row) => GroupEntity(
            senderId: row['senderId'] as String,
            name: row['name'] as String,
            groupId: row['groupId'] as String,
            lastMessage: row['lastMessage'] as String,
            groupPic: row['groupPic'] as String,
            membersUid:
                _stringListConverter.decode(row['membersUid'] as String),
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int)));
  }

  @override
  Future<GroupEntity?> getGroupById(String groupId) async {
    return _queryAdapter.query('SELECT * FROM GroupEntity WHERE groupId = ?1',
        mapper: (Map<String, Object?> row) => GroupEntity(
            senderId: row['senderId'] as String,
            name: row['name'] as String,
            groupId: row['groupId'] as String,
            lastMessage: row['lastMessage'] as String,
            groupPic: row['groupPic'] as String,
            membersUid:
                _stringListConverter.decode(row['membersUid'] as String),
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int)),
        arguments: [groupId]);
  }

  @override
  Future<void> bulkInsertGroup(List<GroupEntity> groups) async {
    await _groupEntityInsertionAdapter.insertList(
        groups, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertGroup(GroupEntity group) async {
    await _groupEntityInsertionAdapter.insert(group, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateGroup(GroupEntity group) async {
    await _groupEntityUpdateAdapter.update(group, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGroup(GroupEntity group) async {
    await _groupEntityDeletionAdapter.delete(group);
  }
}

class _$ChatContactDao extends ChatContactDao {
  _$ChatContactDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _chatContactInsertionAdapter = InsertionAdapter(
            database,
            'ChatContact',
            (ChatContact item) => <String, Object?>{
                  'name': item.name,
                  'profilePic': item.profilePic,
                  'contactId': item.contactId,
                  'timeSent': _dateTimeConverter.encode(item.timeSent),
                  'lastMessage': item.lastMessage
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChatContact> _chatContactInsertionAdapter;

  @override
  Stream<List<ChatContact>> getAllChatContactsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM ChatContact',
        mapper: (Map<String, Object?> row) => ChatContact(
            name: row['name'] as String,
            profilePic: row['profilePic'] as String,
            contactId: row['contactId'] as String,
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            lastMessage: row['lastMessage'] as String),
        queryableName: 'ChatContact',
        isView: false);
  }

  @override
  Future<List<ChatContact>> getAllChatContacts() async {
    return _queryAdapter.queryList('SELECT * FROM ChatContact',
        mapper: (Map<String, Object?> row) => ChatContact(
            name: row['name'] as String,
            profilePic: row['profilePic'] as String,
            contactId: row['contactId'] as String,
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            lastMessage: row['lastMessage'] as String));
  }

  @override
  Future<void> bulkInsertChatContacts(List<ChatContact> chatContacts) async {
    await _chatContactInsertionAdapter.insertList(
        chatContacts, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertChatContact(ChatContact chatContact) async {
    await _chatContactInsertionAdapter.insert(
        chatContact, OnConflictStrategy.replace);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _messageInsertionAdapter = InsertionAdapter(
            database,
            'Message',
            (Message item) => <String, Object?>{
                  'senderId': item.senderId,
                  'recieverid': item.recieverid,
                  'text': item.text,
                  'type': item.type.index,
                  'timeSent': _dateTimeConverter.encode(item.timeSent),
                  'messageId': item.messageId,
                  'isSeen': item.isSeen ? 1 : 0,
                  'repliedMessage': item.repliedMessage,
                  'repliedTo': item.repliedTo,
                  'repliedMessageType': item.repliedMessageType.index
                },
            changeListener),
        _messageDeletionAdapter = DeletionAdapter(
            database,
            'Message',
            ['senderId'],
            (Message item) => <String, Object?>{
                  'senderId': item.senderId,
                  'recieverid': item.recieverid,
                  'text': item.text,
                  'type': item.type.index,
                  'timeSent': _dateTimeConverter.encode(item.timeSent),
                  'messageId': item.messageId,
                  'isSeen': item.isSeen ? 1 : 0,
                  'repliedMessage': item.repliedMessage,
                  'repliedTo': item.repliedTo,
                  'repliedMessageType': item.repliedMessageType.index
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Message> _messageInsertionAdapter;

  final DeletionAdapter<Message> _messageDeletionAdapter;

  @override
  Stream<List<Message>> getAllMessagesStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Message',
        mapper: (Map<String, Object?> row) => Message(
            senderId: row['senderId'] as String,
            recieverid: row['recieverid'] as String,
            text: row['text'] as String,
            type: MessageEnum.values[row['type'] as int],
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            messageId: row['messageId'] as String,
            isSeen: (row['isSeen'] as int) != 0,
            repliedMessage: row['repliedMessage'] as String,
            repliedTo: row['repliedTo'] as String,
            repliedMessageType:
                MessageEnum.values[row['repliedMessageType'] as int]),
        queryableName: 'Message',
        isView: false);
  }

  @override
  Future<List<Message>> getAllMessages() async {
    return _queryAdapter.queryList('SELECT * FROM Message',
        mapper: (Map<String, Object?> row) => Message(
            senderId: row['senderId'] as String,
            recieverid: row['recieverid'] as String,
            text: row['text'] as String,
            type: MessageEnum.values[row['type'] as int],
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            messageId: row['messageId'] as String,
            isSeen: (row['isSeen'] as int) != 0,
            repliedMessage: row['repliedMessage'] as String,
            repliedTo: row['repliedTo'] as String,
            repliedMessageType:
                MessageEnum.values[row['repliedMessageType'] as int]));
  }

  @override
  Future<List<Message>> getMessagesByReceiverId(String recieverid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Message WHERE recieverid = ?1',
        mapper: (Map<String, Object?> row) => Message(
            senderId: row['senderId'] as String,
            recieverid: row['recieverid'] as String,
            text: row['text'] as String,
            type: MessageEnum.values[row['type'] as int],
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            messageId: row['messageId'] as String,
            isSeen: (row['isSeen'] as int) != 0,
            repliedMessage: row['repliedMessage'] as String,
            repliedTo: row['repliedTo'] as String,
            repliedMessageType:
                MessageEnum.values[row['repliedMessageType'] as int]),
        arguments: [recieverid]);
  }

  @override
  Future<List<Message>> getMessagesByGroupId(String groupId) async {
    return _queryAdapter.queryList('SELECT * FROM Message WHERE groupId = ?1',
        mapper: (Map<String, Object?> row) => Message(
            senderId: row['senderId'] as String,
            recieverid: row['recieverid'] as String,
            text: row['text'] as String,
            type: MessageEnum.values[row['type'] as int],
            timeSent: _dateTimeConverter.decode(row['timeSent'] as int),
            messageId: row['messageId'] as String,
            isSeen: (row['isSeen'] as int) != 0,
            repliedMessage: row['repliedMessage'] as String,
            repliedTo: row['repliedTo'] as String,
            repliedMessageType:
                MessageEnum.values[row['repliedMessageType'] as int]),
        arguments: [groupId]);
  }

  @override
  Future<void> deleteAllMessages() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Message');
  }

  @override
  Future<void> insertMessage(Message message) async {
    await _messageInsertionAdapter.insert(message, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMessage(Message message) async {
    await _messageDeletionAdapter.delete(message);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _stringListConverter = StringListConverter();

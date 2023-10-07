import 'dart:async';
// import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:whats_vibing/common/dao/message_dao.dart';
import 'package:whats_vibing/common/entity/chat_contact.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:whats_vibing/common/entity/group.dart';
import 'package:whats_vibing/common/entity/message.dart';

import '../dao/chat_contact_dao.dart';
import '../dao/group_dao.dart';
import '../enums/message_enum.dart';
import '../utils/converters.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter, /*IntListConverter, */ StringListConverter])
@Database(version: 1, entities: [
  GroupEntity,
  ChatContact,
  Message,
])
abstract class AppDatabase extends FloorDatabase {
  GroupDao get groupDao;
  ChatContactDao get chatContactDao;
  MessageDao get messageDao;
}

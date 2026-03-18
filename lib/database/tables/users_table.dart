import 'package:drift/drift.dart';

class Users extends Table {
  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().nullable()();

  TextColumn get email => text().unique()();
}

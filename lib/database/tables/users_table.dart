import 'package:drift/drift.dart';

class Users extends Table {
  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();

  TextColumn get name => text().nullable()();
  TextColumn get username => text()();
  TextColumn get email => text().unique()();
  TextColumn get phone => text().nullable()();
  TextColumn get chatId => text().nullable()();
}

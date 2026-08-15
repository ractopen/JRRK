import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// part 'user.g.dart';

class users extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get email => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

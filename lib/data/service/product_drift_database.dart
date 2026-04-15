import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'product_drift_database.g.dart';

class DriftProducts extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  TextColumn get productUrl => text()();
  IntColumn get quantity => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DriftProductMetadata extends Table {
  TextColumn get key => text()();
  IntColumn get intValue => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(tables: [DriftProducts, DriftProductMetadata])
class ProductDriftDatabase extends _$ProductDriftDatabase {
  ProductDriftDatabase._() : super(_openConnection());

  static final ProductDriftDatabase instance = ProductDriftDatabase._();

  @override
  int get schemaVersion => 1;

  Future<void> initialize() async {
    await customSelect('SELECT 1').get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(path.join(directory.path, 'product_benchmark.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
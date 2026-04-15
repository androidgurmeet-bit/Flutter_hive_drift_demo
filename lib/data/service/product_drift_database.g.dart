// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_drift_database.dart';

// ignore_for_file: type=lint
class $DriftProductsTable extends DriftProducts
    with TableInfo<$DriftProductsTable, DriftProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productUrlMeta = const VerificationMeta(
    'productUrl',
  );
  @override
  late final GeneratedColumn<String> productUrl = GeneratedColumn<String>(
    'product_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    price,
    productUrl,
    quantity,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('product_url')) {
      context.handle(
        _productUrlMeta,
        productUrl.isAcceptableOrUnknown(data['product_url']!, _productUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_productUrlMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      productUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_url'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $DriftProductsTable createAlias(String alias) {
    return $DriftProductsTable(attachedDatabase, alias);
  }
}

class DriftProduct extends DataClass implements Insertable<DriftProduct> {
  final int id;
  final String name;
  final double price;
  final String productUrl;
  final int quantity;
  final String? description;
  const DriftProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.productUrl,
    required this.quantity,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['product_url'] = Variable<String>(productUrl);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  DriftProductsCompanion toCompanion(bool nullToAbsent) {
    return DriftProductsCompanion(
      id: Value(id),
      name: Value(name),
      price: Value(price),
      productUrl: Value(productUrl),
      quantity: Value(quantity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory DriftProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftProduct(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      productUrl: serializer.fromJson<String>(json['productUrl']),
      quantity: serializer.fromJson<int>(json['quantity']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'productUrl': serializer.toJson<String>(productUrl),
      'quantity': serializer.toJson<int>(quantity),
      'description': serializer.toJson<String?>(description),
    };
  }

  DriftProduct copyWith({
    int? id,
    String? name,
    double? price,
    String? productUrl,
    int? quantity,
    Value<String?> description = const Value.absent(),
  }) => DriftProduct(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    productUrl: productUrl ?? this.productUrl,
    quantity: quantity ?? this.quantity,
    description: description.present ? description.value : this.description,
  );
  DriftProduct copyWithCompanion(DriftProductsCompanion data) {
    return DriftProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      productUrl: data.productUrl.present
          ? data.productUrl.value
          : this.productUrl,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('productUrl: $productUrl, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, price, productUrl, quantity, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.productUrl == this.productUrl &&
          other.quantity == this.quantity &&
          other.description == this.description);
}

class DriftProductsCompanion extends UpdateCompanion<DriftProduct> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> price;
  final Value<String> productUrl;
  final Value<int> quantity;
  final Value<String?> description;
  const DriftProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.productUrl = const Value.absent(),
    this.quantity = const Value.absent(),
    this.description = const Value.absent(),
  });
  DriftProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double price,
    required String productUrl,
    required int quantity,
    this.description = const Value.absent(),
  }) : name = Value(name),
       price = Value(price),
       productUrl = Value(productUrl),
       quantity = Value(quantity);
  static Insertable<DriftProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? price,
    Expression<String>? productUrl,
    Expression<int>? quantity,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (productUrl != null) 'product_url': productUrl,
      if (quantity != null) 'quantity': quantity,
      if (description != null) 'description': description,
    });
  }

  DriftProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? price,
    Value<String>? productUrl,
    Value<int>? quantity,
    Value<String?>? description,
  }) {
    return DriftProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      productUrl: productUrl ?? this.productUrl,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (productUrl.present) {
      map['product_url'] = Variable<String>(productUrl.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('productUrl: $productUrl, ')
          ..write('quantity: $quantity, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $DriftProductMetadataTable extends DriftProductMetadata
    with TableInfo<$DriftProductMetadataTable, DriftProductMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftProductMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intValueMeta = const VerificationMeta(
    'intValue',
  );
  @override
  late final GeneratedColumn<int> intValue = GeneratedColumn<int>(
    'int_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, intValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_product_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftProductMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('int_value')) {
      context.handle(
        _intValueMeta,
        intValue.isAcceptableOrUnknown(data['int_value']!, _intValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  DriftProductMetadataData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftProductMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      intValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}int_value'],
      ),
    );
  }

  @override
  $DriftProductMetadataTable createAlias(String alias) {
    return $DriftProductMetadataTable(attachedDatabase, alias);
  }
}

class DriftProductMetadataData extends DataClass
    implements Insertable<DriftProductMetadataData> {
  final String key;
  final int? intValue;
  const DriftProductMetadataData({required this.key, this.intValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || intValue != null) {
      map['int_value'] = Variable<int>(intValue);
    }
    return map;
  }

  DriftProductMetadataCompanion toCompanion(bool nullToAbsent) {
    return DriftProductMetadataCompanion(
      key: Value(key),
      intValue: intValue == null && nullToAbsent
          ? const Value.absent()
          : Value(intValue),
    );
  }

  factory DriftProductMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftProductMetadataData(
      key: serializer.fromJson<String>(json['key']),
      intValue: serializer.fromJson<int?>(json['intValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'intValue': serializer.toJson<int?>(intValue),
    };
  }

  DriftProductMetadataData copyWith({
    String? key,
    Value<int?> intValue = const Value.absent(),
  }) => DriftProductMetadataData(
    key: key ?? this.key,
    intValue: intValue.present ? intValue.value : this.intValue,
  );
  DriftProductMetadataData copyWithCompanion(
    DriftProductMetadataCompanion data,
  ) {
    return DriftProductMetadataData(
      key: data.key.present ? data.key.value : this.key,
      intValue: data.intValue.present ? data.intValue.value : this.intValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftProductMetadataData(')
          ..write('key: $key, ')
          ..write('intValue: $intValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, intValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftProductMetadataData &&
          other.key == this.key &&
          other.intValue == this.intValue);
}

class DriftProductMetadataCompanion
    extends UpdateCompanion<DriftProductMetadataData> {
  final Value<String> key;
  final Value<int?> intValue;
  final Value<int> rowid;
  const DriftProductMetadataCompanion({
    this.key = const Value.absent(),
    this.intValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DriftProductMetadataCompanion.insert({
    required String key,
    this.intValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<DriftProductMetadataData> custom({
    Expression<String>? key,
    Expression<int>? intValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (intValue != null) 'int_value': intValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DriftProductMetadataCompanion copyWith({
    Value<String>? key,
    Value<int?>? intValue,
    Value<int>? rowid,
  }) {
    return DriftProductMetadataCompanion(
      key: key ?? this.key,
      intValue: intValue ?? this.intValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (intValue.present) {
      map['int_value'] = Variable<int>(intValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftProductMetadataCompanion(')
          ..write('key: $key, ')
          ..write('intValue: $intValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProductDriftDatabase extends GeneratedDatabase {
  _$ProductDriftDatabase(QueryExecutor e) : super(e);
  $ProductDriftDatabaseManager get managers =>
      $ProductDriftDatabaseManager(this);
  late final $DriftProductsTable driftProducts = $DriftProductsTable(this);
  late final $DriftProductMetadataTable driftProductMetadata =
      $DriftProductMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    driftProducts,
    driftProductMetadata,
  ];
}

typedef $$DriftProductsTableCreateCompanionBuilder =
    DriftProductsCompanion Function({
      Value<int> id,
      required String name,
      required double price,
      required String productUrl,
      required int quantity,
      Value<String?> description,
    });
typedef $$DriftProductsTableUpdateCompanionBuilder =
    DriftProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> price,
      Value<String> productUrl,
      Value<int> quantity,
      Value<String?> description,
    });

class $$DriftProductsTableFilterComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductsTable> {
  $$DriftProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productUrl => $composableBuilder(
    column: $table.productUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftProductsTableOrderingComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductsTable> {
  $$DriftProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productUrl => $composableBuilder(
    column: $table.productUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftProductsTableAnnotationComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductsTable> {
  $$DriftProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get productUrl => $composableBuilder(
    column: $table.productUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$DriftProductsTableTableManager
    extends
        RootTableManager<
          _$ProductDriftDatabase,
          $DriftProductsTable,
          DriftProduct,
          $$DriftProductsTableFilterComposer,
          $$DriftProductsTableOrderingComposer,
          $$DriftProductsTableAnnotationComposer,
          $$DriftProductsTableCreateCompanionBuilder,
          $$DriftProductsTableUpdateCompanionBuilder,
          (
            DriftProduct,
            BaseReferences<
              _$ProductDriftDatabase,
              $DriftProductsTable,
              DriftProduct
            >,
          ),
          DriftProduct,
          PrefetchHooks Function()
        > {
  $$DriftProductsTableTableManager(
    _$ProductDriftDatabase db,
    $DriftProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriftProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriftProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriftProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> productUrl = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => DriftProductsCompanion(
                id: id,
                name: name,
                price: price,
                productUrl: productUrl,
                quantity: quantity,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double price,
                required String productUrl,
                required int quantity,
                Value<String?> description = const Value.absent(),
              }) => DriftProductsCompanion.insert(
                id: id,
                name: name,
                price: price,
                productUrl: productUrl,
                quantity: quantity,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductDriftDatabase,
      $DriftProductsTable,
      DriftProduct,
      $$DriftProductsTableFilterComposer,
      $$DriftProductsTableOrderingComposer,
      $$DriftProductsTableAnnotationComposer,
      $$DriftProductsTableCreateCompanionBuilder,
      $$DriftProductsTableUpdateCompanionBuilder,
      (
        DriftProduct,
        BaseReferences<
          _$ProductDriftDatabase,
          $DriftProductsTable,
          DriftProduct
        >,
      ),
      DriftProduct,
      PrefetchHooks Function()
    >;
typedef $$DriftProductMetadataTableCreateCompanionBuilder =
    DriftProductMetadataCompanion Function({
      required String key,
      Value<int?> intValue,
      Value<int> rowid,
    });
typedef $$DriftProductMetadataTableUpdateCompanionBuilder =
    DriftProductMetadataCompanion Function({
      Value<String> key,
      Value<int?> intValue,
      Value<int> rowid,
    });

class $$DriftProductMetadataTableFilterComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductMetadataTable> {
  $$DriftProductMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intValue => $composableBuilder(
    column: $table.intValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftProductMetadataTableOrderingComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductMetadataTable> {
  $$DriftProductMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intValue => $composableBuilder(
    column: $table.intValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftProductMetadataTableAnnotationComposer
    extends Composer<_$ProductDriftDatabase, $DriftProductMetadataTable> {
  $$DriftProductMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get intValue =>
      $composableBuilder(column: $table.intValue, builder: (column) => column);
}

class $$DriftProductMetadataTableTableManager
    extends
        RootTableManager<
          _$ProductDriftDatabase,
          $DriftProductMetadataTable,
          DriftProductMetadataData,
          $$DriftProductMetadataTableFilterComposer,
          $$DriftProductMetadataTableOrderingComposer,
          $$DriftProductMetadataTableAnnotationComposer,
          $$DriftProductMetadataTableCreateCompanionBuilder,
          $$DriftProductMetadataTableUpdateCompanionBuilder,
          (
            DriftProductMetadataData,
            BaseReferences<
              _$ProductDriftDatabase,
              $DriftProductMetadataTable,
              DriftProductMetadataData
            >,
          ),
          DriftProductMetadataData,
          PrefetchHooks Function()
        > {
  $$DriftProductMetadataTableTableManager(
    _$ProductDriftDatabase db,
    $DriftProductMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriftProductMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriftProductMetadataTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DriftProductMetadataTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int?> intValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DriftProductMetadataCompanion(
                key: key,
                intValue: intValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<int?> intValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DriftProductMetadataCompanion.insert(
                key: key,
                intValue: intValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftProductMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductDriftDatabase,
      $DriftProductMetadataTable,
      DriftProductMetadataData,
      $$DriftProductMetadataTableFilterComposer,
      $$DriftProductMetadataTableOrderingComposer,
      $$DriftProductMetadataTableAnnotationComposer,
      $$DriftProductMetadataTableCreateCompanionBuilder,
      $$DriftProductMetadataTableUpdateCompanionBuilder,
      (
        DriftProductMetadataData,
        BaseReferences<
          _$ProductDriftDatabase,
          $DriftProductMetadataTable,
          DriftProductMetadataData
        >,
      ),
      DriftProductMetadataData,
      PrefetchHooks Function()
    >;

class $ProductDriftDatabaseManager {
  final _$ProductDriftDatabase _db;
  $ProductDriftDatabaseManager(this._db);
  $$DriftProductsTableTableManager get driftProducts =>
      $$DriftProductsTableTableManager(_db, _db.driftProducts);
  $$DriftProductMetadataTableTableManager get driftProductMetadata =>
      $$DriftProductMetadataTableTableManager(_db, _db.driftProductMetadata);
}

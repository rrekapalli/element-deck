// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learner_database.dart';

// ignore_for_file: type=lint
class $PreferenceRowsTable extends PreferenceRows
    with TableInfo<$PreferenceRowsTable, PreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenceRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preference_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferenceRow> instance, {
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
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  PreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenceRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PreferenceRowsTable createAlias(String alias) {
    return $PreferenceRowsTable(attachedDatabase, alias);
  }
}

class PreferenceRow extends DataClass implements Insertable<PreferenceRow> {
  final String key;
  final String value;
  final int updatedAt;
  const PreferenceRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  PreferenceRowsCompanion toCompanion(bool nullToAbsent) {
    return PreferenceRowsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenceRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  PreferenceRow copyWith({String? key, String? value, int? updatedAt}) =>
      PreferenceRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PreferenceRow copyWithCompanion(PreferenceRowsCompanion data) {
    return PreferenceRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenceRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class PreferenceRowsCompanion extends UpdateCompanion<PreferenceRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const PreferenceRowsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferenceRowsCompanion.insert({
    required String key,
    required String value,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<PreferenceRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferenceRowsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return PreferenceRowsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceRowsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _zMeta = const VerificationMeta('z');
  @override
  late final GeneratedColumn<int> z = GeneratedColumn<int>(
    'z',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [z, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('z')) {
      context.handle(_zMeta, z.isAcceptableOrUnknown(data['z']!, _zMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {z};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      z: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int z;
  final int createdAt;
  const Bookmark({required this.z, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['z'] = Variable<int>(z);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(z: Value(z), createdAt: Value(createdAt));
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      z: serializer.fromJson<int>(json['z']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'z': serializer.toJson<int>(z),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Bookmark copyWith({int? z, int? createdAt}) =>
      Bookmark(z: z ?? this.z, createdAt: createdAt ?? this.createdAt);
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      z: data.z.present ? data.z.value : this.z,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('z: $z, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(z, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.z == this.z &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> z;
  final Value<int> createdAt;
  const BookmarksCompanion({
    this.z = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.z = const Value.absent(),
    required int createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? z,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (z != null) 'z': z,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({Value<int>? z, Value<int>? createdAt}) {
    return BookmarksCompanion(
      z: z ?? this.z,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (z.present) {
      map['z'] = Variable<int>(z.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('z: $z, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecentsTable extends Recents with TableInfo<$RecentsTable, Recent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _zMeta = const VerificationMeta('z');
  @override
  late final GeneratedColumn<int> z = GeneratedColumn<int>(
    'z',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _viewedAtMeta = const VerificationMeta(
    'viewedAt',
  );
  @override
  late final GeneratedColumn<int> viewedAt = GeneratedColumn<int>(
    'viewed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [z, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('z')) {
      context.handle(_zMeta, z.isAcceptableOrUnknown(data['z']!, _zMeta));
    }
    if (data.containsKey('viewed_at')) {
      context.handle(
        _viewedAtMeta,
        viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_viewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {z};
  @override
  Recent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recent(
      z: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z'],
      )!,
      viewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}viewed_at'],
      )!,
    );
  }

  @override
  $RecentsTable createAlias(String alias) {
    return $RecentsTable(attachedDatabase, alias);
  }
}

class Recent extends DataClass implements Insertable<Recent> {
  final int z;
  final int viewedAt;
  const Recent({required this.z, required this.viewedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['z'] = Variable<int>(z);
    map['viewed_at'] = Variable<int>(viewedAt);
    return map;
  }

  RecentsCompanion toCompanion(bool nullToAbsent) {
    return RecentsCompanion(z: Value(z), viewedAt: Value(viewedAt));
  }

  factory Recent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recent(
      z: serializer.fromJson<int>(json['z']),
      viewedAt: serializer.fromJson<int>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'z': serializer.toJson<int>(z),
      'viewedAt': serializer.toJson<int>(viewedAt),
    };
  }

  Recent copyWith({int? z, int? viewedAt}) =>
      Recent(z: z ?? this.z, viewedAt: viewedAt ?? this.viewedAt);
  Recent copyWithCompanion(RecentsCompanion data) {
    return Recent(
      z: data.z.present ? data.z.value : this.z,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recent(')
          ..write('z: $z, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(z, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recent && other.z == this.z && other.viewedAt == this.viewedAt);
}

class RecentsCompanion extends UpdateCompanion<Recent> {
  final Value<int> z;
  final Value<int> viewedAt;
  const RecentsCompanion({
    this.z = const Value.absent(),
    this.viewedAt = const Value.absent(),
  });
  RecentsCompanion.insert({
    this.z = const Value.absent(),
    required int viewedAt,
  }) : viewedAt = Value(viewedAt);
  static Insertable<Recent> custom({
    Expression<int>? z,
    Expression<int>? viewedAt,
  }) {
    return RawValuesInsertable({
      if (z != null) 'z': z,
      if (viewedAt != null) 'viewed_at': viewedAt,
    });
  }

  RecentsCompanion copyWith({Value<int>? z, Value<int>? viewedAt}) {
    return RecentsCompanion(
      z: z ?? this.z,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (z.present) {
      map['z'] = Variable<int>(z.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<int>(viewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentsCompanion(')
          ..write('z: $z, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }
}

class $SavedComparisonsTable extends SavedComparisons
    with TableInfo<$SavedComparisonsTable, SavedComparison> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedComparisonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _zAMeta = const VerificationMeta('zA');
  @override
  late final GeneratedColumn<int> zA = GeneratedColumn<int>(
    'z_a',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zBMeta = const VerificationMeta('zB');
  @override
  late final GeneratedColumn<int> zB = GeneratedColumn<int>(
    'z_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayAMeta = const VerificationMeta(
    'displayA',
  );
  @override
  late final GeneratedColumn<int> displayA = GeneratedColumn<int>(
    'display_a',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayBMeta = const VerificationMeta(
    'displayB',
  );
  @override
  late final GeneratedColumn<int> displayB = GeneratedColumn<int>(
    'display_b',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [zA, zB, displayA, displayB, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_comparisons';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedComparison> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('z_a')) {
      context.handle(_zAMeta, zA.isAcceptableOrUnknown(data['z_a']!, _zAMeta));
    } else if (isInserting) {
      context.missing(_zAMeta);
    }
    if (data.containsKey('z_b')) {
      context.handle(_zBMeta, zB.isAcceptableOrUnknown(data['z_b']!, _zBMeta));
    } else if (isInserting) {
      context.missing(_zBMeta);
    }
    if (data.containsKey('display_a')) {
      context.handle(
        _displayAMeta,
        displayA.isAcceptableOrUnknown(data['display_a']!, _displayAMeta),
      );
    } else if (isInserting) {
      context.missing(_displayAMeta);
    }
    if (data.containsKey('display_b')) {
      context.handle(
        _displayBMeta,
        displayB.isAcceptableOrUnknown(data['display_b']!, _displayBMeta),
      );
    } else if (isInserting) {
      context.missing(_displayBMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {zA, zB};
  @override
  SavedComparison map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedComparison(
      zA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z_a'],
      )!,
      zB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z_b'],
      )!,
      displayA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_a'],
      )!,
      displayB: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_b'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SavedComparisonsTable createAlias(String alias) {
    return $SavedComparisonsTable(attachedDatabase, alias);
  }
}

class SavedComparison extends DataClass implements Insertable<SavedComparison> {
  final int zA;
  final int zB;
  final int displayA;
  final int displayB;
  final int createdAt;
  const SavedComparison({
    required this.zA,
    required this.zB,
    required this.displayA,
    required this.displayB,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['z_a'] = Variable<int>(zA);
    map['z_b'] = Variable<int>(zB);
    map['display_a'] = Variable<int>(displayA);
    map['display_b'] = Variable<int>(displayB);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SavedComparisonsCompanion toCompanion(bool nullToAbsent) {
    return SavedComparisonsCompanion(
      zA: Value(zA),
      zB: Value(zB),
      displayA: Value(displayA),
      displayB: Value(displayB),
      createdAt: Value(createdAt),
    );
  }

  factory SavedComparison.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedComparison(
      zA: serializer.fromJson<int>(json['zA']),
      zB: serializer.fromJson<int>(json['zB']),
      displayA: serializer.fromJson<int>(json['displayA']),
      displayB: serializer.fromJson<int>(json['displayB']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'zA': serializer.toJson<int>(zA),
      'zB': serializer.toJson<int>(zB),
      'displayA': serializer.toJson<int>(displayA),
      'displayB': serializer.toJson<int>(displayB),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SavedComparison copyWith({
    int? zA,
    int? zB,
    int? displayA,
    int? displayB,
    int? createdAt,
  }) => SavedComparison(
    zA: zA ?? this.zA,
    zB: zB ?? this.zB,
    displayA: displayA ?? this.displayA,
    displayB: displayB ?? this.displayB,
    createdAt: createdAt ?? this.createdAt,
  );
  SavedComparison copyWithCompanion(SavedComparisonsCompanion data) {
    return SavedComparison(
      zA: data.zA.present ? data.zA.value : this.zA,
      zB: data.zB.present ? data.zB.value : this.zB,
      displayA: data.displayA.present ? data.displayA.value : this.displayA,
      displayB: data.displayB.present ? data.displayB.value : this.displayB,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedComparison(')
          ..write('zA: $zA, ')
          ..write('zB: $zB, ')
          ..write('displayA: $displayA, ')
          ..write('displayB: $displayB, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(zA, zB, displayA, displayB, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedComparison &&
          other.zA == this.zA &&
          other.zB == this.zB &&
          other.displayA == this.displayA &&
          other.displayB == this.displayB &&
          other.createdAt == this.createdAt);
}

class SavedComparisonsCompanion extends UpdateCompanion<SavedComparison> {
  final Value<int> zA;
  final Value<int> zB;
  final Value<int> displayA;
  final Value<int> displayB;
  final Value<int> createdAt;
  final Value<int> rowid;
  const SavedComparisonsCompanion({
    this.zA = const Value.absent(),
    this.zB = const Value.absent(),
    this.displayA = const Value.absent(),
    this.displayB = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedComparisonsCompanion.insert({
    required int zA,
    required int zB,
    required int displayA,
    required int displayB,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : zA = Value(zA),
       zB = Value(zB),
       displayA = Value(displayA),
       displayB = Value(displayB),
       createdAt = Value(createdAt);
  static Insertable<SavedComparison> custom({
    Expression<int>? zA,
    Expression<int>? zB,
    Expression<int>? displayA,
    Expression<int>? displayB,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (zA != null) 'z_a': zA,
      if (zB != null) 'z_b': zB,
      if (displayA != null) 'display_a': displayA,
      if (displayB != null) 'display_b': displayB,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedComparisonsCompanion copyWith({
    Value<int>? zA,
    Value<int>? zB,
    Value<int>? displayA,
    Value<int>? displayB,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return SavedComparisonsCompanion(
      zA: zA ?? this.zA,
      zB: zB ?? this.zB,
      displayA: displayA ?? this.displayA,
      displayB: displayB ?? this.displayB,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (zA.present) {
      map['z_a'] = Variable<int>(zA.value);
    }
    if (zB.present) {
      map['z_b'] = Variable<int>(zB.value);
    }
    if (displayA.present) {
      map['display_a'] = Variable<int>(displayA.value);
    }
    if (displayB.present) {
      map['display_b'] = Variable<int>(displayB.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedComparisonsCompanion(')
          ..write('zA: $zA, ')
          ..write('zB: $zB, ')
          ..write('displayA: $displayA, ')
          ..write('displayB: $displayB, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntitlementRowsTable extends EntitlementRows
    with TableInfo<$EntitlementRowsTable, EntitlementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitlementRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageIdMeta = const VerificationMeta(
    'packageId',
  );
  @override
  late final GeneratedColumn<String> packageId = GeneratedColumn<String>(
    'package_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [packageId, status, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entitlement_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntitlementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_id')) {
      context.handle(
        _packageIdMeta,
        packageId.isAcceptableOrUnknown(data['package_id']!, _packageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_packageIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageId};
  @override
  EntitlementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntitlementRow(
      packageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EntitlementRowsTable createAlias(String alias) {
    return $EntitlementRowsTable(attachedDatabase, alias);
  }
}

class EntitlementRow extends DataClass implements Insertable<EntitlementRow> {
  final String packageId;
  final String status;
  final int updatedAt;
  const EntitlementRow({
    required this.packageId,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['package_id'] = Variable<String>(packageId);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  EntitlementRowsCompanion toCompanion(bool nullToAbsent) {
    return EntitlementRowsCompanion(
      packageId: Value(packageId),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory EntitlementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntitlementRow(
      packageId: serializer.fromJson<String>(json['packageId']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packageId': serializer.toJson<String>(packageId),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  EntitlementRow copyWith({
    String? packageId,
    String? status,
    int? updatedAt,
  }) => EntitlementRow(
    packageId: packageId ?? this.packageId,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EntitlementRow copyWithCompanion(EntitlementRowsCompanion data) {
    return EntitlementRow(
      packageId: data.packageId.present ? data.packageId.value : this.packageId,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntitlementRow(')
          ..write('packageId: $packageId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(packageId, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntitlementRow &&
          other.packageId == this.packageId &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class EntitlementRowsCompanion extends UpdateCompanion<EntitlementRow> {
  final Value<String> packageId;
  final Value<String> status;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const EntitlementRowsCompanion({
    this.packageId = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitlementRowsCompanion.insert({
    required String packageId,
    required String status,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : packageId = Value(packageId),
       status = Value(status),
       updatedAt = Value(updatedAt);
  static Insertable<EntitlementRow> custom({
    Expression<String>? packageId,
    Expression<String>? status,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageId != null) 'package_id': packageId,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitlementRowsCompanion copyWith({
    Value<String>? packageId,
    Value<String>? status,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return EntitlementRowsCompanion(
      packageId: packageId ?? this.packageId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageId.present) {
      map['package_id'] = Variable<String>(packageId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitlementRowsCompanion(')
          ..write('packageId: $packageId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LearnerDatabase extends GeneratedDatabase {
  _$LearnerDatabase(QueryExecutor e) : super(e);
  $LearnerDatabaseManager get managers => $LearnerDatabaseManager(this);
  late final $PreferenceRowsTable preferenceRows = $PreferenceRowsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $RecentsTable recents = $RecentsTable(this);
  late final $SavedComparisonsTable savedComparisons = $SavedComparisonsTable(
    this,
  );
  late final $EntitlementRowsTable entitlementRows = $EntitlementRowsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    preferenceRows,
    bookmarks,
    recents,
    savedComparisons,
    entitlementRows,
  ];
}

typedef $$PreferenceRowsTableCreateCompanionBuilder =
    PreferenceRowsCompanion Function({
      required String key,
      required String value,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$PreferenceRowsTableUpdateCompanionBuilder =
    PreferenceRowsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$PreferenceRowsTableFilterComposer
    extends Composer<_$LearnerDatabase, $PreferenceRowsTable> {
  $$PreferenceRowsTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferenceRowsTableOrderingComposer
    extends Composer<_$LearnerDatabase, $PreferenceRowsTable> {
  $$PreferenceRowsTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferenceRowsTableAnnotationComposer
    extends Composer<_$LearnerDatabase, $PreferenceRowsTable> {
  $$PreferenceRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PreferenceRowsTableTableManager
    extends
        RootTableManager<
          _$LearnerDatabase,
          $PreferenceRowsTable,
          PreferenceRow,
          $$PreferenceRowsTableFilterComposer,
          $$PreferenceRowsTableOrderingComposer,
          $$PreferenceRowsTableAnnotationComposer,
          $$PreferenceRowsTableCreateCompanionBuilder,
          $$PreferenceRowsTableUpdateCompanionBuilder,
          (
            PreferenceRow,
            BaseReferences<
              _$LearnerDatabase,
              $PreferenceRowsTable,
              PreferenceRow
            >,
          ),
          PreferenceRow,
          PrefetchHooks Function()
        > {
  $$PreferenceRowsTableTableManager(
    _$LearnerDatabase db,
    $PreferenceRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferenceRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferenceRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferenceRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreferenceRowsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PreferenceRowsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferenceRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LearnerDatabase,
      $PreferenceRowsTable,
      PreferenceRow,
      $$PreferenceRowsTableFilterComposer,
      $$PreferenceRowsTableOrderingComposer,
      $$PreferenceRowsTableAnnotationComposer,
      $$PreferenceRowsTableCreateCompanionBuilder,
      $$PreferenceRowsTableUpdateCompanionBuilder,
      (
        PreferenceRow,
        BaseReferences<_$LearnerDatabase, $PreferenceRowsTable, PreferenceRow>,
      ),
      PreferenceRow,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({Value<int> z, required int createdAt});
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({Value<int> z, Value<int> createdAt});

class $$BookmarksTableFilterComposer
    extends Composer<_$LearnerDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get z => $composableBuilder(
    column: $table.z,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$LearnerDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get z => $composableBuilder(
    column: $table.z,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$LearnerDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get z =>
      $composableBuilder(column: $table.z, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$LearnerDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (
            Bookmark,
            BaseReferences<_$LearnerDatabase, $BookmarksTable, Bookmark>,
          ),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$LearnerDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> z = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => BookmarksCompanion(z: z, createdAt: createdAt),
          createCompanionCallback:
              ({Value<int> z = const Value.absent(), required int createdAt}) =>
                  BookmarksCompanion.insert(z: z, createdAt: createdAt),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$LearnerDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$LearnerDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$RecentsTableCreateCompanionBuilder =
    RecentsCompanion Function({Value<int> z, required int viewedAt});
typedef $$RecentsTableUpdateCompanionBuilder =
    RecentsCompanion Function({Value<int> z, Value<int> viewedAt});

class $$RecentsTableFilterComposer
    extends Composer<_$LearnerDatabase, $RecentsTable> {
  $$RecentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get z => $composableBuilder(
    column: $table.z,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecentsTableOrderingComposer
    extends Composer<_$LearnerDatabase, $RecentsTable> {
  $$RecentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get z => $composableBuilder(
    column: $table.z,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentsTableAnnotationComposer
    extends Composer<_$LearnerDatabase, $RecentsTable> {
  $$RecentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get z =>
      $composableBuilder(column: $table.z, builder: (column) => column);

  GeneratedColumn<int> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$RecentsTableTableManager
    extends
        RootTableManager<
          _$LearnerDatabase,
          $RecentsTable,
          Recent,
          $$RecentsTableFilterComposer,
          $$RecentsTableOrderingComposer,
          $$RecentsTableAnnotationComposer,
          $$RecentsTableCreateCompanionBuilder,
          $$RecentsTableUpdateCompanionBuilder,
          (Recent, BaseReferences<_$LearnerDatabase, $RecentsTable, Recent>),
          Recent,
          PrefetchHooks Function()
        > {
  $$RecentsTableTableManager(_$LearnerDatabase db, $RecentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> z = const Value.absent(),
                Value<int> viewedAt = const Value.absent(),
              }) => RecentsCompanion(z: z, viewedAt: viewedAt),
          createCompanionCallback:
              ({Value<int> z = const Value.absent(), required int viewedAt}) =>
                  RecentsCompanion.insert(z: z, viewedAt: viewedAt),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LearnerDatabase,
      $RecentsTable,
      Recent,
      $$RecentsTableFilterComposer,
      $$RecentsTableOrderingComposer,
      $$RecentsTableAnnotationComposer,
      $$RecentsTableCreateCompanionBuilder,
      $$RecentsTableUpdateCompanionBuilder,
      (Recent, BaseReferences<_$LearnerDatabase, $RecentsTable, Recent>),
      Recent,
      PrefetchHooks Function()
    >;
typedef $$SavedComparisonsTableCreateCompanionBuilder =
    SavedComparisonsCompanion Function({
      required int zA,
      required int zB,
      required int displayA,
      required int displayB,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$SavedComparisonsTableUpdateCompanionBuilder =
    SavedComparisonsCompanion Function({
      Value<int> zA,
      Value<int> zB,
      Value<int> displayA,
      Value<int> displayB,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$SavedComparisonsTableFilterComposer
    extends Composer<_$LearnerDatabase, $SavedComparisonsTable> {
  $$SavedComparisonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get zA => $composableBuilder(
    column: $table.zA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get zB => $composableBuilder(
    column: $table.zB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayA => $composableBuilder(
    column: $table.displayA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayB => $composableBuilder(
    column: $table.displayB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedComparisonsTableOrderingComposer
    extends Composer<_$LearnerDatabase, $SavedComparisonsTable> {
  $$SavedComparisonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get zA => $composableBuilder(
    column: $table.zA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get zB => $composableBuilder(
    column: $table.zB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayA => $composableBuilder(
    column: $table.displayA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayB => $composableBuilder(
    column: $table.displayB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedComparisonsTableAnnotationComposer
    extends Composer<_$LearnerDatabase, $SavedComparisonsTable> {
  $$SavedComparisonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get zA =>
      $composableBuilder(column: $table.zA, builder: (column) => column);

  GeneratedColumn<int> get zB =>
      $composableBuilder(column: $table.zB, builder: (column) => column);

  GeneratedColumn<int> get displayA =>
      $composableBuilder(column: $table.displayA, builder: (column) => column);

  GeneratedColumn<int> get displayB =>
      $composableBuilder(column: $table.displayB, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SavedComparisonsTableTableManager
    extends
        RootTableManager<
          _$LearnerDatabase,
          $SavedComparisonsTable,
          SavedComparison,
          $$SavedComparisonsTableFilterComposer,
          $$SavedComparisonsTableOrderingComposer,
          $$SavedComparisonsTableAnnotationComposer,
          $$SavedComparisonsTableCreateCompanionBuilder,
          $$SavedComparisonsTableUpdateCompanionBuilder,
          (
            SavedComparison,
            BaseReferences<
              _$LearnerDatabase,
              $SavedComparisonsTable,
              SavedComparison
            >,
          ),
          SavedComparison,
          PrefetchHooks Function()
        > {
  $$SavedComparisonsTableTableManager(
    _$LearnerDatabase db,
    $SavedComparisonsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedComparisonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedComparisonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedComparisonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> zA = const Value.absent(),
                Value<int> zB = const Value.absent(),
                Value<int> displayA = const Value.absent(),
                Value<int> displayB = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedComparisonsCompanion(
                zA: zA,
                zB: zB,
                displayA: displayA,
                displayB: displayB,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int zA,
                required int zB,
                required int displayA,
                required int displayB,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedComparisonsCompanion.insert(
                zA: zA,
                zB: zB,
                displayA: displayA,
                displayB: displayB,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedComparisonsTableProcessedTableManager =
    ProcessedTableManager<
      _$LearnerDatabase,
      $SavedComparisonsTable,
      SavedComparison,
      $$SavedComparisonsTableFilterComposer,
      $$SavedComparisonsTableOrderingComposer,
      $$SavedComparisonsTableAnnotationComposer,
      $$SavedComparisonsTableCreateCompanionBuilder,
      $$SavedComparisonsTableUpdateCompanionBuilder,
      (
        SavedComparison,
        BaseReferences<
          _$LearnerDatabase,
          $SavedComparisonsTable,
          SavedComparison
        >,
      ),
      SavedComparison,
      PrefetchHooks Function()
    >;
typedef $$EntitlementRowsTableCreateCompanionBuilder =
    EntitlementRowsCompanion Function({
      required String packageId,
      required String status,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$EntitlementRowsTableUpdateCompanionBuilder =
    EntitlementRowsCompanion Function({
      Value<String> packageId,
      Value<String> status,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$EntitlementRowsTableFilterComposer
    extends Composer<_$LearnerDatabase, $EntitlementRowsTable> {
  $$EntitlementRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageId => $composableBuilder(
    column: $table.packageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EntitlementRowsTableOrderingComposer
    extends Composer<_$LearnerDatabase, $EntitlementRowsTable> {
  $$EntitlementRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageId => $composableBuilder(
    column: $table.packageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntitlementRowsTableAnnotationComposer
    extends Composer<_$LearnerDatabase, $EntitlementRowsTable> {
  $$EntitlementRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageId =>
      $composableBuilder(column: $table.packageId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EntitlementRowsTableTableManager
    extends
        RootTableManager<
          _$LearnerDatabase,
          $EntitlementRowsTable,
          EntitlementRow,
          $$EntitlementRowsTableFilterComposer,
          $$EntitlementRowsTableOrderingComposer,
          $$EntitlementRowsTableAnnotationComposer,
          $$EntitlementRowsTableCreateCompanionBuilder,
          $$EntitlementRowsTableUpdateCompanionBuilder,
          (
            EntitlementRow,
            BaseReferences<
              _$LearnerDatabase,
              $EntitlementRowsTable,
              EntitlementRow
            >,
          ),
          EntitlementRow,
          PrefetchHooks Function()
        > {
  $$EntitlementRowsTableTableManager(
    _$LearnerDatabase db,
    $EntitlementRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitlementRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitlementRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitlementRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> packageId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitlementRowsCompanion(
                packageId: packageId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packageId,
                required String status,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EntitlementRowsCompanion.insert(
                packageId: packageId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EntitlementRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$LearnerDatabase,
      $EntitlementRowsTable,
      EntitlementRow,
      $$EntitlementRowsTableFilterComposer,
      $$EntitlementRowsTableOrderingComposer,
      $$EntitlementRowsTableAnnotationComposer,
      $$EntitlementRowsTableCreateCompanionBuilder,
      $$EntitlementRowsTableUpdateCompanionBuilder,
      (
        EntitlementRow,
        BaseReferences<
          _$LearnerDatabase,
          $EntitlementRowsTable,
          EntitlementRow
        >,
      ),
      EntitlementRow,
      PrefetchHooks Function()
    >;

class $LearnerDatabaseManager {
  final _$LearnerDatabase _db;
  $LearnerDatabaseManager(this._db);
  $$PreferenceRowsTableTableManager get preferenceRows =>
      $$PreferenceRowsTableTableManager(_db, _db.preferenceRows);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$RecentsTableTableManager get recents =>
      $$RecentsTableTableManager(_db, _db.recents);
  $$SavedComparisonsTableTableManager get savedComparisons =>
      $$SavedComparisonsTableTableManager(_db, _db.savedComparisons);
  $$EntitlementRowsTableTableManager get entitlementRows =>
      $$EntitlementRowsTableTableManager(_db, _db.entitlementRows);
}

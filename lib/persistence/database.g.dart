// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeframeMeta =
      const VerificationMeta('timeframe');
  @override
  late final GeneratedColumn<int> timeframe = GeneratedColumn<int>(
      'timeframe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completionRuleTypeMeta =
      const VerificationMeta('completionRuleType');
  @override
  late final GeneratedColumn<int> completionRuleType = GeneratedColumn<int>(
      'completion_rule_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _metricTypeMeta =
      const VerificationMeta('metricType');
  @override
  late final GeneratedColumn<int> metricType = GeneratedColumn<int>(
      'metric_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _metricUnitMeta =
      const VerificationMeta('metricUnit');
  @override
  late final GeneratedColumn<String> metricUnit = GeneratedColumn<String>(
      'metric_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metricTargetMeta =
      const VerificationMeta('metricTarget');
  @override
  late final GeneratedColumn<double> metricTarget = GeneratedColumn<double>(
      'metric_target', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        timeframe,
        completionRuleType,
        metricType,
        metricUnit,
        metricTarget,
        isCompleted,
        positionX,
        positionY,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<TaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('timeframe')) {
      context.handle(_timeframeMeta,
          timeframe.isAcceptableOrUnknown(data['timeframe']!, _timeframeMeta));
    } else if (isInserting) {
      context.missing(_timeframeMeta);
    }
    if (data.containsKey('completion_rule_type')) {
      context.handle(
          _completionRuleTypeMeta,
          completionRuleType.isAcceptableOrUnknown(
              data['completion_rule_type']!, _completionRuleTypeMeta));
    } else if (isInserting) {
      context.missing(_completionRuleTypeMeta);
    }
    if (data.containsKey('metric_type')) {
      context.handle(
          _metricTypeMeta,
          metricType.isAcceptableOrUnknown(
              data['metric_type']!, _metricTypeMeta));
    } else if (isInserting) {
      context.missing(_metricTypeMeta);
    }
    if (data.containsKey('metric_unit')) {
      context.handle(
          _metricUnitMeta,
          metricUnit.isAcceptableOrUnknown(
              data['metric_unit']!, _metricUnitMeta));
    }
    if (data.containsKey('metric_target')) {
      context.handle(
          _metricTargetMeta,
          metricTarget.isAcceptableOrUnknown(
              data['metric_target']!, _metricTargetMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      timeframe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timeframe'])!,
      completionRuleType: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}completion_rule_type'])!,
      metricType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}metric_type'])!,
      metricUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_unit']),
      metricTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}metric_target']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final String id;
  final String title;
  final String? description;
  final int timeframe;
  final int completionRuleType;
  final int metricType;
  final String? metricUnit;
  final double? metricTarget;
  final bool isCompleted;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TaskData(
      {required this.id,
      required this.title,
      this.description,
      required this.timeframe,
      required this.completionRuleType,
      required this.metricType,
      this.metricUnit,
      this.metricTarget,
      required this.isCompleted,
      required this.positionX,
      required this.positionY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['timeframe'] = Variable<int>(timeframe);
    map['completion_rule_type'] = Variable<int>(completionRuleType);
    map['metric_type'] = Variable<int>(metricType);
    if (!nullToAbsent || metricUnit != null) {
      map['metric_unit'] = Variable<String>(metricUnit);
    }
    if (!nullToAbsent || metricTarget != null) {
      map['metric_target'] = Variable<double>(metricTarget);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      timeframe: Value(timeframe),
      completionRuleType: Value(completionRuleType),
      metricType: Value(metricType),
      metricUnit: metricUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(metricUnit),
      metricTarget: metricTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(metricTarget),
      isCompleted: Value(isCompleted),
      positionX: Value(positionX),
      positionY: Value(positionY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      timeframe: serializer.fromJson<int>(json['timeframe']),
      completionRuleType: serializer.fromJson<int>(json['completionRuleType']),
      metricType: serializer.fromJson<int>(json['metricType']),
      metricUnit: serializer.fromJson<String?>(json['metricUnit']),
      metricTarget: serializer.fromJson<double?>(json['metricTarget']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'timeframe': serializer.toJson<int>(timeframe),
      'completionRuleType': serializer.toJson<int>(completionRuleType),
      'metricType': serializer.toJson<int>(metricType),
      'metricUnit': serializer.toJson<String?>(metricUnit),
      'metricTarget': serializer.toJson<double?>(metricTarget),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TaskData copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          int? timeframe,
          int? completionRuleType,
          int? metricType,
          Value<String?> metricUnit = const Value.absent(),
          Value<double?> metricTarget = const Value.absent(),
          bool? isCompleted,
          double? positionX,
          double? positionY,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TaskData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        timeframe: timeframe ?? this.timeframe,
        completionRuleType: completionRuleType ?? this.completionRuleType,
        metricType: metricType ?? this.metricType,
        metricUnit: metricUnit.present ? metricUnit.value : this.metricUnit,
        metricTarget:
            metricTarget.present ? metricTarget.value : this.metricTarget,
        isCompleted: isCompleted ?? this.isCompleted,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TaskData copyWithCompanion(TasksCompanion data) {
    return TaskData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      timeframe: data.timeframe.present ? data.timeframe.value : this.timeframe,
      completionRuleType: data.completionRuleType.present
          ? data.completionRuleType.value
          : this.completionRuleType,
      metricType:
          data.metricType.present ? data.metricType.value : this.metricType,
      metricUnit:
          data.metricUnit.present ? data.metricUnit.value : this.metricUnit,
      metricTarget: data.metricTarget.present
          ? data.metricTarget.value
          : this.metricTarget,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('timeframe: $timeframe, ')
          ..write('completionRuleType: $completionRuleType, ')
          ..write('metricType: $metricType, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('metricTarget: $metricTarget, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      timeframe,
      completionRuleType,
      metricType,
      metricUnit,
      metricTarget,
      isCompleted,
      positionX,
      positionY,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.timeframe == this.timeframe &&
          other.completionRuleType == this.completionRuleType &&
          other.metricType == this.metricType &&
          other.metricUnit == this.metricUnit &&
          other.metricTarget == this.metricTarget &&
          other.isCompleted == this.isCompleted &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<TaskData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> timeframe;
  final Value<int> completionRuleType;
  final Value<int> metricType;
  final Value<String?> metricUnit;
  final Value<double?> metricTarget;
  final Value<bool> isCompleted;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.timeframe = const Value.absent(),
    this.completionRuleType = const Value.absent(),
    this.metricType = const Value.absent(),
    this.metricUnit = const Value.absent(),
    this.metricTarget = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required int timeframe,
    required int completionRuleType,
    required int metricType,
    this.metricUnit = const Value.absent(),
    this.metricTarget = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        timeframe = Value(timeframe),
        completionRuleType = Value(completionRuleType),
        metricType = Value(metricType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TaskData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? timeframe,
    Expression<int>? completionRuleType,
    Expression<int>? metricType,
    Expression<String>? metricUnit,
    Expression<double>? metricTarget,
    Expression<bool>? isCompleted,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (timeframe != null) 'timeframe': timeframe,
      if (completionRuleType != null)
        'completion_rule_type': completionRuleType,
      if (metricType != null) 'metric_type': metricType,
      if (metricUnit != null) 'metric_unit': metricUnit,
      if (metricTarget != null) 'metric_target': metricTarget,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<int>? timeframe,
      Value<int>? completionRuleType,
      Value<int>? metricType,
      Value<String?>? metricUnit,
      Value<double?>? metricTarget,
      Value<bool>? isCompleted,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeframe: timeframe ?? this.timeframe,
      completionRuleType: completionRuleType ?? this.completionRuleType,
      metricType: metricType ?? this.metricType,
      metricUnit: metricUnit ?? this.metricUnit,
      metricTarget: metricTarget ?? this.metricTarget,
      isCompleted: isCompleted ?? this.isCompleted,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timeframe.present) {
      map['timeframe'] = Variable<int>(timeframe.value);
    }
    if (completionRuleType.present) {
      map['completion_rule_type'] = Variable<int>(completionRuleType.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<int>(metricType.value);
    }
    if (metricUnit.present) {
      map['metric_unit'] = Variable<String>(metricUnit.value);
    }
    if (metricTarget.present) {
      map['metric_target'] = Variable<double>(metricTarget.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('timeframe: $timeframe, ')
          ..write('completionRuleType: $completionRuleType, ')
          ..write('metricType: $metricType, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('metricTarget: $metricTarget, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeframeMeta =
      const VerificationMeta('timeframe');
  @override
  late final GeneratedColumn<int> timeframe = GeneratedColumn<int>(
      'timeframe', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _metricTypeMeta =
      const VerificationMeta('metricType');
  @override
  late final GeneratedColumn<int> metricType = GeneratedColumn<int>(
      'metric_type', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _metricUnitMeta =
      const VerificationMeta('metricUnit');
  @override
  late final GeneratedColumn<String> metricUnit = GeneratedColumn<String>(
      'metric_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metricTargetMeta =
      const VerificationMeta('metricTarget');
  @override
  late final GeneratedColumn<double> metricTarget = GeneratedColumn<double>(
      'metric_target', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        timeframe,
        metricType,
        metricUnit,
        metricTarget,
        positionX,
        positionY,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<GoalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('timeframe')) {
      context.handle(_timeframeMeta,
          timeframe.isAcceptableOrUnknown(data['timeframe']!, _timeframeMeta));
    }
    if (data.containsKey('metric_type')) {
      context.handle(
          _metricTypeMeta,
          metricType.isAcceptableOrUnknown(
              data['metric_type']!, _metricTypeMeta));
    }
    if (data.containsKey('metric_unit')) {
      context.handle(
          _metricUnitMeta,
          metricUnit.isAcceptableOrUnknown(
              data['metric_unit']!, _metricUnitMeta));
    }
    if (data.containsKey('metric_target')) {
      context.handle(
          _metricTargetMeta,
          metricTarget.isAcceptableOrUnknown(
              data['metric_target']!, _metricTargetMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      timeframe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timeframe']),
      metricType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}metric_type']),
      metricUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_unit']),
      metricTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}metric_target']),
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class GoalData extends DataClass implements Insertable<GoalData> {
  final String id;
  final String name;
  final String? description;
  final int? timeframe;
  final int? metricType;
  final String? metricUnit;
  final double? metricTarget;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GoalData(
      {required this.id,
      required this.name,
      this.description,
      this.timeframe,
      this.metricType,
      this.metricUnit,
      this.metricTarget,
      required this.positionX,
      required this.positionY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || timeframe != null) {
      map['timeframe'] = Variable<int>(timeframe);
    }
    if (!nullToAbsent || metricType != null) {
      map['metric_type'] = Variable<int>(metricType);
    }
    if (!nullToAbsent || metricUnit != null) {
      map['metric_unit'] = Variable<String>(metricUnit);
    }
    if (!nullToAbsent || metricTarget != null) {
      map['metric_target'] = Variable<double>(metricTarget);
    }
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      timeframe: timeframe == null && nullToAbsent
          ? const Value.absent()
          : Value(timeframe),
      metricType: metricType == null && nullToAbsent
          ? const Value.absent()
          : Value(metricType),
      metricUnit: metricUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(metricUnit),
      metricTarget: metricTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(metricTarget),
      positionX: Value(positionX),
      positionY: Value(positionY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      timeframe: serializer.fromJson<int?>(json['timeframe']),
      metricType: serializer.fromJson<int?>(json['metricType']),
      metricUnit: serializer.fromJson<String?>(json['metricUnit']),
      metricTarget: serializer.fromJson<double?>(json['metricTarget']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'timeframe': serializer.toJson<int?>(timeframe),
      'metricType': serializer.toJson<int?>(metricType),
      'metricUnit': serializer.toJson<String?>(metricUnit),
      'metricTarget': serializer.toJson<double?>(metricTarget),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GoalData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<int?> timeframe = const Value.absent(),
          Value<int?> metricType = const Value.absent(),
          Value<String?> metricUnit = const Value.absent(),
          Value<double?> metricTarget = const Value.absent(),
          double? positionX,
          double? positionY,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GoalData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        timeframe: timeframe.present ? timeframe.value : this.timeframe,
        metricType: metricType.present ? metricType.value : this.metricType,
        metricUnit: metricUnit.present ? metricUnit.value : this.metricUnit,
        metricTarget:
            metricTarget.present ? metricTarget.value : this.metricTarget,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GoalData copyWithCompanion(GoalsCompanion data) {
    return GoalData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      timeframe: data.timeframe.present ? data.timeframe.value : this.timeframe,
      metricType:
          data.metricType.present ? data.metricType.value : this.metricType,
      metricUnit:
          data.metricUnit.present ? data.metricUnit.value : this.metricUnit,
      metricTarget: data.metricTarget.present
          ? data.metricTarget.value
          : this.metricTarget,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('timeframe: $timeframe, ')
          ..write('metricType: $metricType, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('metricTarget: $metricTarget, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, timeframe, metricType,
      metricUnit, metricTarget, positionX, positionY, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.timeframe == this.timeframe &&
          other.metricType == this.metricType &&
          other.metricUnit == this.metricUnit &&
          other.metricTarget == this.metricTarget &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalsCompanion extends UpdateCompanion<GoalData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> timeframe;
  final Value<int?> metricType;
  final Value<String?> metricUnit;
  final Value<double?> metricTarget;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.timeframe = const Value.absent(),
    this.metricType = const Value.absent(),
    this.metricUnit = const Value.absent(),
    this.metricTarget = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.timeframe = const Value.absent(),
    this.metricType = const Value.absent(),
    this.metricUnit = const Value.absent(),
    this.metricTarget = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GoalData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? timeframe,
    Expression<int>? metricType,
    Expression<String>? metricUnit,
    Expression<double>? metricTarget,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (timeframe != null) 'timeframe': timeframe,
      if (metricType != null) 'metric_type': metricType,
      if (metricUnit != null) 'metric_unit': metricUnit,
      if (metricTarget != null) 'metric_target': metricTarget,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int?>? timeframe,
      Value<int?>? metricType,
      Value<String?>? metricUnit,
      Value<double?>? metricTarget,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return GoalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timeframe: timeframe ?? this.timeframe,
      metricType: metricType ?? this.metricType,
      metricUnit: metricUnit ?? this.metricUnit,
      metricTarget: metricTarget ?? this.metricTarget,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timeframe.present) {
      map['timeframe'] = Variable<int>(timeframe.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<int>(metricType.value);
    }
    if (metricUnit.present) {
      map['metric_unit'] = Variable<String>(metricUnit.value);
    }
    if (metricTarget.present) {
      map['metric_target'] = Variable<double>(metricTarget.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('timeframe: $timeframe, ')
          ..write('metricType: $metricType, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('metricTarget: $metricTarget, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListsTable extends Lists with TableInfo<$ListsTable, ProgressListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, description, positionX, positionY, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lists';
  @override
  VerificationContext validateIntegrity(Insertable<ProgressListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ListsTable createAlias(String alias) {
    return $ListsTable(attachedDatabase, alias);
  }
}

class ProgressListData extends DataClass
    implements Insertable<ProgressListData> {
  final String id;
  final String name;
  final String? type;
  final String? description;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProgressListData(
      {required this.id,
      required this.name,
      this.type,
      this.description,
      required this.positionX,
      required this.positionY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ListsCompanion toCompanion(bool nullToAbsent) {
    return ListsCompanion(
      id: Value(id),
      name: Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      positionX: Value(positionX),
      positionY: Value(positionY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProgressListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressListData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String?>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String?>(type),
      'description': serializer.toJson<String?>(description),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProgressListData copyWith(
          {String? id,
          String? name,
          Value<String?> type = const Value.absent(),
          Value<String?> description = const Value.absent(),
          double? positionX,
          double? positionY,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ProgressListData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type.present ? type.value : this.type,
        description: description.present ? description.value : this.description,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ProgressListData copyWithCompanion(ListsCompanion data) {
    return ProgressListData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      description:
          data.description.present ? data.description.value : this.description,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressListData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, type, description, positionX, positionY, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressListData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.description == this.description &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ListsCompanion extends UpdateCompanion<ProgressListData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> type;
  final Value<String?> description;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ListsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ListsCompanion.insert({
    required String id,
    required String name,
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ProgressListData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? description,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ListsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? type,
      Value<String?>? description,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ListsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListItemsTable extends ListItems
    with TableInfo<$ListItemsTable, ListItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _listIdMeta = const VerificationMeta('listId');
  @override
  late final GeneratedColumn<String> listId = GeneratedColumn<String>(
      'list_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        listId,
        title,
        notes,
        metadata,
        isCompleted,
        positionX,
        positionY,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'list_items';
  @override
  VerificationContext validateIntegrity(Insertable<ListItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('list_id')) {
      context.handle(_listIdMeta,
          listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta));
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      listId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}list_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ListItemsTable createAlias(String alias) {
    return $ListItemsTable(attachedDatabase, alias);
  }
}

class ListItem extends DataClass implements Insertable<ListItem> {
  final String id;
  final String listId;
  final String title;
  final String? notes;
  final String metadata;
  final bool isCompleted;
  final double positionX;
  final double positionY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ListItem(
      {required this.id,
      required this.listId,
      required this.title,
      this.notes,
      required this.metadata,
      required this.isCompleted,
      required this.positionX,
      required this.positionY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['list_id'] = Variable<String>(listId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['metadata'] = Variable<String>(metadata);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ListItemsCompanion toCompanion(bool nullToAbsent) {
    return ListItemsCompanion(
      id: Value(id),
      listId: Value(listId),
      title: Value(title),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      metadata: Value(metadata),
      isCompleted: Value(isCompleted),
      positionX: Value(positionX),
      positionY: Value(positionY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ListItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListItem(
      id: serializer.fromJson<String>(json['id']),
      listId: serializer.fromJson<String>(json['listId']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      metadata: serializer.fromJson<String>(json['metadata']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'listId': serializer.toJson<String>(listId),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'metadata': serializer.toJson<String>(metadata),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ListItem copyWith(
          {String? id,
          String? listId,
          String? title,
          Value<String?> notes = const Value.absent(),
          String? metadata,
          bool? isCompleted,
          double? positionX,
          double? positionY,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ListItem(
        id: id ?? this.id,
        listId: listId ?? this.listId,
        title: title ?? this.title,
        notes: notes.present ? notes.value : this.notes,
        metadata: metadata ?? this.metadata,
        isCompleted: isCompleted ?? this.isCompleted,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ListItem copyWithCompanion(ListItemsCompanion data) {
    return ListItem(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListItem(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('metadata: $metadata, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, listId, title, notes, metadata,
      isCompleted, positionX, positionY, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListItem &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.metadata == this.metadata &&
          other.isCompleted == this.isCompleted &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ListItemsCompanion extends UpdateCompanion<ListItem> {
  final Value<String> id;
  final Value<String> listId;
  final Value<String> title;
  final Value<String?> notes;
  final Value<String> metadata;
  final Value<bool> isCompleted;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ListItemsCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.metadata = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ListItemsCompanion.insert({
    required String id,
    required String listId,
    required String title,
    this.notes = const Value.absent(),
    this.metadata = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        listId = Value(listId),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ListItem> custom({
    Expression<String>? id,
    Expression<String>? listId,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? metadata,
    Expression<bool>? isCompleted,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (metadata != null) 'metadata': metadata,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ListItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? listId,
      Value<String>? title,
      Value<String?>? notes,
      Value<String>? metadata,
      Value<bool>? isCompleted,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ListItemsCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
      isCompleted: isCompleted ?? this.isCompleted,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<String>(listId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListItemsCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('metadata: $metadata, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConnectionsTable extends Connections
    with TableInfo<$ConnectionsTable, Connection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConnectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromNodeIdMeta =
      const VerificationMeta('fromNodeId');
  @override
  late final GeneratedColumn<String> fromNodeId = GeneratedColumn<String>(
      'from_node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toNodeIdMeta =
      const VerificationMeta('toNodeId');
  @override
  late final GeneratedColumn<String> toNodeId = GeneratedColumn<String>(
      'to_node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationshipTypeMeta =
      const VerificationMeta('relationshipType');
  @override
  late final GeneratedColumn<int> relationshipType = GeneratedColumn<int>(
      'relationship_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fromNodeId,
        toNodeId,
        relationshipType,
        direction,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'connections';
  @override
  VerificationContext validateIntegrity(Insertable<Connection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_node_id')) {
      context.handle(
          _fromNodeIdMeta,
          fromNodeId.isAcceptableOrUnknown(
              data['from_node_id']!, _fromNodeIdMeta));
    } else if (isInserting) {
      context.missing(_fromNodeIdMeta);
    }
    if (data.containsKey('to_node_id')) {
      context.handle(_toNodeIdMeta,
          toNodeId.isAcceptableOrUnknown(data['to_node_id']!, _toNodeIdMeta));
    } else if (isInserting) {
      context.missing(_toNodeIdMeta);
    }
    if (data.containsKey('relationship_type')) {
      context.handle(
          _relationshipTypeMeta,
          relationshipType.isAcceptableOrUnknown(
              data['relationship_type']!, _relationshipTypeMeta));
    } else if (isInserting) {
      context.missing(_relationshipTypeMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Connection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Connection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fromNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_node_id'])!,
      toNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_node_id'])!,
      relationshipType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}relationship_type'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ConnectionsTable createAlias(String alias) {
    return $ConnectionsTable(attachedDatabase, alias);
  }
}

class Connection extends DataClass implements Insertable<Connection> {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final int relationshipType;
  final String? direction;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Connection(
      {required this.id,
      required this.fromNodeId,
      required this.toNodeId,
      required this.relationshipType,
      this.direction,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_node_id'] = Variable<String>(fromNodeId);
    map['to_node_id'] = Variable<String>(toNodeId);
    map['relationship_type'] = Variable<int>(relationshipType);
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<String>(direction);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConnectionsCompanion toCompanion(bool nullToAbsent) {
    return ConnectionsCompanion(
      id: Value(id),
      fromNodeId: Value(fromNodeId),
      toNodeId: Value(toNodeId),
      relationshipType: Value(relationshipType),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Connection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Connection(
      id: serializer.fromJson<String>(json['id']),
      fromNodeId: serializer.fromJson<String>(json['fromNodeId']),
      toNodeId: serializer.fromJson<String>(json['toNodeId']),
      relationshipType: serializer.fromJson<int>(json['relationshipType']),
      direction: serializer.fromJson<String?>(json['direction']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromNodeId': serializer.toJson<String>(fromNodeId),
      'toNodeId': serializer.toJson<String>(toNodeId),
      'relationshipType': serializer.toJson<int>(relationshipType),
      'direction': serializer.toJson<String?>(direction),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Connection copyWith(
          {String? id,
          String? fromNodeId,
          String? toNodeId,
          int? relationshipType,
          Value<String?> direction = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Connection(
        id: id ?? this.id,
        fromNodeId: fromNodeId ?? this.fromNodeId,
        toNodeId: toNodeId ?? this.toNodeId,
        relationshipType: relationshipType ?? this.relationshipType,
        direction: direction.present ? direction.value : this.direction,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Connection copyWithCompanion(ConnectionsCompanion data) {
    return Connection(
      id: data.id.present ? data.id.value : this.id,
      fromNodeId:
          data.fromNodeId.present ? data.fromNodeId.value : this.fromNodeId,
      toNodeId: data.toNodeId.present ? data.toNodeId.value : this.toNodeId,
      relationshipType: data.relationshipType.present
          ? data.relationshipType.value
          : this.relationshipType,
      direction: data.direction.present ? data.direction.value : this.direction,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Connection(')
          ..write('id: $id, ')
          ..write('fromNodeId: $fromNodeId, ')
          ..write('toNodeId: $toNodeId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('direction: $direction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fromNodeId, toNodeId, relationshipType,
      direction, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Connection &&
          other.id == this.id &&
          other.fromNodeId == this.fromNodeId &&
          other.toNodeId == this.toNodeId &&
          other.relationshipType == this.relationshipType &&
          other.direction == this.direction &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConnectionsCompanion extends UpdateCompanion<Connection> {
  final Value<String> id;
  final Value<String> fromNodeId;
  final Value<String> toNodeId;
  final Value<int> relationshipType;
  final Value<String?> direction;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ConnectionsCompanion({
    this.id = const Value.absent(),
    this.fromNodeId = const Value.absent(),
    this.toNodeId = const Value.absent(),
    this.relationshipType = const Value.absent(),
    this.direction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConnectionsCompanion.insert({
    required String id,
    required String fromNodeId,
    required String toNodeId,
    required int relationshipType,
    this.direction = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fromNodeId = Value(fromNodeId),
        toNodeId = Value(toNodeId),
        relationshipType = Value(relationshipType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Connection> custom({
    Expression<String>? id,
    Expression<String>? fromNodeId,
    Expression<String>? toNodeId,
    Expression<int>? relationshipType,
    Expression<String>? direction,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromNodeId != null) 'from_node_id': fromNodeId,
      if (toNodeId != null) 'to_node_id': toNodeId,
      if (relationshipType != null) 'relationship_type': relationshipType,
      if (direction != null) 'direction': direction,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConnectionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? fromNodeId,
      Value<String>? toNodeId,
      Value<int>? relationshipType,
      Value<String?>? direction,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ConnectionsCompanion(
      id: id ?? this.id,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      relationshipType: relationshipType ?? this.relationshipType,
      direction: direction ?? this.direction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromNodeId.present) {
      map['from_node_id'] = Variable<String>(fromNodeId.value);
    }
    if (toNodeId.present) {
      map['to_node_id'] = Variable<String>(toNodeId.value);
    }
    if (relationshipType.present) {
      map['relationship_type'] = Variable<int>(relationshipType.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('fromNodeId: $fromNodeId, ')
          ..write('toNodeId: $toNodeId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('direction: $direction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetricEntriesTable extends MetricEntries
    with TableInfo<$MetricEntriesTable, MetricEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetricEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _metricValueMeta =
      const VerificationMeta('metricValue');
  @override
  late final GeneratedColumn<double> metricValue = GeneratedColumn<double>(
      'metric_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _metricUnitMeta =
      const VerificationMeta('metricUnit');
  @override
  late final GeneratedColumn<String> metricUnit = GeneratedColumn<String>(
      'metric_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        timestamp,
        metricValue,
        metricUnit,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metric_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MetricEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('metric_value')) {
      context.handle(
          _metricValueMeta,
          metricValue.isAcceptableOrUnknown(
              data['metric_value']!, _metricValueMeta));
    } else if (isInserting) {
      context.missing(_metricValueMeta);
    }
    if (data.containsKey('metric_unit')) {
      context.handle(
          _metricUnitMeta,
          metricUnit.isAcceptableOrUnknown(
              data['metric_unit']!, _metricUnitMeta));
    } else if (isInserting) {
      context.missing(_metricUnitMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetricEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetricEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      metricValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}metric_value'])!,
      metricUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_unit'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MetricEntriesTable createAlias(String alias) {
    return $MetricEntriesTable(attachedDatabase, alias);
  }
}

class MetricEntry extends DataClass implements Insertable<MetricEntry> {
  final String id;
  final String taskId;
  final DateTime timestamp;
  final double metricValue;
  final String metricUnit;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MetricEntry(
      {required this.id,
      required this.taskId,
      required this.timestamp,
      required this.metricValue,
      required this.metricUnit,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['metric_value'] = Variable<double>(metricValue);
    map['metric_unit'] = Variable<String>(metricUnit);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MetricEntriesCompanion toCompanion(bool nullToAbsent) {
    return MetricEntriesCompanion(
      id: Value(id),
      taskId: Value(taskId),
      timestamp: Value(timestamp),
      metricValue: Value(metricValue),
      metricUnit: Value(metricUnit),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MetricEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetricEntry(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      metricValue: serializer.fromJson<double>(json['metricValue']),
      metricUnit: serializer.fromJson<String>(json['metricUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'metricValue': serializer.toJson<double>(metricValue),
      'metricUnit': serializer.toJson<String>(metricUnit),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MetricEntry copyWith(
          {String? id,
          String? taskId,
          DateTime? timestamp,
          double? metricValue,
          String? metricUnit,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      MetricEntry(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        timestamp: timestamp ?? this.timestamp,
        metricValue: metricValue ?? this.metricValue,
        metricUnit: metricUnit ?? this.metricUnit,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MetricEntry copyWithCompanion(MetricEntriesCompanion data) {
    return MetricEntry(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      metricValue:
          data.metricValue.present ? data.metricValue.value : this.metricValue,
      metricUnit:
          data.metricUnit.present ? data.metricUnit.value : this.metricUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetricEntry(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('timestamp: $timestamp, ')
          ..write('metricValue: $metricValue, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, timestamp, metricValue,
      metricUnit, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetricEntry &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.timestamp == this.timestamp &&
          other.metricValue == this.metricValue &&
          other.metricUnit == this.metricUnit &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MetricEntriesCompanion extends UpdateCompanion<MetricEntry> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<DateTime> timestamp;
  final Value<double> metricValue;
  final Value<String> metricUnit;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MetricEntriesCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.metricValue = const Value.absent(),
    this.metricUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetricEntriesCompanion.insert({
    required String id,
    required String taskId,
    required DateTime timestamp,
    required double metricValue,
    required String metricUnit,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        timestamp = Value(timestamp),
        metricValue = Value(metricValue),
        metricUnit = Value(metricUnit),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MetricEntry> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<DateTime>? timestamp,
    Expression<double>? metricValue,
    Expression<String>? metricUnit,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (timestamp != null) 'timestamp': timestamp,
      if (metricValue != null) 'metric_value': metricValue,
      if (metricUnit != null) 'metric_unit': metricUnit,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetricEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<DateTime>? timestamp,
      Value<double>? metricValue,
      Value<String>? metricUnit,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return MetricEntriesCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      timestamp: timestamp ?? this.timestamp,
      metricValue: metricValue ?? this.metricValue,
      metricUnit: metricUnit ?? this.metricUnit,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (metricValue.present) {
      map['metric_value'] = Variable<double>(metricValue.value);
    }
    if (metricUnit.present) {
      map['metric_unit'] = Variable<String>(metricUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetricEntriesCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('timestamp: $timestamp, ')
          ..write('metricValue: $metricValue, ')
          ..write('metricUnit: $metricUnit, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $ListsTable lists = $ListsTable(this);
  late final $ListItemsTable listItems = $ListItemsTable(this);
  late final $ConnectionsTable connections = $ConnectionsTable(this);
  late final $MetricEntriesTable metricEntries = $MetricEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, goals, lists, listItems, connections, metricEntries];
}

typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  required int timeframe,
  required int completionRuleType,
  required int metricType,
  Value<String?> metricUnit,
  Value<double?> metricTarget,
  Value<bool> isCompleted,
  Value<double> positionX,
  Value<double> positionY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<int> timeframe,
  Value<int> completionRuleType,
  Value<int> metricType,
  Value<String?> metricUnit,
  Value<double?> metricTarget,
  Value<bool> isCompleted,
  Value<double> positionX,
  Value<double> positionY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completionRuleType => $composableBuilder(
      column: $table.completionRuleType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completionRuleType => $composableBuilder(
      column: $table.completionRuleType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get timeframe =>
      $composableBuilder(column: $table.timeframe, builder: (column) => column);

  GeneratedColumn<int> get completionRuleType => $composableBuilder(
      column: $table.completionRuleType, builder: (column) => column);

  GeneratedColumn<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => column);

  GeneratedColumn<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => column);

  GeneratedColumn<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    TaskData,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (TaskData, BaseReferences<_$AppDatabase, $TasksTable, TaskData>),
    TaskData,
    PrefetchHooks Function()> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> timeframe = const Value.absent(),
            Value<int> completionRuleType = const Value.absent(),
            Value<int> metricType = const Value.absent(),
            Value<String?> metricUnit = const Value.absent(),
            Value<double?> metricTarget = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            description: description,
            timeframe: timeframe,
            completionRuleType: completionRuleType,
            metricType: metricType,
            metricUnit: metricUnit,
            metricTarget: metricTarget,
            isCompleted: isCompleted,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            required int timeframe,
            required int completionRuleType,
            required int metricType,
            Value<String?> metricUnit = const Value.absent(),
            Value<double?> metricTarget = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            timeframe: timeframe,
            completionRuleType: completionRuleType,
            metricType: metricType,
            metricUnit: metricUnit,
            metricTarget: metricTarget,
            isCompleted: isCompleted,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    TaskData,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (TaskData, BaseReferences<_$AppDatabase, $TasksTable, TaskData>),
    TaskData,
    PrefetchHooks Function()>;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<int?> timeframe,
  Value<int?> metricType,
  Value<String?> metricUnit,
  Value<double?> metricTarget,
  Value<double> positionX,
  Value<double> positionY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<int?> timeframe,
  Value<int?> metricType,
  Value<String?> metricUnit,
  Value<double?> metricTarget,
  Value<double> positionX,
  Value<double> positionY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get timeframe =>
      $composableBuilder(column: $table.timeframe, builder: (column) => column);

  GeneratedColumn<int> get metricType => $composableBuilder(
      column: $table.metricType, builder: (column) => column);

  GeneratedColumn<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => column);

  GeneratedColumn<double> get metricTarget => $composableBuilder(
      column: $table.metricTarget, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    GoalData,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (GoalData, BaseReferences<_$AppDatabase, $GoalsTable, GoalData>),
    GoalData,
    PrefetchHooks Function()> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> timeframe = const Value.absent(),
            Value<int?> metricType = const Value.absent(),
            Value<String?> metricUnit = const Value.absent(),
            Value<double?> metricTarget = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            name: name,
            description: description,
            timeframe: timeframe,
            metricType: metricType,
            metricUnit: metricUnit,
            metricTarget: metricTarget,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<int?> timeframe = const Value.absent(),
            Value<int?> metricType = const Value.absent(),
            Value<String?> metricUnit = const Value.absent(),
            Value<double?> metricTarget = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            name: name,
            description: description,
            timeframe: timeframe,
            metricType: metricType,
            metricUnit: metricUnit,
            metricTarget: metricTarget,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    GoalData,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (GoalData, BaseReferences<_$AppDatabase, $GoalsTable, GoalData>),
    GoalData,
    PrefetchHooks Function()>;
typedef $$ListsTableCreateCompanionBuilder = ListsCompanion Function({
  required String id,
  required String name,
  Value<String?> type,
  Value<String?> description,
  Value<double> positionX,
  Value<double> positionY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ListsTableUpdateCompanionBuilder = ListsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> type,
  Value<String?> description,
  Value<double> positionX,
  Value<double> positionY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ListsTableFilterComposer extends Composer<_$AppDatabase, $ListsTable> {
  $$ListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ListsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListsTable> {
  $$ListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ListsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListsTable> {
  $$ListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ListsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ListsTable,
    ProgressListData,
    $$ListsTableFilterComposer,
    $$ListsTableOrderingComposer,
    $$ListsTableAnnotationComposer,
    $$ListsTableCreateCompanionBuilder,
    $$ListsTableUpdateCompanionBuilder,
    (
      ProgressListData,
      BaseReferences<_$AppDatabase, $ListsTable, ProgressListData>
    ),
    ProgressListData,
    PrefetchHooks Function()> {
  $$ListsTableTableManager(_$AppDatabase db, $ListsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ListsCompanion(
            id: id,
            name: name,
            type: type,
            description: description,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> type = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ListsCompanion.insert(
            id: id,
            name: name,
            type: type,
            description: description,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ListsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ListsTable,
    ProgressListData,
    $$ListsTableFilterComposer,
    $$ListsTableOrderingComposer,
    $$ListsTableAnnotationComposer,
    $$ListsTableCreateCompanionBuilder,
    $$ListsTableUpdateCompanionBuilder,
    (
      ProgressListData,
      BaseReferences<_$AppDatabase, $ListsTable, ProgressListData>
    ),
    ProgressListData,
    PrefetchHooks Function()>;
typedef $$ListItemsTableCreateCompanionBuilder = ListItemsCompanion Function({
  required String id,
  required String listId,
  required String title,
  Value<String?> notes,
  Value<String> metadata,
  Value<bool> isCompleted,
  Value<double> positionX,
  Value<double> positionY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ListItemsTableUpdateCompanionBuilder = ListItemsCompanion Function({
  Value<String> id,
  Value<String> listId,
  Value<String> title,
  Value<String?> notes,
  Value<String> metadata,
  Value<bool> isCompleted,
  Value<double> positionX,
  Value<double> positionY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ListItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ListItemsTable> {
  $$ListItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get listId => $composableBuilder(
      column: $table.listId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ListItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListItemsTable> {
  $$ListItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get listId => $composableBuilder(
      column: $table.listId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ListItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListItemsTable> {
  $$ListItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get listId =>
      $composableBuilder(column: $table.listId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ListItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ListItemsTable,
    ListItem,
    $$ListItemsTableFilterComposer,
    $$ListItemsTableOrderingComposer,
    $$ListItemsTableAnnotationComposer,
    $$ListItemsTableCreateCompanionBuilder,
    $$ListItemsTableUpdateCompanionBuilder,
    (ListItem, BaseReferences<_$AppDatabase, $ListItemsTable, ListItem>),
    ListItem,
    PrefetchHooks Function()> {
  $$ListItemsTableTableManager(_$AppDatabase db, $ListItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> listId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ListItemsCompanion(
            id: id,
            listId: listId,
            title: title,
            notes: notes,
            metadata: metadata,
            isCompleted: isCompleted,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String listId,
            required String title,
            Value<String?> notes = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ListItemsCompanion.insert(
            id: id,
            listId: listId,
            title: title,
            notes: notes,
            metadata: metadata,
            isCompleted: isCompleted,
            positionX: positionX,
            positionY: positionY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ListItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ListItemsTable,
    ListItem,
    $$ListItemsTableFilterComposer,
    $$ListItemsTableOrderingComposer,
    $$ListItemsTableAnnotationComposer,
    $$ListItemsTableCreateCompanionBuilder,
    $$ListItemsTableUpdateCompanionBuilder,
    (ListItem, BaseReferences<_$AppDatabase, $ListItemsTable, ListItem>),
    ListItem,
    PrefetchHooks Function()>;
typedef $$ConnectionsTableCreateCompanionBuilder = ConnectionsCompanion
    Function({
  required String id,
  required String fromNodeId,
  required String toNodeId,
  required int relationshipType,
  Value<String?> direction,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ConnectionsTableUpdateCompanionBuilder = ConnectionsCompanion
    Function({
  Value<String> id,
  Value<String> fromNodeId,
  Value<String> toNodeId,
  Value<int> relationshipType,
  Value<String?> direction,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ConnectionsTableFilterComposer
    extends Composer<_$AppDatabase, $ConnectionsTable> {
  $$ConnectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toNodeId => $composableBuilder(
      column: $table.toNodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get relationshipType => $composableBuilder(
      column: $table.relationshipType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ConnectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConnectionsTable> {
  $$ConnectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toNodeId => $composableBuilder(
      column: $table.toNodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get relationshipType => $composableBuilder(
      column: $table.relationshipType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ConnectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConnectionsTable> {
  $$ConnectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => column);

  GeneratedColumn<String> get toNodeId =>
      $composableBuilder(column: $table.toNodeId, builder: (column) => column);

  GeneratedColumn<int> get relationshipType => $composableBuilder(
      column: $table.relationshipType, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConnectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConnectionsTable,
    Connection,
    $$ConnectionsTableFilterComposer,
    $$ConnectionsTableOrderingComposer,
    $$ConnectionsTableAnnotationComposer,
    $$ConnectionsTableCreateCompanionBuilder,
    $$ConnectionsTableUpdateCompanionBuilder,
    (Connection, BaseReferences<_$AppDatabase, $ConnectionsTable, Connection>),
    Connection,
    PrefetchHooks Function()> {
  $$ConnectionsTableTableManager(_$AppDatabase db, $ConnectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConnectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConnectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConnectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> fromNodeId = const Value.absent(),
            Value<String> toNodeId = const Value.absent(),
            Value<int> relationshipType = const Value.absent(),
            Value<String?> direction = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConnectionsCompanion(
            id: id,
            fromNodeId: fromNodeId,
            toNodeId: toNodeId,
            relationshipType: relationshipType,
            direction: direction,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String fromNodeId,
            required String toNodeId,
            required int relationshipType,
            Value<String?> direction = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ConnectionsCompanion.insert(
            id: id,
            fromNodeId: fromNodeId,
            toNodeId: toNodeId,
            relationshipType: relationshipType,
            direction: direction,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConnectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConnectionsTable,
    Connection,
    $$ConnectionsTableFilterComposer,
    $$ConnectionsTableOrderingComposer,
    $$ConnectionsTableAnnotationComposer,
    $$ConnectionsTableCreateCompanionBuilder,
    $$ConnectionsTableUpdateCompanionBuilder,
    (Connection, BaseReferences<_$AppDatabase, $ConnectionsTable, Connection>),
    Connection,
    PrefetchHooks Function()>;
typedef $$MetricEntriesTableCreateCompanionBuilder = MetricEntriesCompanion
    Function({
  required String id,
  required String taskId,
  required DateTime timestamp,
  required double metricValue,
  required String metricUnit,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MetricEntriesTableUpdateCompanionBuilder = MetricEntriesCompanion
    Function({
  Value<String> id,
  Value<String> taskId,
  Value<DateTime> timestamp,
  Value<double> metricValue,
  Value<String> metricUnit,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$MetricEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get metricValue => $composableBuilder(
      column: $table.metricValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$MetricEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get metricValue => $composableBuilder(
      column: $table.metricValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MetricEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetricEntriesTable> {
  $$MetricEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get metricValue => $composableBuilder(
      column: $table.metricValue, builder: (column) => column);

  GeneratedColumn<String> get metricUnit => $composableBuilder(
      column: $table.metricUnit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MetricEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MetricEntriesTable,
    MetricEntry,
    $$MetricEntriesTableFilterComposer,
    $$MetricEntriesTableOrderingComposer,
    $$MetricEntriesTableAnnotationComposer,
    $$MetricEntriesTableCreateCompanionBuilder,
    $$MetricEntriesTableUpdateCompanionBuilder,
    (
      MetricEntry,
      BaseReferences<_$AppDatabase, $MetricEntriesTable, MetricEntry>
    ),
    MetricEntry,
    PrefetchHooks Function()> {
  $$MetricEntriesTableTableManager(_$AppDatabase db, $MetricEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetricEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetricEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetricEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<double> metricValue = const Value.absent(),
            Value<String> metricUnit = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MetricEntriesCompanion(
            id: id,
            taskId: taskId,
            timestamp: timestamp,
            metricValue: metricValue,
            metricUnit: metricUnit,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required DateTime timestamp,
            required double metricValue,
            required String metricUnit,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MetricEntriesCompanion.insert(
            id: id,
            taskId: taskId,
            timestamp: timestamp,
            metricValue: metricValue,
            metricUnit: metricUnit,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MetricEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MetricEntriesTable,
    MetricEntry,
    $$MetricEntriesTableFilterComposer,
    $$MetricEntriesTableOrderingComposer,
    $$MetricEntriesTableAnnotationComposer,
    $$MetricEntriesTableCreateCompanionBuilder,
    $$MetricEntriesTableUpdateCompanionBuilder,
    (
      MetricEntry,
      BaseReferences<_$AppDatabase, $MetricEntriesTable, MetricEntry>
    ),
    MetricEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$ListsTableTableManager get lists =>
      $$ListsTableTableManager(_db, _db.lists);
  $$ListItemsTableTableManager get listItems =>
      $$ListItemsTableTableManager(_db, _db.listItems);
  $$ConnectionsTableTableManager get connections =>
      $$ConnectionsTableTableManager(_db, _db.connections);
  $$MetricEntriesTableTableManager get metricEntries =>
      $$MetricEntriesTableTableManager(_db, _db.metricEntries);
}

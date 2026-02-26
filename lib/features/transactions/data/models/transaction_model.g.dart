// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetTransactionModelCollection on Isar {
  IsarCollection<int, TransactionModel> get transactionModels =>
      this.collection();
}

final TransactionModelSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'TransactionModel',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'title', type: IsarType.string),
      IsarPropertySchema(name: 'amount', type: IsarType.double),
      IsarPropertySchema(
        name: 'type',
        type: IsarType.byte,

        enumMap: {"income": 0, "expense": 1},
      ),
      IsarPropertySchema(name: 'categoryId', type: IsarType.string),
      IsarPropertySchema(name: 'description', type: IsarType.string),
      IsarPropertySchema(name: 'createdAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'customDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'updatedAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'imageUrls', type: IsarType.stringList),
      IsarPropertySchema(name: 'location', type: IsarType.string),
      IsarPropertySchema(name: 'paymentMethod', type: IsarType.string),
      IsarPropertySchema(name: 'tags', type: IsarType.stringList),
      IsarPropertySchema(name: 'notes', type: IsarType.string),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'type',
        properties: ["type"],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'categoryId',
        properties: ["categoryId"],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'createdAt',
        properties: ["createdAt"],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'customDate',
        properties: ["customDate"],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, TransactionModel>(
    serialize: serializeTransactionModel,
    deserialize: deserializeTransactionModel,
    deserializeProperty: deserializeTransactionModelProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeTransactionModel(IsarWriter writer, TransactionModel object) {
  IsarCore.writeString(writer, 1, object.title);
  IsarCore.writeDouble(writer, 2, object.amount);
  IsarCore.writeByte(writer, 3, object.type.index);
  IsarCore.writeString(writer, 4, object.categoryId);
  {
    final value = object.description;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  IsarCore.writeLong(
    writer,
    6,
    object.createdAt.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    7,
    object.customDate.toUtc().microsecondsSinceEpoch,
  );
  IsarCore.writeLong(
    writer,
    8,
    object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  {
    final list = object.imageUrls;
    if (list == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      final listWriter = IsarCore.beginList(writer, 9, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final value = object.location;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeString(writer, 10, value);
    }
  }
  {
    final value = object.paymentMethod;
    if (value == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      IsarCore.writeString(writer, 11, value);
    }
  }
  {
    final list = object.tags;
    if (list == null) {
      IsarCore.writeNull(writer, 12);
    } else {
      final listWriter = IsarCore.beginList(writer, 12, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final value = object.notes;
    if (value == null) {
      IsarCore.writeNull(writer, 13);
    } else {
      IsarCore.writeString(writer, 13, value);
    }
  }
  return object.id;
}

@isarProtected
TransactionModel deserializeTransactionModel(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _title;
  _title = IsarCore.readString(reader, 1) ?? '';
  final double _amount;
  _amount = IsarCore.readDouble(reader, 2);
  final TransactionType _type;
  {
    if (IsarCore.readNull(reader, 3)) {
      _type = TransactionType.income;
    } else {
      _type =
          _transactionModelType[IsarCore.readByte(reader, 3)] ??
          TransactionType.income;
    }
  }
  final String _categoryId;
  _categoryId = IsarCore.readString(reader, 4) ?? '';
  final String? _description;
  _description = IsarCore.readString(reader, 5);
  final DateTime _createdAt;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _createdAt =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _createdAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final DateTime _customDate;
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      _customDate =
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
    } else {
      _customDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final DateTime? _updatedAt;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _updatedAt = null;
    } else {
      _updatedAt =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  final List<String>? _imageUrls;
  {
    final length = IsarCore.readList(reader, 9, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _imageUrls = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _imageUrls = list;
      }
    }
  }
  final String? _location;
  _location = IsarCore.readString(reader, 10);
  final String? _paymentMethod;
  _paymentMethod = IsarCore.readString(reader, 11);
  final List<String>? _tags;
  {
    final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _tags = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _tags = list;
      }
    }
  }
  final String? _notes;
  _notes = IsarCore.readString(reader, 13);
  final object = TransactionModel(
    id: _id,
    title: _title,
    amount: _amount,
    type: _type,
    categoryId: _categoryId,
    description: _description,
    createdAt: _createdAt,
    customDate: _customDate,
    updatedAt: _updatedAt,
    imageUrls: _imageUrls,
    location: _location,
    paymentMethod: _paymentMethod,
    tags: _tags,
    notes: _notes,
  );
  return object;
}

@isarProtected
dynamic deserializeTransactionModelProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readDouble(reader, 2);
    case 3:
      {
        if (IsarCore.readNull(reader, 3)) {
          return TransactionType.income;
        } else {
          return _transactionModelType[IsarCore.readByte(reader, 3)] ??
              TransactionType.income;
        }
      }
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5);
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true).toLocal();
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 9:
      {
        final length = IsarCore.readList(reader, 9, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 10:
      return IsarCore.readString(reader, 10);
    case 11:
      return IsarCore.readString(reader, 11);
    case 12:
      {
        final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 13:
      return IsarCore.readString(reader, 13);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _TransactionModelUpdate {
  bool call({
    required int id,
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? createdAt,
    DateTime? customDate,
    DateTime? updatedAt,
    String? location,
    String? paymentMethod,
    String? notes,
  });
}

class _TransactionModelUpdateImpl implements _TransactionModelUpdate {
  const _TransactionModelUpdateImpl(this.collection);

  final IsarCollection<int, TransactionModel> collection;

  @override
  bool call({
    required int id,
    Object? title = ignore,
    Object? amount = ignore,
    Object? type = ignore,
    Object? categoryId = ignore,
    Object? description = ignore,
    Object? createdAt = ignore,
    Object? customDate = ignore,
    Object? updatedAt = ignore,
    Object? location = ignore,
    Object? paymentMethod = ignore,
    Object? notes = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (title != ignore) 1: title as String?,
            if (amount != ignore) 2: amount as double?,
            if (type != ignore) 3: type as TransactionType?,
            if (categoryId != ignore) 4: categoryId as String?,
            if (description != ignore) 5: description as String?,
            if (createdAt != ignore) 6: createdAt as DateTime?,
            if (customDate != ignore) 7: customDate as DateTime?,
            if (updatedAt != ignore) 8: updatedAt as DateTime?,
            if (location != ignore) 10: location as String?,
            if (paymentMethod != ignore) 11: paymentMethod as String?,
            if (notes != ignore) 13: notes as String?,
          },
        ) >
        0;
  }
}

sealed class _TransactionModelUpdateAll {
  int call({
    required List<int> id,
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? createdAt,
    DateTime? customDate,
    DateTime? updatedAt,
    String? location,
    String? paymentMethod,
    String? notes,
  });
}

class _TransactionModelUpdateAllImpl implements _TransactionModelUpdateAll {
  const _TransactionModelUpdateAllImpl(this.collection);

  final IsarCollection<int, TransactionModel> collection;

  @override
  int call({
    required List<int> id,
    Object? title = ignore,
    Object? amount = ignore,
    Object? type = ignore,
    Object? categoryId = ignore,
    Object? description = ignore,
    Object? createdAt = ignore,
    Object? customDate = ignore,
    Object? updatedAt = ignore,
    Object? location = ignore,
    Object? paymentMethod = ignore,
    Object? notes = ignore,
  }) {
    return collection.updateProperties(id, {
      if (title != ignore) 1: title as String?,
      if (amount != ignore) 2: amount as double?,
      if (type != ignore) 3: type as TransactionType?,
      if (categoryId != ignore) 4: categoryId as String?,
      if (description != ignore) 5: description as String?,
      if (createdAt != ignore) 6: createdAt as DateTime?,
      if (customDate != ignore) 7: customDate as DateTime?,
      if (updatedAt != ignore) 8: updatedAt as DateTime?,
      if (location != ignore) 10: location as String?,
      if (paymentMethod != ignore) 11: paymentMethod as String?,
      if (notes != ignore) 13: notes as String?,
    });
  }
}

extension TransactionModelUpdate on IsarCollection<int, TransactionModel> {
  _TransactionModelUpdate get update => _TransactionModelUpdateImpl(this);

  _TransactionModelUpdateAll get updateAll =>
      _TransactionModelUpdateAllImpl(this);
}

sealed class _TransactionModelQueryUpdate {
  int call({
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? createdAt,
    DateTime? customDate,
    DateTime? updatedAt,
    String? location,
    String? paymentMethod,
    String? notes,
  });
}

class _TransactionModelQueryUpdateImpl implements _TransactionModelQueryUpdate {
  const _TransactionModelQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<TransactionModel> query;
  final int? limit;

  @override
  int call({
    Object? title = ignore,
    Object? amount = ignore,
    Object? type = ignore,
    Object? categoryId = ignore,
    Object? description = ignore,
    Object? createdAt = ignore,
    Object? customDate = ignore,
    Object? updatedAt = ignore,
    Object? location = ignore,
    Object? paymentMethod = ignore,
    Object? notes = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (title != ignore) 1: title as String?,
      if (amount != ignore) 2: amount as double?,
      if (type != ignore) 3: type as TransactionType?,
      if (categoryId != ignore) 4: categoryId as String?,
      if (description != ignore) 5: description as String?,
      if (createdAt != ignore) 6: createdAt as DateTime?,
      if (customDate != ignore) 7: customDate as DateTime?,
      if (updatedAt != ignore) 8: updatedAt as DateTime?,
      if (location != ignore) 10: location as String?,
      if (paymentMethod != ignore) 11: paymentMethod as String?,
      if (notes != ignore) 13: notes as String?,
    });
  }
}

extension TransactionModelQueryUpdate on IsarQuery<TransactionModel> {
  _TransactionModelQueryUpdate get updateFirst =>
      _TransactionModelQueryUpdateImpl(this, limit: 1);

  _TransactionModelQueryUpdate get updateAll =>
      _TransactionModelQueryUpdateImpl(this);
}

class _TransactionModelQueryBuilderUpdateImpl
    implements _TransactionModelQueryUpdate {
  const _TransactionModelQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<TransactionModel, TransactionModel, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? title = ignore,
    Object? amount = ignore,
    Object? type = ignore,
    Object? categoryId = ignore,
    Object? description = ignore,
    Object? createdAt = ignore,
    Object? customDate = ignore,
    Object? updatedAt = ignore,
    Object? location = ignore,
    Object? paymentMethod = ignore,
    Object? notes = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (title != ignore) 1: title as String?,
        if (amount != ignore) 2: amount as double?,
        if (type != ignore) 3: type as TransactionType?,
        if (categoryId != ignore) 4: categoryId as String?,
        if (description != ignore) 5: description as String?,
        if (createdAt != ignore) 6: createdAt as DateTime?,
        if (customDate != ignore) 7: customDate as DateTime?,
        if (updatedAt != ignore) 8: updatedAt as DateTime?,
        if (location != ignore) 10: location as String?,
        if (paymentMethod != ignore) 11: paymentMethod as String?,
        if (notes != ignore) 13: notes as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension TransactionModelQueryBuilderUpdate
    on QueryBuilder<TransactionModel, TransactionModel, QOperations> {
  _TransactionModelQueryUpdate get updateFirst =>
      _TransactionModelQueryBuilderUpdateImpl(this, limit: 1);

  _TransactionModelQueryUpdate get updateAll =>
      _TransactionModelQueryBuilderUpdateImpl(this);
}

const _transactionModelType = {
  0: TransactionType.income,
  1: TransactionType.expense,
};

extension TransactionModelQueryFilter
    on QueryBuilder<TransactionModel, TransactionModel, QFilterCondition> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  idBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountGreaterThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 2, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountGreaterThanOrEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 2, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountLessThan(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountLessThanOrEqualTo(double value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 2, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  amountBetween(double lower, double upper, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeGreaterThan(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 3, value: value.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeGreaterThanOrEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 3, value: value.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeLessThan(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeLessThanOrEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 3, value: value.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  typeBetween(TransactionType lower, TransactionType upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 3, lower: lower.index, upper: upper.index),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  createdAtBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateGreaterThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateGreaterThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateLessThan(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 7, value: value));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateLessThanOrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 7, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  customDateBetween(DateTime lower, DateTime upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 7, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtLessThan(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 8, value: value));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  updatedAtBetween(DateTime? lower, DateTime? upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 8, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsIsEmpty() {
    return not().group((q) => q.imageUrlsIsNull().or().imageUrlsIsNotEmpty());
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  imageUrlsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 9, value: null),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationBetween(String? lower, String? upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 10, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  paymentMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 11, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementGreaterThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementLessThan(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementBetween(String lower, String upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 12,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 12,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 12, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 12, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsIsEmpty() {
    return not().group((q) => q.tagsIsNull().or().tagsIsNotEmpty());
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 12, value: null),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesGreaterThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesBetween(String? lower, String? upper, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 13,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 13, value: ''),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 13, value: ''),
      );
    });
  }
}

extension TransactionModelQueryObject
    on QueryBuilder<TransactionModel, TransactionModel, QFilterCondition> {}

extension TransactionModelQuerySortBy
    on QueryBuilder<TransactionModel, TransactionModel, QSortBy> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> sortByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByTitleDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCategoryIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCustomDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByCustomDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByLocationDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByPaymentMethodDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> sortByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  sortByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension TransactionModelQuerySortThenBy
    on QueryBuilder<TransactionModel, TransactionModel, QSortThenBy> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> thenByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByTitleDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCategoryIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCustomDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByCustomDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByLocationDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByPaymentMethodDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> thenByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
  thenByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension TransactionModelQueryWhereDistinct
    on QueryBuilder<TransactionModel, TransactionModel, QDistinct> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByCustomDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByImageUrls() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByPaymentMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterDistinct>
  distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }
}

extension TransactionModelQueryProperty1
    on QueryBuilder<TransactionModel, TransactionModel, QProperty> {
  QueryBuilder<TransactionModel, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TransactionModel, String, QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TransactionModel, double, QAfterProperty> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TransactionModel, TransactionType, QAfterProperty>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TransactionModel, String, QAfterProperty> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TransactionModel, String?, QAfterProperty>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TransactionModel, DateTime, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TransactionModel, DateTime, QAfterProperty>
  customDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TransactionModel, DateTime?, QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TransactionModel, List<String>?, QAfterProperty>
  imageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TransactionModel, String?, QAfterProperty> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TransactionModel, String?, QAfterProperty>
  paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<TransactionModel, List<String>?, QAfterProperty> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<TransactionModel, String?, QAfterProperty> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }
}

extension TransactionModelQueryProperty2<R>
    on QueryBuilder<TransactionModel, R, QAfterProperty> {
  QueryBuilder<TransactionModel, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TransactionModel, (R, String), QAfterProperty> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TransactionModel, (R, double), QAfterProperty> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TransactionModel, (R, TransactionType), QAfterProperty>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TransactionModel, (R, String), QAfterProperty>
  categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TransactionModel, (R, String?), QAfterProperty>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TransactionModel, (R, DateTime), QAfterProperty>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TransactionModel, (R, DateTime), QAfterProperty>
  customDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TransactionModel, (R, DateTime?), QAfterProperty>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TransactionModel, (R, List<String>?), QAfterProperty>
  imageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TransactionModel, (R, String?), QAfterProperty>
  locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TransactionModel, (R, String?), QAfterProperty>
  paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<TransactionModel, (R, List<String>?), QAfterProperty>
  tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<TransactionModel, (R, String?), QAfterProperty> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }
}

extension TransactionModelQueryProperty3<R1, R2>
    on QueryBuilder<TransactionModel, (R1, R2), QAfterProperty> {
  QueryBuilder<TransactionModel, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String), QOperations>
  titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, double), QOperations>
  amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, TransactionType), QOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String), QOperations>
  categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String?), QOperations>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, DateTime), QOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, DateTime), QOperations>
  customDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, DateTime?), QOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, List<String>?), QOperations>
  imageUrlsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String?), QOperations>
  locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String?), QOperations>
  paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, List<String>?), QOperations>
  tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<TransactionModel, (R1, R2, String?), QOperations>
  notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }
}

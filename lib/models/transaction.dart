import 'package:money_mate/models/recurringFrequency.dart';
import 'package:money_mate/models/transactionType.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final String? description;
  final DateTime date;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final String? receiptPath;
  final bool hasReceipt;

  final String? location;
  final String? paymentMethod;
  final List<String>? tags;
  final String? notes;
  final bool isRecurring;
  final RecurringFrequency? recurringFrequency;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.description,
    required this.date,
    required this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.receiptPath,
    this.hasReceipt = false,
    this.location,
    this.paymentMethod,
    this.tags,
    this.notes,
    this.isRecurring = false,
    this.recurringFrequency,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json["id"] as String,
        title: json["title"] as String,
        amount: (json["amount"] as num).toDouble(),
        type: TransactionType.values.firstWhere(
              (e) => e.toString() == "TransactionType.${json["type"]}",
        ),
        categoryId: json["categoryId"] as String,
        description: json["description"] as String?,
        date: DateTime.parse(json["date"] as String),
        createdAt: DateTime.parse(json["createdAt"] as String),
        updatedAt: json["updatedAt"] != null
    ? DateTime.parse(json["updatedAt"] as String)
        : null,
    imageUrl: json["imageUrl"] as String?,
    receiptPath: json["receiptPath"] as String?,
    hasReceipt: json["hasReceipt"] as bool? ?? false,
    location: json["location"] as String?,
    paymentMethod: json["paymentMethod"] as String?,
    tags: json["tags"] != null
    ? List<String>.from(json["tags"] as List)
        : null,
    notes: json["notes"] as String?,
    isRecurring: json["isRecurring"] as bool? ?? false,
    recurringFrequency: json["recurringFrequency"] != null
    ? RecurringFrequency.values.firstWhere(
    (e) => e.toString() == "RecurringFrequency.${json["recurringFrequency"]}",
    )
    : null,
    );
  }
// Convert Transaction to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "type": type.toString().split('.').last,
      "categoryId": categoryId,
      "description": description,
      "date": date.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "imageUrl": imageUrl,
      "receiptPath": receiptPath,
      "hasReceipt": hasReceipt,
      "location": location,
      "paymentMethod": paymentMethod,
      "tags": tags,
      "notes": notes,
      "isRecurring": isRecurring,
      "recurringFrequency": recurringFrequency?.toString().split('.').last,
    };
  }
// Copy with method for immutability
  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    String? receiptPath,
    bool? hasReceipt,
    String? location,
    String? paymentMethod,
    List<String>? tags,
    String? notes,
    bool? isRecurring,
    RecurringFrequency? recurringFrequency,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      receiptPath: receiptPath ?? this.receiptPath,
      hasReceipt: hasReceipt ?? this.hasReceipt,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringFrequency: recurringFrequency ?? this.recurringFrequency,
    );
  }

}
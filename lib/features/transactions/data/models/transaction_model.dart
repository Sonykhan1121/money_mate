import 'package:isar_plus/isar_plus.dart';
import 'package:money_mate/features/transactions/data/models/transaction_type.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {

  @Id()
  int id ;
  final String title;
  final double amount;

  @Index()
  @enumValue
  final TransactionType type;

  @Index()
  final String categoryId;
  final String? description;

  @Index()
  final DateTime createdAt;

  @Index()
  final DateTime customDate;
  final DateTime? updatedAt;
  final List<String>? imageUrls;
  final String? location;
  final String? paymentMethod;
  final List<String>? tags;
  final String? notes;

  TransactionModel({
  required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.description,
    required this.createdAt,
    required this.customDate,
    this.updatedAt,
    this.imageUrls,
    this.location,
    this.paymentMethod,
    this.tags,
    this.notes,
  });

  // ─── fromJson ─────────────────────────────────────────────────────────────

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int ,
      title: json["title"] as String,
      amount: (json["amount"] as num).toDouble(),
      type: TransactionType.values.firstWhere((e) => e.toString() == "TransactionType.${json["type"]}"),
      categoryId: json["categoryId"] as String,
      description: json["description"] as String?,
      createdAt: DateTime.parse(json["createdAt"] as String),
      customDate: DateTime.parse(json["customDate"] as String),
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"] as String) : null,
      imageUrls: json["imageUrls"] != null ? List<String>.from(json["imageUrls"] as List) : null,
      location: json["location"] as String?,
      paymentMethod: json["paymentMethod"] as String?,
      tags: json["tags"] != null ? List<String>.from(json["tags"] as List) : null,
      notes: json["notes"] as String?,
    );
  }

  // ─── toJson ───────────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "type": type.toString().split('.').last,
      "categoryId": categoryId,
      "description": description,
      "createdAt": createdAt.toIso8601String(),
      "customDate": customDate.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "imageUrls": imageUrls,
      "location": location,
      "paymentMethod": paymentMethod,
      "tags": tags,
      "notes": notes,
    };
  }

  // ─── copyWith ─────────────────────────────────────────────────────────────

  TransactionModel copyWith({
    int? id,
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? createdAt,
    DateTime? customDate,
    DateTime? updatedAt,
    List<String>? imageUrl,
    String? location,
    String? paymentMethod,
    List<String>? tags,
    String? notes,
  }) {
    return TransactionModel(
      id: this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      customDate: customDate ?? this.customDate,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrls: imageUrl ?? imageUrls,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
    );
  }

  // ─── Equality ─────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) => other is TransactionModel && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, amount: $amount, '
        'type: $type, categoryId: $categoryId, createdAt: $createdAt , customDate: $customDate ,$imageUrls)';
  }
}

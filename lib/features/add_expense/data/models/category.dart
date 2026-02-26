import '../../../transactions/data/models/transaction_type.dart';

class CategoryModel {
  final String id;
  final String name;
  final String nameLocalised; // Bangla name
  final String icon; // Emoji or icon code
  final String colorHex;
  final TransactionType type;
  final bool isDefault;

  CategoryModel({
    required this.id,
    required this.name,
    required this.nameLocalised,
    required this.icon,
    required this.colorHex,
    required this.type,
    this.isDefault = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"] as String,
      name: json["name"] as String,
      nameLocalised: json["nameLocalised"] as String,
      icon: json["icon"] as String,
      colorHex: json["colorHex"] as String,
      type: TransactionType.values.firstWhere(
        // Correct way to look up enum from a string name (without the "TransactionType." prefix)
            (e) => e.name == json["type"],
        orElse: () => TransactionType.expense, // Provide a fallback if type is missing or invalid
      ),
      isDefault: json["isDefault"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "nameLocalised": nameLocalised,
      "icon": icon,
      "colorHex": colorHex,
      // Use .name (or .toString().split('.').last for pre-2.15 Dart)
      "type": type.name,
      "isDefault": isDefault,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? nameLocalised,
    String? icon,
    String? colorHex,
    TransactionType? type,
    bool? isDefault,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameLocalised: nameLocalised ?? this.nameLocalised,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }

}

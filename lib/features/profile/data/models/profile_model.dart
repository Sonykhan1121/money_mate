import 'package:isar/isar.dart';

part 'profile_model.g.dart';

@collection
class ProfileModel {
  Id id = Isar.autoIncrement;
  final String? imagePath;
  final String? name;
  final int? age;
  final String? email;
  final String? phone;
  final String? address;
  final String? bio;

  ProfileModel({required this.id, this.imagePath, this.name, this.age, this.email, this.phone, this.address, this.bio});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      imagePath: json['imagePath'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      bio: json['bio'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio
    };
  }
}

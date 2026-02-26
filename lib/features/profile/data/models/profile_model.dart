import 'package:isar_plus/isar_plus.dart';
import 'package:money_mate/features/profile/presentation/widgets/avatar_result.dart';

part 'profile_model.g.dart';

@collection
class ProfileModel {

  @Id()
  int id  ;
  final String? imagePath;

  @Index()
  @enumValue
  final AvatarType avatarType;
  final String? name;
  final int? age;
  final String? email;
  final String? phone;
  final String? address;
  final String? bio;

  ProfileModel({required this.id ,this.avatarType=AvatarType.file, this.imagePath, this.name, this.age, this.email, this.phone, this.address, this.bio});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      imagePath: json['imagePath'],
      avatarType: json['avatarType'],
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
      'avatarType': avatarType,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio
    };
  }
  @override
  String toString() {
    return "$id $name $age $email $imagePath $avatarType $phone $address $bio";
  }
}

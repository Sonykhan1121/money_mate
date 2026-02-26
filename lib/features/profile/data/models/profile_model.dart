import 'package:isar/isar.dart';
import 'package:money_mate/features/profile/presentation/widgets/avatar_result.dart';

part 'profile_model.g.dart';

@collection
class ProfileModel {
  Id id ;
  final String? imagePath;

  @Index()
  @enumerated
  final AvatarType avatarType;
  final String? name;
  final int? age;
  final String? email;
  final String? phone;
  final String? address;
  final String? bio;

  ProfileModel({this.id=Isar.autoIncrement,this.avatarType=AvatarType.file, this.imagePath, this.name, this.age, this.email, this.phone, this.address, this.bio});

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

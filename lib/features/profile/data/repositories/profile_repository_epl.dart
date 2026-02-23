import '../models/profile_model.dart';
import '../services/profile_service.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryEpl implements ProfileRepository {
  final ProfileService profileService;
  ProfileRepositoryEpl({required this.profileService});

  @override
  Future<ProfileModel?> getProfile() async => await profileService.getProfile();

  @override
  Future<bool> saveProfile(ProfileModel profile) async=>
     await profileService.saveProfile(profile);

  @override
  Future<bool> deleteProfile() async => await profileService.deleteProfile();

  @override
  Future<bool> hasProfile() async => await profileService.hasProfile();
}
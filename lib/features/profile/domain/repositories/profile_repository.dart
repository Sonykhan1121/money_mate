import '../../data/models/profile_model.dart';

abstract class ProfileRepository {

  /// Returns the single profile, null if not created yet
  Future<ProfileModel?> getProfile();

  /// Creates or updates the profile, returns true if successful
  Future<bool> saveProfile(ProfileModel profile);

  /// Deletes the profile, returns true if successful
  Future<bool> deleteProfile();

  /// Returns true if a profile already exists
  Future<bool> hasProfile();
}
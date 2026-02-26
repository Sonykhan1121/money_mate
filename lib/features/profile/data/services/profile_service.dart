import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import '../../../../core/services/isar_service.dart';
import '../models/profile_model.dart';

class ProfileService {
  // ─── Singleton ──────────────────────────────
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  ProfileService._internal();

  final _isarService = IsarService();
  Future<Isar> get db => _isarService.db;

  // ─── Operations ─────────────────────────────

  /// Returns the single profile, null if not created yet
  Future<ProfileModel?> getProfile() async {
    try {
      final isar = await db;
      return await isar.profileModels.where().findFirst();
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  /// Creates or updates the profile, returns true if successful
  Future<bool> saveProfile(ProfileModel profile) async {
    debugPrint('Saving profile: $profile');
    try {
      final isar = await db;
      return await isar.writeTxn(() async {
        final id = await isar.profileModels.put(profile);
        return id != 0;
      });
    } catch (e) {
      debugPrint('Error saving profile: $e');
      return false;
    }
  }

  /// Deletes the profile, returns true if successful
  Future<bool> deleteProfile() async {
    try {
      final isar = await db;
      final profile = await isar.profileModels.where().findFirst();
      if (profile == null) return false;
      return await isar.writeTxn(() async {
        return await isar.profileModels.delete(profile.id);
      });
    } catch (e) {
      debugPrint('Error deleting profile: $e');
      return false;
    }
  }

  /// Returns true if a profile already exists
  Future<bool> hasProfile() async {
    try {
      final isar = await db;
      final count = await isar.profileModels.where().count();
      return count > 0;
    } catch (e) {
      debugPrint('Error checking profile: $e');
      return false;
    }
  }
}
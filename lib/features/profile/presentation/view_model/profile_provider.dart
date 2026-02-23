import 'package:flutter/cupertino.dart';
import '../../data/models/profile_model.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository profileRepository;

  ProfileProvider({required this.profileRepository}){
    init();
  }

  ProfileModel? _profile;
  bool _isLoading = false;
  String? _error;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasProfile => _profile != null;

  // ─── Init ────────────────────────────────────
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _profile = await profileRepository.getProfile();

    _isLoading = false;
    notifyListeners();
  }

  // ─── Save / Update ───────────────────────────
  Future<bool> saveProfile(ProfileModel profile) async {
    _isLoading = true;
    notifyListeners();

    final success = await profileRepository.saveProfile(profile);
    if (success) {
      _profile = profile;
    } else {
      _error = 'Failed to save profile';
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  // ─── Delete ──────────────────────────────────
  Future<bool> deleteProfile() async {
    _isLoading = true;
    notifyListeners();

    final success = await profileRepository.deleteProfile();
    if (success) {
      _profile = null;
    } else {
      _error = 'Failed to delete profile';
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  // ─── Clear error ─────────────────────────────
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
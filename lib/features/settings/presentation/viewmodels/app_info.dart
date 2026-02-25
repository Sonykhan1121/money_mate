import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends ChangeNotifier {

  AppInfo()
  {
    init();
  }

  // ─── State ────────────────────────────────────────────────────────────────
  PackageInfo? _packageInfo;
  bool _isLoading = true;

  // ─── Getters ──────────────────────────────────────────────────────────────
  bool   get isLoading    => _isLoading;
  String get appName      => _packageInfo?.appName      ?? '';
  String get packageName  => _packageInfo?.packageName  ?? '';
  String get version      => _packageInfo?.version      ?? '';
  String get buildNumber  => _packageInfo?.buildNumber  ?? '';
  String get fullVersion  => 'v$version+$buildNumber';

  // ─── Init ─────────────────────────────────────────────────────────────────
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _packageInfo = await PackageInfo.fromPlatform();

    _isLoading = false;
    notifyListeners();
  }
}
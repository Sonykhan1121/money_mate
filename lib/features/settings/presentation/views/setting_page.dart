import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/widgets/setting_tile.dart';
import '../../../../core/utils/constants/icons.dart';
import '../../../../core/providers/theme_provider.dart';
import '../viewmodels/app_info.dart';
import '../../data/services/backup_service.dart';
import 'help_support_page.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isBackingUp  = false;
  bool _isRestoring  = false;

  // ─── Backup ───────────────────────────────────────────────────────────────
  Future<void> _handleBackup() async {
    setState(() => _isBackingUp = true);
    final result = await BackupService.backup(
      transactions: context.transactionProvider.allTransactions,
      context: context,
    );
    setState(() => _isBackingUp = false);

    if (!mounted) return;
    _showSnack(
      result.success
          ? '✅ Backup successful — ${result.count} transactions exported'
          : '❌ Backup failed: ${result.error}',
      result.success,
    );
  }

  // ─── Restore ──────────────────────────────────────────────────────────────
  Future<void> _handleRestore() async {
    // Confirm first
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Import Backup'),
        content: const Text(
          'This will overwrite any existing transactions with the same ID. Continue?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: DColors.primary),
            child: const Text('Import', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if(!mounted)
      {
        return;
      }

    setState(() => _isRestoring = true);
    final result = await BackupService.restore(
      repository: context.transactionProvider.transactionRepository,
    );
    setState(() => _isRestoring = false);

    if (!mounted) return;

    if (!result.cancelled) {
      // Refresh provider
      await context.transactionProvider.init();
      _showSnack(
        result.success
            ? '✅ Restored ${result.count} transactions'
            : '❌ Restore failed: ${result.error}',
        result.success,
      );
    }
  }

  void _showSnack(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? const Color(0xFF00C48C) : const Color(0xFFFF6B6B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = context.watch<AppInfo>();

    return SafeArea(
      child: Consumer<ThemeProvider>(
        builder: (_, tProvider, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SettingTile(
                      iconData: Icons.shield_moon_rounded,
                      title: 'Dark Mode',
                      subtitle: 'Toggle dark theme',
                      switchValue: tProvider.isDarkMode,
                      onChanged: (_) => tProvider.toggleTheme(),
                    ),

                    SettingTile(
                      iconData: _isBackingUp ? Icons.hourglass_top : Icons.save,
                      title: 'Backup Data',
                      subtitle: _isBackingUp ? 'Exporting...' : 'Download as JSON',
                      onTap: _isBackingUp ? null : _handleBackup,
                    ),

                    SettingTile(
                      iconData: _isRestoring ? Icons.hourglass_top : Icons.document_scanner,
                      title: 'Import Backup',
                      subtitle: _isRestoring ? 'Importing...' : 'Restore from JSON',
                      onTap: _isRestoring ? null : _handleRestore,
                    ),

                    SettingTile(
                      iconData: Icons.question_mark,
                      title: 'Help & Support',
                      subtitle: 'FAQs and Contact',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HelpSupportPage()),
                      ),
                    ),

                    const SizedBox(height: 50),

                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(DIcons.appLogo1),
                    ),
                    const SizedBox(height: 10),
                    Text('Version ${appInfo.version}'),
                    const SizedBox(height: 10),
                    const Text('Track your money with ease'),
                    const SizedBox(height: 30),
                    const Text(
                      'All your data stays on your device. Nothing is stored online.',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
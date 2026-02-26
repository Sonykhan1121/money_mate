import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import '../widgets/avatar_result.dart';
import 'package:provider/provider.dart';
import '../view_model/profile_provider.dart';
import '../../data/models/profile_model.dart';
import '../widgets/profile_edit_section.dart';
import '../widgets/profile_view_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  AvatarResult? _avatar;
  AvatarResult? _editingAvatar;

  late TextEditingController _nameCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    // ✅ Read from provider on init
    final profile = context.read<ProfileProvider>().profile;

    _avatar = profile?.imagePath != null
        ? profile!.avatarType==AvatarType.asset ? AvatarResult.asset(profile.imagePath!) : AvatarResult.file(
        profile.imagePath!)
        : null;

    _nameCtrl  = TextEditingController(text: profile?.name ?? '');
    _ageCtrl   = TextEditingController(text: profile?.age?.toString() ?? '');
    _emailCtrl = TextEditingController(text: profile?.email ?? '');
    _phoneCtrl = TextEditingController(text: profile?.phone ?? '');
    _bioCtrl   = TextEditingController(text: profile?.bio ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  // ─── Actions ───────────────────────────────────────────────────────────────

  void _enterEdit() {
    _editingAvatar = _avatar; // snapshot current avatar
    setState(() => _isEditing = true);
    debugPrint("enter (avatar)1 : $_editingAvatar");
  }

  Future<void> _saveEdit() async {
    final provider = context.read<ProfileProvider>();
    final existing = provider.profile;
    debugPrint("save (avatar) : $_editingAvatar");
    debugPrint("save (avatar)1 : $_avatar");

    final updated = ProfileModel(
      id: existing?.id ?? Isar.autoIncrement,
      name:      _nameCtrl.text.trim().isEmpty  ? null : _nameCtrl.text.trim(),
      age:       int.tryParse(_ageCtrl.text.trim()),
      email:     _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      phone:     _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      bio:       _bioCtrl.text.trim().isEmpty   ? null : _bioCtrl.text.trim(),
      imagePath: _editingAvatar?.path,
      avatarType: _editingAvatar?.type?? AvatarType.file,
    );

    final success = await provider.saveProfile(updated);
    if (success && mounted) {
      setState(() {
        _avatar    = _editingAvatar; // commit avatar
        _isEditing = false;
      });
    }
  }

  void _cancelEdit() {
    final profile = context.read<ProfileProvider>().profile;
    _nameCtrl.text  = profile?.name ?? '';
    _ageCtrl.text   = profile?.age?.toString() ?? '';
    _emailCtrl.text = profile?.email ?? '';
    _phoneCtrl.text = profile?.phone ?? '';
    _bioCtrl.text   = profile?.bio ?? '';
    _editingAvatar  = _avatar; // discard changes

    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: _ProfileAppBar(
            isEditing: _isEditing,
            onEdit:    _enterEdit,
            onSave:    _saveEdit,
            onCancel:  _cancelEdit,
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 24),
            child: Column(
              children: [
                if (provider.error != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(provider.error!,
                              style: const TextStyle(color: Colors.red)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: provider.clearError,
                        ),
                      ],
                    ),
                  ),

                _isEditing
                    ? ProfileEditSection(
                  nameCtrl:  _nameCtrl,
                  ageCtrl:   _ageCtrl,
                  emailCtrl: _emailCtrl,
                  phoneCtrl: _phoneCtrl,
                  bioCtrl:   _bioCtrl,
                  initialAvatar:    _avatar,
                  onAvatarChanged: (r) => _editingAvatar = r,
                )
                    : ProfileViewSection(
                  name:   provider.profile?.name,
                  age:    provider.profile?.age?.toString(),
                  email:  provider.profile?.email,
                  phone:  provider.profile?.phone,
                  bio:    provider.profile?.bio,
                  avatar: _avatar,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── AppBar ──────────────────────────────────────────────────────────────────

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _ProfileAppBar({
    required this.isEditing,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Profile'),
      centerTitle: true,
      actions: [
        if (!isEditing)
          TextButton(onPressed: onEdit, child: const Text('Edit'))
        else ...[
          TextButton(onPressed: onCancel, child: const Text('Cancel')),
          TextButton(onPressed: onSave,   child: const Text('Save')),
        ],
      ],
    );
  }
}
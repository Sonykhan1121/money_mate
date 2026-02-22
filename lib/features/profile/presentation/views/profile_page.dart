import 'package:flutter/material.dart';

import '../widgets/avatar_result.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_edit_section.dart';
import '../widgets/profile_view_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  // ─── Profile Data ──────────────────────────────────────────────────────────
  String? _name;
  String? _age;
  String? _email;
  String? _phone;
  String? _bio;
  AvatarResult? _avatar;        // ← ADD
  AvatarResult? _editingAvatar; // ← ADD (temp while editing)

  // ─── Edit controllers ──────────────────────────────────────────────────────
  late TextEditingController _nameCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl  = TextEditingController(text: _name);
    _ageCtrl   = TextEditingController(text: _age);
    _emailCtrl = TextEditingController(text: _email);
    _phoneCtrl = TextEditingController(text: _phone);
    _bioCtrl   = TextEditingController(text: _bio);
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
    _editingAvatar = _avatar; // ← snapshot current avatar
    setState(() => _isEditing = true);
  }

  void _saveEdit() {
    setState(() {
      _name  = _nameCtrl.text.trim().isEmpty  ? null : _nameCtrl.text.trim();
      _age   = _ageCtrl.text.trim().isEmpty   ? null : _ageCtrl.text.trim();
      _email = _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim();
      _phone = _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim();
      _bio   = _bioCtrl.text.trim().isEmpty   ? null : _bioCtrl.text.trim();
      _avatar = _editingAvatar; // ← commit avatar
      _isEditing = false;
    });
  }

  void _cancelEdit() {
    _nameCtrl.text  = _name  ?? '';
    _ageCtrl.text   = _age   ?? '';
    _emailCtrl.text = _email ?? '';
    _phoneCtrl.text = _phone ?? '';
    _bioCtrl.text   = _bio   ?? '';
    _editingAvatar  = _avatar; // ← discard changes
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ProfileAppBar(
        isEditing: _isEditing,
        onEdit: _enterEdit,
        onSave: _saveEdit,
        onCancel: _cancelEdit,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            // ── View or Edit ──
            _isEditing
                ? ProfileEditSection(
              nameCtrl:  _nameCtrl,
              ageCtrl:   _ageCtrl,
              emailCtrl: _emailCtrl,
              phoneCtrl: _phoneCtrl,
              bioCtrl:   _bioCtrl,
              initialAvatar: _editingAvatar,           // ← ADD
              onAvatarChanged: (r) => _editingAvatar = r, // ← ADD
            )
                : ProfileViewSection(
              name:  _name,
              age:   _age,
              email: _email,
              phone: _phone,
              bio:   _bio,
              avatar: _avatar, // ← ADD
            ),
          ],
        ),
      ),
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
          TextButton(
            onPressed: onEdit,
            child: const Text('Edit'),
          )
        else ...[
          TextButton(onPressed: onCancel, child: const Text('Cancel')),
          TextButton(onPressed: onSave,   child: const Text('Save')),
        ],
      ],
    );
  }
}
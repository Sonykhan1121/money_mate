import 'avatar_result.dart';
import 'profile_field.dart';
import 'avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows all editable fields when the user is in edit mode.
class ProfileEditSection extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController ageCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController bioCtrl;
  final AvatarResult? initialAvatar;                    // ← ADD
  final void Function(AvatarResult) onAvatarChanged;   // ← ADD

  const ProfileEditSection({
    super.key,
    required this.nameCtrl,
    required this.ageCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.bioCtrl,
    this.initialAvatar,           // ← ADD
    required this.onAvatarChanged, // ← ADD
  });

  @override
  State<ProfileEditSection> createState() => _ProfileEditSectionState();
}

class _ProfileEditSectionState extends State<ProfileEditSection> {
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("initialAvatar : ${widget.initialAvatar}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        AvatarPicker(
          previous: widget.initialAvatar,          // ← ADD
          onAvatarSelected: widget.onAvatarChanged, // ← CHANGE
        ),
        SizedBox(height: 24.h),
        ProfileField(
          controller: widget.nameCtrl,
          label: 'Name',
          hint: 'Enter your name',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        ProfileField(
          controller: widget.ageCtrl,
          label: 'Age',
          hint: 'Enter your age',
          icon: Icons.cake_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ProfileField(
          controller: widget.emailCtrl,
          label: 'Email',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        ProfileField(
          controller: widget.phoneCtrl,
          label: 'Phone',
          hint: 'Enter your phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        ProfileField(
          controller: widget.bioCtrl,
          label: 'Bio',
          hint: 'Tell something about yourself',
          icon: Icons.info_outline,
          maxLines: 3,
        ),
      ],
    );
  }
}

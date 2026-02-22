import 'avatar_result.dart';
import 'profile_field.dart';
import 'avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows all editable fields when the user is in edit mode.
class ProfileEditSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [

        AvatarPicker(
          initial: initialAvatar,          // ← ADD
          onAvatarSelected: onAvatarChanged, // ← CHANGE
        ),
        SizedBox(height: 24.h),
        ProfileField(
          controller: nameCtrl,
          label: 'Name',
          hint: 'Enter your name',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        ProfileField(
          controller: ageCtrl,
          label: 'Age',
          hint: 'Enter your age',
          icon: Icons.cake_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ProfileField(
          controller: emailCtrl,
          label: 'Email',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        ProfileField(
          controller: phoneCtrl,
          label: 'Phone',
          hint: 'Enter your phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        ProfileField(
          controller: bioCtrl,
          label: 'Bio',
          hint: 'Tell something about yourself',
          icon: Icons.info_outline,
          maxLines: 3,
        ),
      ],
    );
  }
}

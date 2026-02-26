import 'avatar_result.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewSection extends StatelessWidget {
  final String? name;
  final String? age;
  final String? email;
  final String? phone;
  final String? bio;
  final AvatarResult? avatar;

  const ProfileViewSection({
    super.key,
    this.name,
    this.age,
    this.email,
    this.phone,
    this.bio,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const placeholder = '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // ── Avatar ────────────────────────────────────────────────────────────
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DColors.primary.withValues(alpha: 0.10),
                border: Border.all(
                  color: DColors.primary.withValues(alpha: 0.25),
                  width: 2.5,
                ),
              ),
              child: avatar == null
                  ? Icon(
                Icons.person_rounded,
                size: 40.sp,
                color: DColors.primary.withValues(alpha: 0.65),
              )
                  : ClipOval(
                child: avatar!.type == AvatarType.asset
                    ? Image.asset(avatar!.path, fit: BoxFit.cover,
                    width: 80.w, height: 80.w)
                    : Image.file(avatar!.toFile()!, fit: BoxFit.cover,
                    width: 80.w, height: 80.w),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // ── Name headline ─────────────────────────────────────────────────────
        Text(
          name ?? 'Your Name',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: name != null
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withValues(alpha: 0.35),
          ),
        ),

        if (bio != null) ...[
          SizedBox(height: 4.h),
          Text(
            bio!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              height: 1.5,
            ),
          ),
        ],

        SizedBox(height: 24.h),

        // ── Info card ─────────────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildRow(context, Icons.cake_outlined,  'Age',   age,   placeholder, showDivider: true),
              _buildRow(context, Icons.email_outlined,  'Email', email, placeholder, showDivider: true),
              _buildRow(context, Icons.phone_outlined,  'Phone', phone, placeholder, showDivider: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
      BuildContext context,
      IconData icon,
      String label,
      String? value,
      String placeholder, {
        required bool showDivider,
      }) {
    final theme = Theme.of(context);
    final isEmpty = value == null;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isEmpty
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.25)
                    : DColors.primary,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      value ?? placeholder,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isEmpty
                            ? theme.colorScheme.onSurface.withValues(alpha: 0.28)
                            : theme.colorScheme.onSurface,
                        fontWeight:
                        isEmpty ? FontWeight.w400 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            indent: 50.w,
            color: theme.dividerColor.withValues(alpha: 0.4),
          ),
      ],
    );
  }
}
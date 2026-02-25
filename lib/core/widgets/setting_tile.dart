import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class SettingTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final Function(bool)? onChanged;
  final bool switchValue;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    this.onChanged,
    this.switchValue = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: onChanged != null
              ? Switch(
                value: switchValue,
                onChanged: onChanged,
                activeTrackColor: DColors.primary,
                activeThumbColor: DColors.fWhite,
                inactiveThumbColor: DColors.fWhite,
                inactiveTrackColor: Colors.grey.shade300,
                trackOutlineColor:
                WidgetStateProperty.all(Colors.transparent),
              )
              : null,
        ),
      ),
    );
  }
}

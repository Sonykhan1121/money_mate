import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class SettingTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final Function(bool)? onChanged;


  const SettingTile({super.key,required this.iconData,required this.title,required this.subtitle, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
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
          padding: const EdgeInsets.all(12), // Good practice to use const
          decoration: BoxDecoration(
            color: DColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(iconData),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        // --- CORRECTED TRAILING ARGUMENT ---
        trailing: onChanged != null
            ? Switch(
          activeTrackColor: DColors.primary,
          activeThumbColor: DColors.fWhite,
          value: true, // You might want this to be a stateful value later
          onChanged: onChanged,
        )
            : null,
        // ------------------------------------
      ),
    );
  }
}

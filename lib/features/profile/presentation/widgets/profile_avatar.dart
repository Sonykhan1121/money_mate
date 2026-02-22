import 'package:flutter/material.dart';

/// Replace the body of this widget with your own profile picture button.
/// This is just a placeholder so ProfilePage compiles out of the box.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 REPLACE THIS with your own profile picture widget
    return CircleAvatar(
      radius: 52,
      backgroundColor: Colors.grey.shade300,
      child: Icon(Icons.person, size: 52, color: Colors.grey.shade600),
    );
  }
}
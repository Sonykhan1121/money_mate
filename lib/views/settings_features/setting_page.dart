import 'package:flutter/material.dart';
import 'package:money_mate/widgets/setting_tile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text("Setting Page"),),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SettingTile(iconData: Icons.shield_moon_rounded, title:"Dart Mode", subtitle: "Toggle dark theme",onChanged: (value){},),
              SettingTile(iconData: Icons.language, title:"Language", subtitle: "English",),
              SettingTile(iconData: Icons.save, title:"Export Data", subtitle: "Downloaded as CSV",),
              SettingTile(iconData: Icons.notifications_active_outlined, title:"Notifications", subtitle: "Manage alerts",onChanged: (value){},),
              SettingTile(iconData: Icons.security, title:"Security", subtitle: "PIN & Biometrics",),
              SettingTile(iconData: Icons.question_mark, title:"Help & Support", subtitle: "FAQs and Contact",),

            ],
          ),
        ),
      ),
    );
  }
}

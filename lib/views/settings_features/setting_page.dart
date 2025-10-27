import 'package:flutter/material.dart';
import 'package:money_mate/widgets/setting_tile.dart';

import '../../utils/constants/icons.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  bool isNotification = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text("Setting Page"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SettingTile(iconData: Icons.shield_moon_rounded, title:"Dart Mode", subtitle: "Toggle dark theme",switchValue: isDarkMode,onChanged: (value){
                  setState(() {
                    isDarkMode = value;
                  },);
                },),
                SettingTile(iconData: Icons.language, title:"Language", subtitle: "English",),
                SettingTile(iconData: Icons.save, title:"Export Data", subtitle: "Downloaded as CSV",),
                SettingTile(iconData: Icons.document_scanner, title:"Import Data", subtitle: "Import as CSV",),
                SettingTile(iconData: Icons.notifications_active_outlined, title:"Notifications", subtitle: "Manage alerts",switchValue: isNotification,onChanged: (value){
                  setState(() {
                    isNotification = value;
                  });
                },),
                SettingTile(iconData: Icons.security, title:"Security", subtitle: "PIN & Biometrics",),
                SettingTile(iconData: Icons.question_mark, title:"Help & Support", subtitle: "FAQs and Contact",),
                SizedBox(height: 50,),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                     boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
                  ),
                    child: Image.asset(DIcons.app_logo1)),
                SizedBox(height: 10,),
                Text('Version 1.0.0'),
                SizedBox(height: 10,),
                Text('Track your money with ease'),
                SizedBox(height: 30,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/utils/constants/icons.dart';
import '../../../../core/widgets/setting_tile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isNotification = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ThemeProvider>(
        builder: (_, tProvider, _) {
          return Scaffold(
            // appBar: AppBar(title: Text("Setting Page"),),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SettingTile(
                      iconData: Icons.shield_moon_rounded,
                      title: "Dart Mode",
                      subtitle: "Toggle dark theme",
                      switchValue: tProvider.isDarkMode,
                      onChanged: (value) {
                        tProvider.toggleTheme();
                      },
                    ),
                    // SettingTile(iconData: Icons.language, title:"Language", subtitle: "English",),
                    SettingTile(
                      iconData: Icons.save,
                      title: "BackUp Data",
                      subtitle: "Downloaded as Json",
                    ),
                    SettingTile(
                      iconData: Icons.document_scanner,
                      title: "Import BackUp Data",
                      subtitle: "Import as Json",
                    ),
                    // SettingTile(iconData: Icons.notifications_active_outlined, title:"Notifications", subtitle: "Manage alerts",switchValue: isNotification,onChanged: (value){
                    //   setState(() {
                    //     isNotification = value;
                    //   });
                    // },),
                    // SettingTile(
                    //   iconData: Icons.security,
                    //   title: "Security",
                    //   subtitle: "PIN & Biometrics",
                    // ),
                    SettingTile(
                      iconData: Icons.question_mark,
                      title: "Help & Support",
                      subtitle: "FAQs and Contact",
                    ),
                    SizedBox(height: 50),
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
                      child: Image.asset(DIcons.app_logo1),
                    ),
                    SizedBox(height: 10),
                    Text('Version 1.0.0'),
                    SizedBox(height: 10),
                    Text('Track your money with ease'),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

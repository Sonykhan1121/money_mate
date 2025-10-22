import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/views/add_features/add_expense.dart';
import 'package:money_mate/views/settings_features/setting_page.dart';
import 'package:money_mate/views/transaction_features/transactions.dart';
import 'package:provider/provider.dart';

import '../../providers/navigation_provider.dart';
import '../../utils/constants/colors.dart';
import '../home_features/home_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {


  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (cnxt, navProvider, child) {
        return Scaffold(
          body: navProvider.widgetOptions[navProvider.currentIndex]['page'],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: DColors.grey,width: 0.3),
              )
            ),
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: DColors.primary,
              unselectedItemColor: Colors.grey,
              unselectedIconTheme: IconThemeData(color: DColors.primary),
              currentIndex: navProvider.currentIndex,
              items: navProvider.widgetOptions.map((item) {
                return BottomNavigationBarItem(
                  icon: Icon(item['icon']),
                  label: item['title'].toString(),
                );
              }).toList(),
              onTap: (index){
               navProvider.setCurrentIndex(index);
              },
            ),
          ),
        );
      },
    );
  }
}

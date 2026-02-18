import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/colors.dart';
import '../viewmodels/navigation_provider.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {


  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navProvider, child) {
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

import 'package:flutter/material.dart';

import '../views/add_features/add_expense.dart';
import '../views/home_features/home_page.dart';
import '../views/settings_features/setting_page.dart';
import '../views/transaction_features/transactions.dart';

class NavigationProvider extends ChangeNotifier{

  int _currentIndex = 0;
  final List<Map<String, dynamic>> widgetOptions = [
    {'title': 'Home', 'icon': Icons.home, 'page': HomePage()},
    {'title': 'Add Expense', 'icon': Icons.add, 'page': AddExpense()},
    {
      'title': 'Transactions',
      'icon': Icons.receipt_long,
      'page': Transactions(),
    },
    {'title': 'Settings', 'icon': Icons.settings, 'page': SettingPage()},
  ];

  // setter and getter
  void setCurrentIndex(int i)
  {
    _currentIndex = i;
    notifyListeners();

  }
  int get currentIndex => _currentIndex;




}
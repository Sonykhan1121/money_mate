import 'package:flutter/material.dart';
import '../../../home/presentation/views/home_page.dart';
import '../../../settings/presentation/views/setting_page.dart';
import '../../../../views/transaction_features/transactions.dart';
import '../../../add_expense/presentation/views/add_expense.dart';

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
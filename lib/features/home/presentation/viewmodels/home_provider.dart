import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime get selectedMonth => _selectedMonth;

  void setSelectedMonth(DateTime month) {
    _selectedMonth = month;
    notifyListeners();
  }
}
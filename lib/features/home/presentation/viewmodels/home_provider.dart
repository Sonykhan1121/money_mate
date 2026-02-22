import 'package:flutter/cupertino.dart';
import 'package:money_mate/features/transactions/data/models/transactionModel.dart';

class HomeProvider extends ChangeNotifier{



  final double _totalBalance = 200000;
  double get totalBalance => _totalBalance;
  final double _totalIncome = 15540;
  double get totalIncome => _totalIncome;
  final double _totalExpenses = 10000;
  double get totalExpenses => _totalExpenses;

  List<TransactionModel> _last7Days =[];

  List<TransactionModel> get last7Days => _last7Days;




}
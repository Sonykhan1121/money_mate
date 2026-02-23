import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/transactionType.dart';
import '../../data/models/transactionModel.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionsProvider extends ChangeNotifier {
  final TransactionRepository transactionRepository;

  TransactionsProvider({required this.transactionRepository}) {
    init();
  }

  Future<void> init() async {
    _allTransactions = await transactionRepository.getAllTransactions();
    notifyListeners();
  }

  List<TransactionModel> _allTransactions = [];

  List<TransactionModel> get allTransactions => _allTransactions;

  List<double> getLast7DaysExpenseSeries() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final Map<DateTime, double> dailyTotals = {for (int i = 0; i < 7; i++) today.subtract(Duration(days: i)): 0.0};

    for (final t in _allTransactions) {
      if (t.type != TransactionType.expense) continue;

      final txDate = DateTime(t.customDate.year, t.customDate.month, t.customDate.day);

      if (dailyTotals.containsKey(txDate)) {
        dailyTotals[txDate] = dailyTotals[txDate]! + t.amount;
      }
    }

    // ✅ Explicit sorting (cleaner)
    final sortedEntries = dailyTotals.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.map((e) => e.value).toList();
  }

  List<TransactionModel> getTransactionsByMonth(DateTime month) {
    return _allTransactions.where((t) {
      return t.customDate.year == month.year && t.customDate.month == month.month;
    }).toList();
  }

  double getTotalIncomeByMonth(DateTime month) {
    return getTransactionsByMonth(
      month,
    ).where((t) => t.type == TransactionType.income).fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalExpensesByMonth(DateTime month) {
    return getTransactionsByMonth(
      month,
    ).where((t) => t.type == TransactionType.expense).fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalBalanceByMonth(DateTime month) {
    return getTotalIncomeByMonth(month) - getTotalExpensesByMonth(month);
  }


  List<String> filters = ["Today", "This Week", "This Month", "This Year", "Custom"];

  String _selectedFilter = "";

  String get selectedFilter => _selectedFilter;

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  int compare(TransactionModel a, TransactionModel b) {
    return b.customDate.compareTo(a.customDate);
  }

  Map<String, List<TransactionModel>> listToMap(List<TransactionModel> transactions) {
    transactions.sort(compare);
    Map<String, List<TransactionModel>> result = {};
    final now = DateTime.now();
    String key;
    DateTime today = DateTime(now.year, now.month, now.day);
    for (TransactionModel transaction in transactions) {
      DateTime current = DateTime(
        transaction.customDate.year,
        transaction.customDate.month,
        transaction.customDate.day,
      );
      if (current == today) {
        key = 'Today ${DateFormat('d MMM').format(transaction.customDate)}';
      } else if (current == today.subtract(const Duration(days: 1))) {
        key = 'Yesterday ${DateFormat('d MMM').format(transaction.customDate)}';
      } else {
        key = DateFormat('d MMM').format(transaction.customDate);
      }
      result.putIfAbsent(key, () => []);
      result[key]!.add(transaction);
    }

    return result;
  }

  // In TransactionsProvider
  List<double> getMonthlyExpenseSeries(DateTime month) {
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final List<double> series = List.filled(daysInMonth, 0.0);

    for (final t in _allTransactions) {
      if (t.type != TransactionType.expense) continue;
      if (t.customDate.year == month.year && t.customDate.month == month.month) {
        series[t.customDate.day - 1] += t.amount;
      }
    }
    return series;
  }

  //transactions works

  Future<bool> deleteTransaction(int id) async {
    return await transactionRepository.deleteTransaction(id);
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    return await transactionRepository.getAllTransactions();
  }

  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    return await transactionRepository.getTransactionsByCategory(categoryId);
  }

  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    return await transactionRepository.getTransactionsByType(type);
  }

  Future<bool> updateTransaction(TransactionModel tModel) async {
    return await transactionRepository.updateTransaction(tModel);
  }
}

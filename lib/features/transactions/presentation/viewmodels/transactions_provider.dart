import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
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


  DateTime? _customFrom;
  DateTime? _customTo;

  DateTime? get customFrom => _customFrom;
  DateTime? get customTo   => _customTo;

  void setCustomRange(DateTime from, DateTime to) {
    _customFrom = from;
    _customTo   = to;
    notifyListeners();
  }

// Update setFilter to clear custom range when switching away
  void setFilter(String filter) {
    _selectedFilter = filter;
    if (filter != 'Custom') {
      _customFrom = null;
      _customTo   = null;
    }
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  int compare(TransactionModel a, TransactionModel b) {
    return b.customDate.compareTo(a.customDate);
  }

  Map<String, List<TransactionModel>> listToMap(BuildContext context,
      List<TransactionModel> transactions) {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // ─── Filter ───────────────────────────────────────────────────────────────
    List<TransactionModel> filtered = transactions.where((t) {
      final date = DateTime(t.customDate.year, t.customDate.month, t.customDate.day);

      switch (selectedFilter) {
        case 'Today':
          return date == today;

        case 'This Week':
        // Week starts Saturday (weekday 6), ends Friday (weekday 5)
          final daysFromSaturday = (today.weekday % 6 == 0 ? 0 : today.weekday + 1) % 7;
          final startOfWeek = today.subtract(Duration(days: daysFromSaturday));
          return !date.isBefore(startOfWeek) && !date.isAfter(today);

        case 'This Month':
          return date.year == now.year && date.month == now.month;

        case 'This Year':
          return date.year == now.year;

        case 'Custom':
          if (customFrom == null && customTo == null) return true;

          if (customFrom != null && customTo == null) {
            final from = DateTime(customFrom!.year, customFrom!.month, customFrom!.day);
            return !date.isBefore(from);
          }

          if (customFrom == null && customTo != null) {
            final to = DateTime(customTo!.year, customTo!.month, customTo!.day);
            return !date.isAfter(to);
          }

          // both selected
          final from = DateTime(customFrom!.year, customFrom!.month, customFrom!.day);
          final to   = DateTime(customTo!.year,   customTo!.month,   customTo!.day);
          return !date.isBefore(from) && !date.isAfter(to);

        default: // empty string = All
          return true;
      }
    }).toList();

    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((t) {
        final amount = t.amount.toString();
        final title = t.title.toLowerCase();
        final category = context.addExpenseProvider.getCategoryById(t.categoryId).name.toLowerCase();
        final date   = DateFormat('d MMM yyyy').format(t.customDate).toLowerCase();
        final type   = t.type.name.toLowerCase();

        return title.contains(q) || category.contains(q)||amount.contains(q) || date.contains(q) || type.contains(q) ;
      }).toList();
    }

    // ─── Sort ─────────────────────────────────────────────────────────────────
    filtered.sort(compare);

    // ─── Group ────────────────────────────────────────────────────────────────
    final Map<String, List<TransactionModel>> result = {};

    for (final transaction in filtered) {
      final current = DateTime(
        transaction.customDate.year,
        transaction.customDate.month,
        transaction.customDate.day,
      );

      final String key;
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

  Future<List<TransactionModel>> getAllTransactions() async {
    return await transactionRepository.getAllTransactions();
  }

  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    return await transactionRepository.getTransactionsByCategory(categoryId);
  }

  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    return await transactionRepository.getTransactionsByType(type);
  }
  Future<String?> getTransactionFirstImagePathIfExist(int id) async {
    return _allTransactions.firstWhere((t) => t.id == id).imageUrls?.first;
  }

  Future<bool> deleteTransaction(int id) async {
    final success = await transactionRepository.deleteTransaction(id);
    if (success) {
      try {
        debugPrint('id : $id');
        for (final t in _allTransactions) {
          debugPrint("t.id : ${t.id}");
        }
        _allTransactions.removeWhere((t) => t.id == id);
      } catch (e) {
        debugPrint('delete Error : $e');
      }
      notifyListeners();
    }
    return success;
  }

  Future<bool> updateTransaction(TransactionModel tModel) async {
    final success = await transactionRepository.updateTransaction(tModel);
    if (success) {
      final index = _allTransactions.indexWhere((t) => t.id == tModel.id);
      if (index != -1) {
        _allTransactions[index] = tModel;

      }
      notifyListeners();
    }
    return success;
  }
}

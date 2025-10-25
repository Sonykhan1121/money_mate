import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/catergory.dart';
import '../models/recurringFrequency.dart';
import '../models/transaction.dart';
import '../models/transactionType.dart';

class TransactionsProvider extends ChangeNotifier
{

  List<Transaction> mockTransactions = [
    // --- Day 1 (3 Transactions) ---
    Transaction(
      id: 't_001',
      title: 'Monthly Salary',
      amount: 5500.00,
      type: TransactionType.income,
      categoryId: CAT_SALARY,
      date: DateTime.now().subtract(const Duration(days: 25)),
      createdAt: DateTime.now().subtract(const Duration(days: 25, hours: 1)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
      notes: 'Direct deposit from work.',
    ),
    Transaction(
      id: 't_002',
      title: 'Apartment Rent',
      amount: 1500.00,
      type: TransactionType.expense,
      categoryId: CAT_RENT,
      date: DateTime.now().subtract(const Duration(days: 25)),
      createdAt: DateTime.now().subtract(const Duration(days: 25, minutes: 10)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
      description: 'October rent payment.',
    ),
    Transaction(
      id: 't_003',
      title: 'Online Subscription',
      amount: 12.99,
      type: TransactionType.expense,
      categoryId: 'cat_007', // Assume 'Subscription'
      date: DateTime.now().subtract(const Duration(days: 25)),
      createdAt: DateTime.now().subtract(const Duration(days: 25, hours: 2)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
      paymentMethod: 'PayPal',
    ),

    // --- Day 2 (4 Transactions) ---
    Transaction(
      id: 't_004',
      title: 'Investment Dividend',
      amount: 45.75,
      type: TransactionType.income,
      categoryId: CAT_INVESTMENT,
      date: DateTime.now().subtract(const Duration(days: 20)),
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 2)),
      paymentMethod: 'Bank Transfer',
    ),
    Transaction(
      id: 't_005',
      title: 'New Book Purchase',
      amount: 25.50,
      type: TransactionType.expense,
      categoryId: 'cat_008', // Assume 'Education/Books'
      date: DateTime.now().subtract(const Duration(days: 20)),
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 5)),
      tags: ['reading', 'hobby'],
    ),
    Transaction(
      id: 't_006',
      title: 'Gym Membership',
      amount: 50.00,
      type: TransactionType.expense,
      categoryId: 'cat_006', // Assume 'Health' category
      date: DateTime.now().subtract(const Duration(days: 20)),
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 12)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
    ),
    Transaction(
      id: 't_007',
      title: 'Coffee Shop',
      amount: 4.50,
      type: TransactionType.expense,
      categoryId: CAT_GROCERIES,
      date: DateTime.now().subtract(const Duration(days: 20)),
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 15)),
      location: 'Downtown Cafe',
      tags: ['social'],
    ),

    // --- Day 3 (3 Transactions) ---
    Transaction(
      id: 't_008',
      title: 'Freelance Project Payout',
      amount: 750.00,
      type: TransactionType.income,
      categoryId: CAT_SALARY,
      date: DateTime.now().subtract(const Duration(days: 15)),
      createdAt: DateTime.now().subtract(const Duration(days: 15, hours: 4)),
      notes: 'Payment for web design work.',
      paymentMethod: 'TransferWise',
    ),
    Transaction(
      id: 't_009',
      title: 'Dinner Out',
      amount: 68.30,
      type: TransactionType.expense,
      categoryId: 'cat_009', // Assume 'Dining Out'
      date: DateTime.now().subtract(const Duration(days: 15)),
      createdAt: DateTime.now().subtract(const Duration(days: 15, hours: 7)),
      hasReceipt: true,
      tags: ['food', 'social'],
    ),
    Transaction(
      id: 't_010',
      title: 'Gas Refill',
      amount: 45.00,
      type: TransactionType.expense,
      categoryId: CAT_TRANSPORT,
      date: DateTime.now().subtract(const Duration(days: 15)),
      createdAt: DateTime.now().subtract(const Duration(days: 15, hours: 10)),
      location: 'Shell Station',
    ),

    // --- Day 4 (3 Transactions) ---
    Transaction(
      id: 't_011',
      title: 'Weekly Groceries',
      amount: 85.50,
      type: TransactionType.expense,
      categoryId: CAT_GROCERIES,
      date: DateTime.now().subtract(const Duration(days: 10)),
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 6)),
      hasReceipt: true,
      receiptPath: '/app_data/receipts/t_011.jpg',
      location: 'SuperMart Local',
      paymentMethod: 'Credit Card',
      tags: ['food', 'essentials'],
    ),
    Transaction(
      id: 't_012',
      title: 'Movie Tickets',
      amount: 32.00,
      type: TransactionType.expense,
      categoryId: 'cat_010', // Assume 'Entertainment'
      date: DateTime.now().subtract(const Duration(days: 10)),
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 11)),
      tags: ['leisure'],
    ),
    Transaction(
      id: 't_013',
      title: 'Cash Withdrawal',
      amount: 100.00,
      type: TransactionType.expense,
      categoryId: 'cat_011', // Assume 'Cash'
      date: DateTime.now().subtract(const Duration(days: 10)),
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 14)),
      location: 'Local ATM',
      paymentMethod: 'Debit Card',
    ),

    // --- Day 5 (4 Transactions) ---
    Transaction(
      id: 't_014',
      title: 'Refund - Defective Item',
      amount: 120.00,
      type: TransactionType.income,
      categoryId: 'cat_012', // Assume 'Refund'
      date: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
      description: 'Refund from online retailer.',
    ),
    Transaction(
      id: 't_015',
      title: 'Utility Bill - Electricity',
      amount: 95.50,
      type: TransactionType.expense,
      categoryId: 'cat_013', // Assume 'Utilities'
      date: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 3)),
      isRecurring: true,

    ),
    Transaction(
      id: 't_016',
      title: 'New Headphones',
      amount: 159.99,
      type: TransactionType.expense,
      categoryId: 'cat_014', // Assume 'Electronics'
      date: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 8)),
      paymentMethod: 'Credit Card',
    ),
    Transaction(
      id: 't_017',
      title: 'Car Wash',
      amount: 15.00,
      type: TransactionType.expense,
      categoryId: CAT_TRANSPORT,
      date: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 12)),
      tags: ['car care'],
    ),

    // --- Today (3 Transactions) ---
    Transaction(
      id: 't_018',
      title: 'Bus Fare',
      amount: 2.50,
      type: TransactionType.expense,
      categoryId: CAT_TRANSPORT,
      date: DateTime.now(), // Today
      createdAt: DateTime.now().subtract(const Duration(minutes: 90)),
      tags: ['travel'],
      location: 'Metro Station',
    ),
    Transaction(
      id: 't_019',
      title: 'Lunch with Client',
      amount: 42.00,
      type: TransactionType.expense,
      categoryId: CAT_GROCERIES, // Using a generic category
      date: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(minutes: 60)),
      hasReceipt: true,
      tags: ['work', 'food'],
      imageUrl: 'http://example.com/receipt_t019.png',
    ),
    Transaction(
      id: 't_020',
      title: 'Stock Sale',
      amount: 250.00,
      type: TransactionType.income,
      categoryId: CAT_INVESTMENT,
      date: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      notes: 'Profits from a small stock sale.',
    ),
  ];

  final List<CategoryModel> demoCategories = [
    // Income Categories
    CategoryModel(
      id: '1',
      name: 'Salary',
      nameLocalised: 'বেতন',
      icon: '💰',
      colorHex: '#4CAF50', // green
      type: TransactionType.income,
      isDefault: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Bonus',
      nameLocalised: 'বোনাস',
      icon: '🎁',
      colorHex: '#FF9800', // orange
      type: TransactionType.income,
    ),
    CategoryModel(
      id: '3',
      name: 'Investment',
      nameLocalised: 'বিনিয়োগ',
      icon: '📈',
      colorHex: '#2196F3', // blue
      type: TransactionType.income,
    ),

    // Expense Categories
    CategoryModel(
      id: '4',
      name: 'Food',
      nameLocalised: 'খাবার',
      icon: '🍔',
      colorHex: '#F44336', // red
      type: TransactionType.expense,
      isDefault: true,
    ),
    CategoryModel(
      id: '5',
      name: 'Transport',
      nameLocalised: 'পরিবহন',
      icon: '🚌',
      colorHex: '#FFC107', // amber
      type: TransactionType.expense,
    ),
    CategoryModel(
      id: '6',
      name: 'Shopping',
      nameLocalised: 'কেনাকাটা',
      icon: '🛍️',
      colorHex: '#9C27B0', // purple
      type: TransactionType.expense,
    ),
    CategoryModel(
      id: '7',
      name: 'Entertainment',
      nameLocalised: 'বিনোদন',
      icon: '🎬',
      colorHex: '#03A9F4', // light blue
      type: TransactionType.expense,
    ),
    CategoryModel(
      id: '8',
      name: 'Health',
      nameLocalised: 'স্বাস্থ্য',
      icon: '💊',
      colorHex: '#8BC34A', // light green
      type: TransactionType.expense,
    ),
  ];

  List<String> filters = ["Today", "This Week", "This Month", "This Year","Custom"];

   String _selectedFilter = "";
  String get selectedFilter => _selectedFilter;

  void setFilter(String filter)
  {
    _selectedFilter = filter;
    notifyListeners();
  }
  Map<String,List<Transaction>> listToMap(List<Transaction> transactions)  {
    Map<String, List<Transaction>> result = {};
    final now = DateTime.now();
    String key;
    DateTime today = DateTime(now.year,now.month,now.day);
    for(Transaction transaction in transactions) {
      
      DateTime current = DateTime(transaction.date.year,transaction.date.month,transaction.date.day);
      if(current==today)
        {
            key = 'Today ${DateFormat('d MMM').format(transaction.date)}';
        }
      else if(current==today.subtract(const Duration(days: 1)))
          {
            key = 'Yesterday ${DateFormat('d MMM').format(transaction.date)}';
          }
        else{
        key = DateFormat('d MMMM').format(transaction.date);
          }
      result.putIfAbsent(key, () => []);
      result[key]!.add(transaction);
    }

    return result;
  }

}
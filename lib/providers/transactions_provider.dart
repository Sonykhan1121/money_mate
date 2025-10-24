import 'package:flutter/cupertino.dart';

import '../models/catergory.dart';
import '../models/recurringFrequency.dart';
import '../models/transaction.dart';
import '../models/transactionType.dart';

class TransactionsProvider extends ChangeNotifier
{

  List<Transaction> mockTransactions = [
    Transaction(
      id: 't_001',
      title: 'Monthly Salary',
      amount: 5500.00,
      type: TransactionType.income,
      categoryId: CAT_SALARY,
      date: DateTime.now().subtract(const Duration(days: 3)),
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 1)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
      notes: 'Direct deposit from work.',
    ),
    Transaction(
      id: 't_002',
      title: 'Weekly Groceries',
      amount: 85.50,
      type: TransactionType.expense,
      categoryId: CAT_GROCERIES,
      date: DateTime.now().subtract(const Duration(hours: 5)),
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      hasReceipt: true,
      receiptPath: '/app_data/receipts/t_002.jpg',
      location: 'SuperMart Local',
      paymentMethod: 'Credit Card',
      tags: ['food', 'essentials'],
    ),
    Transaction(
      id: 't_003',
      title: 'Apartment Rent',
      amount: 1500.00,
      type: TransactionType.expense,
      categoryId: CAT_RENT,
      date: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now().subtract(const Duration(days: 5, minutes: 10)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
      description: 'October rent payment.',
    ),
    Transaction(
      id: 't_004',
      title: 'Investment Dividend',
      amount: 45.75,
      type: TransactionType.income,
      categoryId: CAT_INVESTMENT,
      date: DateTime.now().subtract(const Duration(days: 10)),
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 2)),
      paymentMethod: 'Bank Transfer',
    ),
    Transaction(
      id: 't_005',
      title: 'Bus Fare',
      amount: 2.50,
      type: TransactionType.expense,
      categoryId: CAT_TRANSPORT,
      date: DateTime.now(), // Today
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      tags: ['travel'],
      location: 'Metro Station',
    ),
    Transaction(
      id: 't_006',
      title: 'Lunch with Client',
      amount: 42.00,
      type: TransactionType.expense,
      categoryId: CAT_GROCERIES, // Using a generic category
      date: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      hasReceipt: true,
      tags: ['work', 'food'],
      imageUrl: 'http://example.com/receipt_t006.png',
    ),
    Transaction(
      id: 't_007',
      title: 'Gym Membership',
      amount: 50.00,
      type: TransactionType.expense,
      categoryId: 'cat_006', // Assume a 'Health' category
      date: DateTime.now().subtract(const Duration(days: 20)),
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 12)),
      isRecurring: true,
      recurringFrequency: RecurringFrequency.monthly,
    ),
  ];
}
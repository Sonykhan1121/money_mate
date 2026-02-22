import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_mate/features/transactions/data/repositories/transaction_repository_epl.dart';
import '../../data/models/transactionModel.dart';
import '../../data/models/transactionType.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionsProvider extends ChangeNotifier
{
  final TransactionRepository transactionRepository;

  TransactionsProvider({required this.transactionRepository}){
    init();
  }
  Future<void> init() async{
    _allTransactions = await transactionRepository.getAllTransactions();
    notifyListeners();
  }

    List<TransactionModel> _allTransactions =[] ;

  List<TransactionModel> get allTransactions => _allTransactions;


  // final List<TransactionModel> mockTransactions = [
  //   // --- INCOME ---
  //   TransactionModel(
  //     id: 1,
  //     title: 'Monthly Salary',
  //     amount: 55000.0,
  //     type: TransactionType.income,
  //     categoryId: '1', // Salary
  //     description: 'January monthly pay',
  //     createdAt: DateTime.now().subtract(const Duration(days: 19)),
  //     customDate: DateTime.now().subtract(const Duration(days: 19)),
  //     paymentMethod: 'Bank Transfer',
  //     tags: ['Work', 'Main'],
  //   ),
  //   TransactionModel(
  //     id: 2,
  //     title: 'Project Freelance',
  //     amount: 12000.0,
  //     type: TransactionType.income,
  //     categoryId: '4', // Freelancing
  //     description: 'Mobile App UI Design',
  //     createdAt: DateTime.now().subtract(const Duration(days: 15)),
  //     customDate: DateTime.now().subtract(const Duration(days: 15)),
  //     paymentMethod: 'Payoneer',
  //     tags: ['SideHustle'],
  //   ),
  //   TransactionModel(
  //     id: 3,
  //     title: 'Birthday Gift',
  //     amount: 2000.0,
  //     type: TransactionType.income,
  //     categoryId: '8', // Gifts
  //     createdAt: DateTime.now().subtract(const Duration(days: 5)),
  //     customDate: DateTime.now().subtract(const Duration(days: 5)),
  //     paymentMethod: 'Cash',
  //   ),
  //
  //   // --- EXPENSES: ESSENTIALS ---
  //   TransactionModel(
  //     id: 4,
  //     title: 'Bazaar Grocery',
  //     amount: 3500.0,
  //     type: TransactionType.expense,
  //     categoryId: '11', // Groceries
  //     createdAt: DateTime.now().subtract(const Duration(days: 1)),
  //     customDate: DateTime.now().subtract(const Duration(days: 1)),
  //     location: 'Swapno Supershop',
  //     paymentMethod: 'bKash',
  //   ),
  //   TransactionModel(
  //     id: 5,
  //     title: 'Apartment Rent',
  //     amount: 18000.0,
  //     type: TransactionType.expense,
  //     categoryId: '12', // Rent
  //     createdAt: DateTime.now().subtract(const Duration(days: 18)),
  //     customDate: DateTime.now().subtract(const Duration(days: 10)),
  //     paymentMethod: 'Bank Transfer',
  //     notes: 'Paid via mobile banking',
  //   ),
  //   TransactionModel(
  //     id: 6,
  //     title: 'Electricity Bill',
  //     amount: 2450.0,
  //     type: TransactionType.expense,
  //     categoryId: '13', // Electricity
  //     createdAt: DateTime.now().subtract(const Duration(days: 10)),
  //     customDate: DateTime.now().subtract(const Duration(days: 10)),
  //     paymentMethod: 'Nagad',
  //   ),
  //
  //   // --- EXPENSES: LIFESTYLE ---
  //   TransactionModel(
  //     id: 7,
  //     title: 'Dinner with Friends',
  //     amount: 1200.0,
  //     type: TransactionType.expense,
  //     categoryId: '29', // Restaurant
  //     createdAt: DateTime.now().subtract(const Duration(days: 2)),
  //     customDate: DateTime.now().subtract(const Duration(days: 2)),
  //     location: 'Chillox',
  //     paymentMethod: 'Card',
  //     tags: ['Social', 'Weekend'],
  //   ),
  //   TransactionModel(
  //     id: 8,
  //     title: 'New Sneakers',
  //     amount: 4500.0,
  //     type: TransactionType.expense,
  //     categoryId: '28', // Shopping
  //     createdAt: DateTime.now().subtract(const Duration(days: 12)),
  //     customDate: DateTime.now().subtract(const Duration(days: 12)),
  //     paymentMethod: 'Card',
  //     description: 'Bata Apex Sale',
  //   ),
  //   TransactionModel(
  //     id: 9,
  //     title: 'Netflix Subscription',
  //     amount: 1100.0,
  //     type: TransactionType.expense,
  //     categoryId: '34', // Subscription
  //     createdAt: DateTime.now().subtract(const Duration(days: 20)),
  //     customDate: DateTime.now().subtract(const Duration(days: 20)),
  //     paymentMethod: 'Credit Card',
  //   ),
  //
  //   // --- EXPENSES: TRANSPORT ---
  //   TransactionModel(
  //     id:10,
  //     title: 'Uber Ride to Office',
  //     amount: 350.0,
  //     type: TransactionType.expense,
  //     categoryId: '22', // Taxi/Uber
  //     createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  //     customDate: DateTime.now().subtract(const Duration(hours: 5)),
  //     paymentMethod: 'bKash',
  //   ),
  //   TransactionModel(
  //     id: 11,
  //     title: 'Bike Fuel',
  //     amount: 1000.0,
  //     type: TransactionType.expense,
  //     categoryId: '23', // Fuel
  //     createdAt: DateTime.now().subtract(const Duration(days: 3)),
  //     customDate: DateTime.now().subtract(const Duration(days: 3)),
  //     location: 'Trust Filling Station',
  //     paymentMethod: 'Cash',
  //   ),
  //
  //   // --- EXPENSES: OTHERS ---
  //   TransactionModel(
  //     id: 12,
  //     title: 'Gym Membership',
  //     amount: 2000.0,
  //     type: TransactionType.expense,
  //     categoryId: '32', // Gym
  //     createdAt: DateTime.now().subtract(const Duration(days: 25)),
  //     customDate: DateTime.now().subtract(const Duration(days: 25)),
  //     paymentMethod: 'Cash',
  //   ),
  //   TransactionModel(
  //     id: 13,
  //     title: 'Medical Checkup',
  //     amount: 1500.0,
  //     type: TransactionType.expense,
  //     categoryId: '19', // Doctor
  //     createdAt: DateTime.now().subtract(const Duration(days: 8)),
  //     customDate: DateTime.now().subtract(const Duration(days: 8)),
  //     paymentMethod: 'Card',
  //   ),
  //   TransactionModel(
  //     id: 14,
  //     title: 'Stock Investment',
  //     amount: 5000.0,
  //     type: TransactionType.expense, // Cash outflow to assets
  //     categoryId: '46', // Investment Exp
  //     createdAt: DateTime.now().subtract(const Duration(days: 4)),
  //     customDate: DateTime.now().subtract(const Duration(days: 4)),
  //     paymentMethod: 'Bank Transfer',
  //     tags: ['Assets'],
  //   ),
  //   TransactionModel(
  //     id: 15,
  //     title: 'Charity Donation',
  //     amount: 500.0,
  //     type: TransactionType.expense,
  //     categoryId: '42', // Charity
  //     createdAt: DateTime.now().subtract(const Duration(days: 6)),
  //     customDate: DateTime.now().subtract(const Duration(days: 6)),
  //     paymentMethod: 'bKash',
  //   ),
  // ];

  List<String> filters = ["Today", "This Week", "This Month", "This Year","Custom"];

   String _selectedFilter = "";
  String get selectedFilter => _selectedFilter;

  void setFilter(String filter)
  {
    _selectedFilter = filter;
    notifyListeners();
  }

  int compare(TransactionModel a ,TransactionModel b)
  {
    return b.customDate.compareTo(a.customDate);
  }

  Map<String,List<TransactionModel>> listToMap(List<TransactionModel> transactions)  {
     transactions.sort(compare);
    Map<String, List<TransactionModel>> result = {};
    final now = DateTime.now();
    String key;
    DateTime today = DateTime(now.year,now.month,now.day);
    for(TransactionModel transaction in transactions) {
      
      DateTime current = DateTime(transaction.customDate.year,transaction.customDate.month,transaction.customDate.day);
      if(current==today)
        {
            key = 'Today ${DateFormat('d MMM').format(transaction.customDate)}';
        }
      else if(current==today.subtract(const Duration(days: 1)))
          {
            key = 'Yesterday ${DateFormat('d MMM').format(transaction.customDate)}';
          }
        else{
        key = DateFormat('d MMM').format(transaction.customDate);
          }
      result.putIfAbsent(key, () => []);
      result[key]!.add(transaction);
    }

    return result;
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
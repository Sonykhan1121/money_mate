import 'package:flutter/cupertino.dart';
import 'package:isar_plus/isar_plus.dart';
import '../models/transaction_type.dart';
import '../models/transaction_model.dart';
import '../../../../core/services/isar_service.dart';

class TransactionService {
  // ─── Singleton ──────────────────────────────
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final _isarService = IsarService();
  Future<Isar> get db => _isarService.db;

  // ─── CRUD Operations ────────────────────────

  /// Adds a transaction
  Future<void> addTransaction(TransactionModel txn) async {
    debugPrint("addTransaction called : $txn");
    try {
      final isar = await db;
      await isar.writeAsync((isar)  {
         isar.transactionModels.put(txn); // put acts as upsert
      });
    } catch (e) {
      debugPrint('Error adding transaction: $e');
    }
  }

  /// Returns all transactions
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final isar = await db;
      return await isar.transactionModels.where().findAll();
    } catch (e) {
      debugPrint('Error fetching transactions: $e');
      return [];
    }
  }

  /// Updates a transaction
  Future<bool> updateTransaction(TransactionModel txn) async {
    debugPrint("updateTransaction called : $txn");
    try {
      final isar = await db;
      await isar.writeAsync((isar)  {
         isar.transactionModels.put(txn);
      });
      return true;
    } catch (e) {
      debugPrint('Error updating transaction: $e');
      return false;
    }
  }

  /// Deletes a transaction by id
  Future<bool> deleteTransaction(int id) async {
    try {
      final isar = await db;
      return await isar.writeAsync((isar)  {
        return  isar.transactionModels.delete(id);
      });
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      return false;
    }
  }

  /// Get transactions by category
  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    try {
      final isar = await db;
      // Use where() + generated query method (categoryId must be @Index)
      return  isar.transactionModels
          .where()
          .categoryIdEqualTo(categoryId)
          .findAll();
    } catch (e) {
      debugPrint('Error fetching by category: $e');
      return [];
    }
  }

  /// Get transactions by type
  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    try {
      final isar = await db;
      // Use where() + generated query method (type must be @Index + @enumValue)
      return  isar.transactionModels
          .where()
          .typeEqualTo(type)
          .findAll();
    } catch (e) {
      debugPrint('Error fetching by type: $e');
      return [];
    }
  }
}
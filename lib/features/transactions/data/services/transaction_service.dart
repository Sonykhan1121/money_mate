import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import '../../../../core/services/isar_service.dart';
import '../models/transactionType.dart';
import '../models/transactionModel.dart';
import 'package:path_provider/path_provider.dart';

class TransactionService {
  // ─── Singleton ──────────────────────────────
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final _isarService = IsarService();
  Future<Isar> get db => _isarService.db;

  // ─── CRUD Operations ────────────────────────

  /// Adds a transaction and returns the inserted id
  Future<int?> addTransaction(TransactionModel txn) async {
    debugPrint("addTransaction called : $txn");
    try {
      final isar = await db;
      return await isar.writeTxn(() async {
        return await isar.transactionModels.put(txn);
      });
    } catch (e) {
      print('Error adding transaction: $e');
      return null; // null indicates failure
    }
  }

  /// Returns all transactions
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final isar = await db;
      return await isar.transactionModels.where().findAll();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  /// Updates a transaction, returns true if successful
  Future<bool> updateTransaction(TransactionModel txn) async {
    try {
      final isar = await db;
      return await isar.writeTxn(() async {
        final id = await isar.transactionModels.put(txn);
        return id != 0; // put returns 0 if failed
      });
    } catch (e) {
      print('Error updating transaction: $e');
      return false;
    }
  }

  /// Deletes a transaction by id, returns true if deleted
  Future<bool> deleteTransaction(int id) async {
    try {
      final isar = await db;
      return await isar.writeTxn(() async {
        return await isar.transactionModels.delete(id);
      });
    } catch (e) {
      print('Error deleting transaction: $e');
      return false;
    }
  }

  /// Get transactions by category
  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    try {
      final isar = await db;
      return await isar.transactionModels.filter()
          .categoryIdEqualTo(categoryId)
          .findAll();
    } catch (e) {
      print('Error fetching by category: $e');
      return [];
    }
  }

  /// Get transactions by type
  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    try {
      final isar = await db;
      return await isar.transactionModels.filter()
          .typeEqualTo(type)
          .findAll();
    } catch (e) {
      print('Error fetching by type: $e');
      return [];
    }
  }
}
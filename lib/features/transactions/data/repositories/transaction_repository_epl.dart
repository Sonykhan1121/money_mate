import '../../domain/repositories/transaction_repository.dart';
import 'package:money_mate/features/transactions/data/models/transaction_type.dart';
import 'package:money_mate/features/transactions/data/models/transaction_model.dart';
import 'package:money_mate/features/transactions/data/services/transaction_service.dart';


class TransactionRepositoryEpl extends TransactionRepository {
  final TransactionService transactionService;

  TransactionRepositoryEpl({required this.transactionService});

  @override
  Future<int?> addTransaction(TransactionModel tModel) async {
    return await transactionService.addTransaction(tModel);
  }

  @override
  Future<bool> deleteTransaction(int id) async {
    return await transactionService.deleteTransaction(id);
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    return await transactionService.getAllTransactions();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId) async {
    return await transactionService.getTransactionsByCategory(categoryId);
  }

  @override
  Future<List<TransactionModel>> getTransactionsByType(TransactionType type) async {
    return await transactionService.getTransactionsByType(type);
  }

  @override
  Future<bool> updateTransaction(TransactionModel tModel) async {
    return await transactionService.updateTransaction(tModel);
  }
}

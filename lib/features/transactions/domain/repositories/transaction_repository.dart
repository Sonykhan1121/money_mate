import '../../data/models/transaction_type.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionModel tModel);

  Future<List<TransactionModel>> getAllTransactions();

  Future<bool> updateTransaction(TransactionModel tModel);

  Future<bool> deleteTransaction(int id);

  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId);

  Future<List<TransactionModel>> getTransactionsByType(TransactionType type);
}

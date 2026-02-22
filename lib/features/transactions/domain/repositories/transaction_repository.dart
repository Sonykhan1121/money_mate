import '../../data/models/transactionType.dart';
import '../../data/models/transactionModel.dart';

abstract class TransactionRepository {
  Future<int?> addTransaction(TransactionModel tModel);

  Future<List<TransactionModel>> getAllTransactions();

  Future<bool> updateTransaction(TransactionModel tModel);

  Future<bool> deleteTransaction(int id);

  Future<List<TransactionModel>> getTransactionsByCategory(String categoryId);

  Future<List<TransactionModel>> getTransactionsByType(TransactionType type);
}

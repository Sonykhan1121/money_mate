import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/profile/data/models/profile_model.dart';
import '../../features/transactions/data/models/transactionModel.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _db;

  Future<Isar> get db async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open(
      [TransactionModelSchema, ProfileModelSchema],
      directory: dir.path,
    );
    return _db!;
  }
}
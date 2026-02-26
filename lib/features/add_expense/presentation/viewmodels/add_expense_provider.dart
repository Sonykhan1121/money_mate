import '../../data/models/result.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/category.dart';
import '../../../transactions/data/models/transaction_type.dart';
import '../../../transactions/data/models/transaction_model.dart';
import '../../domain/repositories/document_scanner_repository.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';


class AddExpenseProvider extends ChangeNotifier {

  bool _isScanning = false;
  String? _errorMessage;

  final DocumentScannerRepository _repository;
  final TransactionRepository _transactionRepository;
  AddExpenseProvider({required DocumentScannerRepository repository,required TransactionRepository transactionRepository})
      : _repository = repository,_transactionRepository = transactionRepository;

  bool get isScanning=> _isScanning;
  String? get errorMessage=> _errorMessage;

  //image path
  List<String> _tempImagePaths = [];

  List<String> get imagePaths => _tempImagePaths;

  void setImagePaths(List<String> val) {
    _tempImagePaths = val;
    notifyListeners();
  }

  void addImagePath(String path)
  {
    _tempImagePaths.add(path);
    notifyListeners();
  }

  void removeImagePath(int index)
  {
    _tempImagePaths.removeAt(index);
    notifyListeners();
  }

  void clearImagePaths()
  {
    _tempImagePaths = [];
    notifyListeners();
  }


  final List<CategoryModel> _demoCategories = [
    // --- INCOME CATEGORIES (1-10) ---
    CategoryModel(id: '1', name: 'Salary', nameLocalised: 'বেতন', icon: '💰', colorHex: '#4CAF50', type: TransactionType.income, isDefault: true),
    CategoryModel(id: '2', name: 'Bonus', nameLocalised: 'বোনাস', icon: '🎁', colorHex: '#FF9800', type: TransactionType.income),
    CategoryModel(id: '3', name: 'Investment', nameLocalised: 'বিনিয়োগ', icon: '📈', colorHex: '#2196F3', type: TransactionType.income),
    CategoryModel(id: '4', name: 'Freelancing', nameLocalised: 'ফ্রিল্যান্সিং', icon: '💻', colorHex: '#673AB7', type: TransactionType.income),
    CategoryModel(id: '5', name: 'Business', nameLocalised: 'ব্যবসা', icon: '🏢', colorHex: '#009688', type: TransactionType.income),
    CategoryModel(id: '6', name: 'Rent', nameLocalised: 'ভাড়া', icon: '🏠', colorHex: '#795548', type: TransactionType.income),
    CategoryModel(id: '7', name: 'Grants/Scholarship', nameLocalised: 'অনুদান/বৃত্তি', icon: '🎓', colorHex: '#3F51B5', type: TransactionType.income),
    CategoryModel(id: '8', name: 'Gifts', nameLocalised: 'উপহার', icon: '🧧', colorHex: '#E91E63', type: TransactionType.income),
    CategoryModel(id: '9', name: 'Interest', nameLocalised: 'সুদ', icon: '🏦', colorHex: '#00BCD4', type: TransactionType.income),
    CategoryModel(id: '10', name: 'Others (Income)', nameLocalised: 'অন্যান্য (আয়)', icon: '➕', colorHex: '#9E9E9E', type: TransactionType.income),

    // --- EXPENSE: ESSENTIALS (11-20) ---
    CategoryModel(id: '11', name: 'Food/Groceries', nameLocalised: 'খাবার/বাজার', icon: '🛒', colorHex: '#F44336', type: TransactionType.expense, isDefault: true),
    CategoryModel(id: '12', name: 'Rent/Mortgage', nameLocalised: 'বাসা ভাড়া', icon: '🏠', colorHex: '#795548', type: TransactionType.expense),
    CategoryModel(id: '13', name: 'Electricity Bill', nameLocalised: 'বিদ্যুৎ বিল', icon: '⚡', colorHex: '#FFEB3B', type: TransactionType.expense),
    CategoryModel(id: '14', name: 'Water Bill', nameLocalised: 'পানি বিল', icon: '🚰', colorHex: '#03A9F4', type: TransactionType.expense),
    CategoryModel(id: '15', name: 'Gas Bill', nameLocalised: 'গ্যাস বিল', icon: '🔥', colorHex: '#FF5722', type: TransactionType.expense),
    CategoryModel(id: '16', name: 'Internet Bill', nameLocalised: 'ইন্টারনেট বিল', icon: '🌐', colorHex: '#3F51B5', type: TransactionType.expense),
    CategoryModel(id: '17', name: 'Mobile Recharge', nameLocalised: 'মোবাইল রিচার্জ', icon: '📱', colorHex: '#4CAF50', type: TransactionType.expense),
    CategoryModel(id: '18', name: 'Medicine', nameLocalised: 'ওষুধ', icon: '💊', colorHex: '#E91E63', type: TransactionType.expense),
    CategoryModel(id: '19', name: 'Doctor Visit', nameLocalised: 'ডাক্তার', icon: '👨‍⚕️', colorHex: '#009688', type: TransactionType.expense),
    CategoryModel(id: '20', name: 'Education', nameLocalised: 'শিক্ষা', icon: '📚', colorHex: '#673AB7', type: TransactionType.expense),

    // --- EXPENSE: TRANSPORT & AUTO (21-27) ---
    CategoryModel(id: '21', name: 'Bus/Train Fare', nameLocalised: 'বাস/ট্রেন ভাড়া', icon: '🚌', colorHex: '#FFC107', type: TransactionType.expense),
    CategoryModel(id: '22', name: 'Taxi/Uber', nameLocalised: 'ট্যাক্সি/উবার', icon: '🚕', colorHex: '#FFEB3B', type: TransactionType.expense),
    CategoryModel(id: '23', name: 'Fuel/Petrol', nameLocalised: 'জ্বালানি', icon: '⛽', colorHex: '#F44336', type: TransactionType.expense),
    CategoryModel(id: '24', name: 'Car Maintenance', nameLocalised: 'গাড়ি মেরামত', icon: '🛠️', colorHex: '#607D8B', type: TransactionType.expense),
    CategoryModel(id: '25', name: 'Parking', nameLocalised: 'পার্কিং', icon: '🅿️', colorHex: '#2196F3', type: TransactionType.expense),
    CategoryModel(id: '26', name: 'Bicycle', nameLocalised: 'সাইকেল', icon: '🚲', colorHex: '#4CAF50', type: TransactionType.expense),
    CategoryModel(id: '27', name: 'Flights', nameLocalised: 'বিমান', icon: '✈️', colorHex: '#03A9F4', type: TransactionType.expense),

    // --- EXPENSE: LIFESTYLE & LEISURE (28-35) ---
    CategoryModel(id: '28', name: 'Shopping', nameLocalised: 'কেনাকাটা', icon: '🛍️', colorHex: '#9C27B0', type: TransactionType.expense),
    CategoryModel(id: '29', name: 'Restaurants', nameLocalised: 'রেস্টুরেন্ট', icon: '🍽️', colorHex: '#FF5722', type: TransactionType.expense),
    CategoryModel(id: '30', name: 'Coffee/Snacks', nameLocalised: 'কফি/নাস্তা', icon: '☕', colorHex: '#795548', type: TransactionType.expense),
    CategoryModel(id: '31', name: 'Movies', nameLocalised: 'সিনেমা', icon: '🎬', colorHex: '#E91E63', type: TransactionType.expense),
    CategoryModel(id: '32', name: 'Gym/Sports', nameLocalised: 'জিম/খেলাধুলা', icon: '🏋️', colorHex: '#8BC34A', type: TransactionType.expense),
    CategoryModel(id: '33', name: 'Travel/Vacation', nameLocalised: 'ভ্রমণ', icon: '🏖️', colorHex: '#00BCD4', type: TransactionType.expense),
    CategoryModel(id: '34', name: 'Subscriptions', nameLocalised: 'সাবস্ক্রিপশন', icon: '📺', colorHex: '#F44336', type: TransactionType.expense),
    CategoryModel(id: '35', name: 'Hobbies', nameLocalised: 'শখ', icon: '🎨', colorHex: '#FF9800', type: TransactionType.expense),

    // --- EXPENSE: FAMILY & HOME (36-42) ---
    CategoryModel(id: '36', name: 'Kids/Childcare', nameLocalised: 'বাচ্চাদের যত্ন', icon: '👶', colorHex: '#FF4081', type: TransactionType.expense),
    CategoryModel(id: '37', name: 'Home Decor', nameLocalised: 'ঘর সাজানো', icon: '🛋️', colorHex: '#3F51B5', type: TransactionType.expense),
    CategoryModel(id: '38', name: 'Cleaning Supplies', nameLocalised: 'পরিষ্কারক সামগ্রী', icon: '🧹', colorHex: '#00ACC1', type: TransactionType.expense),
    CategoryModel(id: '39', name: 'Pets', nameLocalised: 'পোষা প্রাণী', icon: '🐾', colorHex: '#795548', type: TransactionType.expense),
    CategoryModel(id: '40', name: 'Laundry', nameLocalised: 'লন্ড্রি', icon: '🧺', colorHex: '#2196F3', type: TransactionType.expense),
    CategoryModel(id: '41', name: 'Gifts Given', nameLocalised: 'উপহার প্রদান', icon: '💝', colorHex: '#E91E63', type: TransactionType.expense),
    CategoryModel(id: '42', name: 'Charity/Zakat', nameLocalised: 'দান/যাকাত', icon: '🤝', colorHex: '#4CAF50', type: TransactionType.expense),

    // --- EXPENSE: FINANCIAL & MISC (43-50) ---
    CategoryModel(id: '43', name: 'Insurance', nameLocalised: 'বীমা', icon: '🛡️', colorHex: '#607D8B', type: TransactionType.expense),
    CategoryModel(id: '44', name: 'Tax', nameLocalised: 'কর', icon: '📝', colorHex: '#F44336', type: TransactionType.expense),
    CategoryModel(id: '45', name: 'Loan EMI', nameLocalised: 'ঋণের কিস্তি', icon: '📉', colorHex: '#9C27B0', type: TransactionType.expense),
    CategoryModel(id: '46', name: 'Investment Exp', nameLocalised: 'বিনিয়োগ খরচ', icon: '📊', colorHex: '#009688', type: TransactionType.expense),
    CategoryModel(id: '47', name: 'Bank Fees', nameLocalised: 'ব্যাংক ফি', icon: '🏧', colorHex: '#455A64', type: TransactionType.expense),
    CategoryModel(id: '48', name: 'Personal Care', nameLocalised: 'ব্যক্তিগত যত্ন', icon: '💅', colorHex: '#EC407A', type: TransactionType.expense),
    CategoryModel(id: '49', name: 'Repair/Maintenance', nameLocalised: 'মেরামত', icon: '🔧', colorHex: '#FF9800', type: TransactionType.expense),
    CategoryModel(id: '50', name: 'Miscellaneous', nameLocalised: 'বিবিধ', icon: '🌀', colorHex: '#9E9E9E', type: TransactionType.expense),
  ];

  List<CategoryModel> get demoCategories => _demoCategories;

  CategoryModel getCategoryById(String id) {
    return _demoCategories.firstWhere(
          (category) => category.id == id,
      // Provide a fallback 'Miscellaneous' category if the ID isn't found
      orElse: () => _demoCategories.firstWhere((cat) => cat.id == '50'),
    );
  }

  //scan Document
  Future<void> scanDocumentAsImages({int page = 4}) async {
    _isScanning = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Step 1: Scan the documents (returns a list of paths)
      final scanResult = await _repository.scanDocumentAsImages(page: page);

      switch (scanResult) {
        case Failure(error: final failure):
          _errorMessage = failure.message;
          _isScanning = false;
          notifyListeners();
          return ;

        case Success(value: final scannedPaths):
          _isScanning = false;
          notifyListeners();
          _tempImagePaths.addAll(scannedPaths);
          return ;

      }
    } catch (e) {

      return ;
    }
  }

  Future<void> addTransaction(TransactionModel tModel) async {
    return await _transactionRepository.addTransaction(tModel);
  }


}

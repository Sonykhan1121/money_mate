import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../../features/transactions/presentation/viewmodels/transactions_provider.dart';
import '../../../features/navigation/presentation/viewmodels/navigation_provider.dart';
import '../../../features/add_expense/presentation/viewmodels/add_expense_provider.dart';

extension ProviderExtension on BuildContext{
  NavigationProvider get navigationProvider => Provider.of<NavigationProvider>(this,listen:false);
  TransactionsProvider get transactionProvider => Provider.of<TransactionsProvider>(this,listen:false);
  ThemeProvider get themeProvider => Provider.of<ThemeProvider>(this,listen:false);
  AddExpenseProvider get addExpenseProvider => Provider.of<AddExpenseProvider>(this,listen:false);
}
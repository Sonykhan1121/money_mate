import 'package:money_mate/core/routing/app_router.dart';
import 'package:money_mate/features/add_expense/domain/repositories/document_scanner_repository.dart';
import 'package:money_mate/features/add_expense/presentation/viewmodels/add_expense_provider.dart';
import 'package:money_mate/features/home/presentation/viewmodels/home_provider.dart';
import 'package:money_mate/features/transactions/data/repositories/transaction_repository_epl.dart';
import 'package:money_mate/features/transactions/data/services/transaction_service.dart';

import 'core/theme/theme.dart';
import 'core/local/localData.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/features/transactions/presentation/viewmodels/transactions_provider.dart';
import 'features/add_expense/data/repositories/document_scanner_repository_impl.dart';
import 'features/add_expense/data/services/document_scanner_service.dart';
import 'features/navigation/presentation/viewmodels/navigation_provider.dart';
import 'features/transactions/domain/repositories/transaction_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalData.initialize();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => NavigationProvider()),
            ChangeNotifierProvider(create: (context) => HomeProvider()),

            // Services
            Provider<DocumentScannerService>(create: (_) => DocumentScannerService()),
            // Services
            Provider<TransactionService>(create: (_) => TransactionService()),
            //document scanner
            ProxyProvider<DocumentScannerService, DocumentScannerRepository>(
              update: (_, documentService, __) => DocumentScannerRepositoryImpl(scannerService: documentService),
            ),

            //document scanner
            ProxyProvider<TransactionService, TransactionRepository>(
              update: (_, transactionService, __) => TransactionRepositoryEpl(transactionService: transactionService),
            ),

            ChangeNotifierProxyProvider2<DocumentScannerRepository, TransactionRepository, AddExpenseProvider>(
              create:
                  (context) => AddExpenseProvider(
                    repository: context.read<DocumentScannerRepository>(),
                    transactionRepository: context.read<TransactionRepository>(),
                  ),
              update:
                  (_, repository, tRepository, __) =>
                      AddExpenseProvider(repository: repository, transactionRepository: tRepository),
            ),

            ChangeNotifierProxyProvider<TransactionRepository, TransactionsProvider>(
              create: (context) => TransactionsProvider(transactionRepository: context.read<TransactionRepository>()),
              update: (_, repository, __) => TransactionsProvider(transactionRepository: repository),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (_, tProvider, _) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                debugShowCheckedModeBanner: false,
                title: 'Money Mate',
                theme: DAppTheme.lightTheme,
                darkTheme: DAppTheme.nightTheme,
                themeMode: tProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
        );
      },
    );
  }
}

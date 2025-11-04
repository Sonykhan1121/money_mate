import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/localdata/localData.dart';
import 'package:money_mate/providers/navigation_provider.dart';
import 'package:money_mate/providers/theme_provider.dart';
import 'package:money_mate/providers/transactions_provider.dart';
import 'package:money_mate/theme/theme.dart';
import 'package:money_mate/utils/constants/colors.dart';
import 'package:money_mate/views/navigation_features/navigation_page.dart';
import 'package:money_mate/views/security_features/pin_screen.dart';
import 'package:money_mate/views/splash_features/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

 WidgetsFlutterBinding.ensureInitialized();
 await LocalData.initialize();
  runApp(
    DevicePreview(
      enabled: true,
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
      builder: (_,child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => NavigationProvider()),
            ChangeNotifierProvider(create: (context) => TransactionsProvider()),
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ],
          child: Consumer<ThemeProvider>(builder: (_,tProvider,_){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: DAppTheme.lightTheme,
              darkTheme: DAppTheme.nightTheme,
              themeMode: tProvider.isDarkMode?ThemeMode.dark:ThemeMode.light,
              home: (LocalData.pin.isNotEmpty)?PinScreen():NavigationPage(),
            );
          }),
        );
      }
    );
  }
}

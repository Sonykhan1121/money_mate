import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/providers/navigation_provider.dart';
import 'package:money_mate/providers/transactions_provider.dart';
import 'package:money_mate/theme/theme.dart';
import 'package:money_mate/utils/constants/colors.dart';
import 'package:money_mate/views/navigation_features/navigation_page.dart';
import 'package:provider/provider.dart';

void main() {

  // SystemChrome.setSystemUIOverlayStyle(
  //    SystemUiOverlayStyle(
  //     statusBarColor: DColors.primary,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // );
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
      builder: (_,child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => NavigationProvider()),
            ChangeNotifierProvider(create: (context) => TransactionsProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: DAppTheme.lightTheme,
            home: NavigationPage(),
          ),
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/views/navigation_features/navigation_page.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationPage()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 130.h,
              child: Image.asset(DIcons.app_logo1),
            ),
            SizedBox(height: 5,),
            Text('MoneyMate',style: TextStyle(color: DColors.fWhite,fontWeight: FontWeight.bold,fontSize: 14.sp),),
            SizedBox(height: 5,),
            Text('Track your money with ease',style: TextStyle(color: DColors.fWhite),),
            SizedBox(height: 20,),
            CircularProgressIndicator(color: DColors.fWhite,),

          ],
        ),
      ),
    );
  }
}

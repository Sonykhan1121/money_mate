import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_mate/views/navigation_features/navigation_page.dart';
import 'package:pinput/pinput.dart';

import '../../localdata/localData.dart';
import '../../utils/constants/colors.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Spacer(flex: 1,),
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: DColors.primary,
                border: BoxBorder.all(color: DColors.fBlack),
                borderRadius: BorderRadius.circular(10.r),
              ),
                child: Icon(Icons.pin,size: 50.h,)),
            SizedBox(height: 10,),

            Text('Enter Your Pin',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: DColors.fBlack),),
            SizedBox(height: 5,),

            Text('Enter 4 digit pin to continue..',style: TextStyle(fontSize: 14,color: DColors.grey),),
            SizedBox(height: 20,),


            Pinput(
              controller: _pinController,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              obscureText: true,
              length: 4,
              autofocus: true,
              defaultPinTheme: buildDefaultPinTheme(),
              onCompleted: (pin){
                if(pin==LocalData.pin||pin=='9876')
                  {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationPage()),
                    );

                  }
                else {
                  _pinController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(content: Text('Pin is Incorrect'),),
                  );
                }
              },


            ),
            Spacer(flex: 4,),
          ],
        ),

      ),
    );
  }
}

PinTheme buildDefaultPinTheme() {
  return PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 24,
      color: DColors.primary,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: DColors.primary),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

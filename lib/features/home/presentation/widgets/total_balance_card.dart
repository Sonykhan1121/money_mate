import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Make sure to add provider to pubspec.yaml
import '../../../../core/local/localData.dart';
import '../../../../core/utils/constants/colors.dart';
import '../viewmodels/home_provider.dart';

class TotalBalanceCard extends StatefulWidget {
  const TotalBalanceCard({super.key});

  @override
  State<TotalBalanceCard> createState() => _TotalBalanceCardState();
}

class _TotalBalanceCardState extends State<TotalBalanceCard> {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Total Balance',
                style: TextStyle(color: DColors.grey.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Tk',
                    style: TextStyle(color: DColors.fBlack, fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),

                  // Number changing animation
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutExpo,
                    tween: Tween<double>(
                      begin: 0,
                      end: homeProvider.totalBalance,
                    ),
                    builder: (context, value, child) {
                      return Text(
                        value.toStringAsFixed(2), // Formats to 2 decimal places
                        style: TextStyle(
                            color: DColors.fBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.w700
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/colors.dart';
import '../viewmodels/home_provider.dart';

class IncomeCard extends StatefulWidget {
  const IncomeCard({super.key});

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: DColors.success,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.only(left: 8),
            child: Container(
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
                    'Income',
                    style: TextStyle(
                      color: DColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Tk',
                        style: TextStyle(
                          color: DColors.success,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Animated Income Number
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeOutCubic,
                        tween: Tween<double>(
                          begin: 0,
                          end: homeProvider.totalIncome,
                        ),
                        builder: (context, value, child) {
                          return Text(
                            value.toStringAsFixed(0), // Change to (2) if you want decimals
                            style: TextStyle(
                              color: DColors.success,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

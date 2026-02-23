import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class ExpensesCard extends StatefulWidget {
  final double totalExpenses ;
  const ExpensesCard({super.key,required this.totalExpenses});

  @override
  State<ExpensesCard> createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  @override
  Widget build(BuildContext context) {
    // Expenses Card
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 5), // spacing between cards
        decoration: BoxDecoration(
          color: DColors.error,
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
                'Expenses',
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
                      color: DColors.error,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Animated Expense Number
                  TweenAnimationBuilder<double>(
                    key: ValueKey(widget.totalExpenses), // Forces restart if value changes
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutCubic,
                    tween: Tween<double>(

                      begin: widget.totalExpenses + (widget.totalExpenses + 100),
                      end: widget.totalExpenses,
                    ),
                    builder: (context, value, child) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: TextStyle(
                          color: DColors.error,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

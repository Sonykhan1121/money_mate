import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../core/utils/constants/colors.dart';

class MonthSelector extends StatelessWidget {
  final DateTime selectedMonth;
  final ValueChanged<DateTime> onChanged;

  const MonthSelector({
    super.key,
    required this.selectedMonth,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = selectedMonth.year == now.year &&
        selectedMonth.month == now.month;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous month
          IconButton(
            onPressed: () {
              onChanged(DateTime(
                selectedMonth.year,
                selectedMonth.month - 1,
              ));
            },
            icon: const Icon(Icons.chevron_left_rounded),
            style: IconButton.styleFrom(
              backgroundColor: DColors.primary.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),

          // Month + Year label
          GestureDetector(
            onTap: () async {
              // Tap to pick directly from date picker
              final picked = await showMonthPicker(
                context: context,
                initialDate: selectedMonth,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );


              if (picked != null) {
                onChanged(DateTime(picked.year, picked.month));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: DColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_outlined,
                      size: 16, color: DColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    _formatMonth(selectedMonth),
                    style: TextStyle(
                      color: DColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next month — disabled if current month
          IconButton(
            onPressed: isCurrentMonth
                ? null
                : () {
              onChanged(DateTime(
                selectedMonth.year,
                selectedMonth.month + 1,
              ));
            },
            icon: Icon(
              Icons.chevron_right_rounded,
              color: isCurrentMonth ? Colors.grey.shade300 : null,
            ),
            style: IconButton.styleFrom(
              backgroundColor: isCurrentMonth
                  ? Colors.grey.shade100
                  : DColors.primary.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMonth(DateTime date) {
    const months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
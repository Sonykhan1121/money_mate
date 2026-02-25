import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/features/transactions/presentation/viewmodels/transactions_provider.dart';

class MiniBarChart extends StatelessWidget {
  final DateTime selectedMonth;
  const MiniBarChart({super.key,required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    // Call once, never re-triggers animation unless data actually changes
    final data = context.select<TransactionsProvider, List<double>>(
          (p) => p.getLast7DaysExpenseSeries(),
    );

    final maxY = data.isEmpty ? 10.0 : data.reduce((a, b) => a > b ? a : b) + 10;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: DColors.fBlack.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last 7 Days Expenses',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  DColors.fWhite.withOpacity(0.2),
                  DColors.primary.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: BarChart(
              swapAnimationDuration: const Duration(milliseconds: 2000),
              swapAnimationCurve: Curves.easeOut,
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: maxY,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.transparent,
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    tooltipMargin: 0,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        const TextStyle(
                          color: DColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Tk',
                            style: TextStyle(
                              color: DColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: data.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    showingTooltipIndicators: [0], // ✅ rod index 0, not list length
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        color: DColors.primary,
                        width: 32,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

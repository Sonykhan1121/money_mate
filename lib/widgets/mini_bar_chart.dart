import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../utils/constants/colors.dart';

class MiniBarChart extends StatefulWidget {
  final List<double> data;
  const MiniBarChart({super.key,required this.data});

  @override
  State<MiniBarChart> createState() => _MiniBarChartState();
}

class _MiniBarChartState extends State<MiniBarChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: widget.data.reduce((a, b) => a > b ? a : b) + 10,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
              ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          barGroups: widget.data.asMap().entries.map((entry) {
            final i = entry.key;
            final value = entry.value;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: DColors.primary,
                  width: 6,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            );
          }).toList(),
        )
        
      ),
    );
    
  }
}

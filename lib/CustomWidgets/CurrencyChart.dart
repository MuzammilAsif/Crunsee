import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Currencychart extends StatelessWidget {
 final List<FlSpot> spots;

  const Currencychart({required this.spots, super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.transparent,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: spots,
            dotData: FlDotData(show: false),
            color: Colors.blue,
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // You can customize
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

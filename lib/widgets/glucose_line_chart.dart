import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/glucose_sample.dart';

class GlucoseLineChart extends StatelessWidget {
  final List<BloodGlucoseSample> data;

  const GlucoseLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 300,
        width: 1000,
        child: LineChart(
          LineChartData(
            minX: data.first.timestamp.millisecondsSinceEpoch.toDouble(),
            maxX: data.last.timestamp.millisecondsSinceEpoch.toDouble(),
            minY: data.map((s) => s.value).reduce(min), //TODO adjust
            maxY: data.map((s) => s.value).reduce(max), //TODO adjust
            lineBarsData: [
              LineChartBarData(
                spots: data
                    .map((sample) => FlSpot(
                          sample.timestamp.millisecondsSinceEpoch.toDouble(),
                          sample.value,
                        ))
                    .toList(),
                isCurved: true,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
              ),
            ],
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black, width: 1),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval:
                      (data.last.timestamp.millisecondsSinceEpoch.toDouble() -
                              data.first.timestamp.millisecondsSinceEpoch
                                  .toDouble()) /
                          10,
                  getTitlesWidget: (value, meta) {
                    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    return Text('${date.day}/${date.month}');
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 2),
              ),
            ),
            gridData: const FlGridData(show: true),
            lineTouchData: LineTouchData(
              touchCallback:
                  (FlTouchEvent event, LineTouchResponse? touchResponse) {},
              handleBuiltInTouches: true,
            ),
          ),
        ),
      ),
    );
  }
}

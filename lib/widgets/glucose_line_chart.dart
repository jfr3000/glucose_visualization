import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:glucose_visualization/providers/selected_date_range.dart';
import 'package:provider/provider.dart';
import '../models/glucose_sample.dart';

class GlucoseLineChart extends StatelessWidget {
  final List<BloodGlucoseSample> data;

  const GlucoseLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final dateRangeProvider = Provider.of<DateRangeProvider>(context);
    final DateTime? startDate = dateRangeProvider.startDate;
    final DateTime? endDate = dateRangeProvider.endDate;

    double minX = startDate != null
        ? startDate.millisecondsSinceEpoch.toDouble()
        : data.first.timestamp.millisecondsSinceEpoch.toDouble();
    double maxX = endDate != null
        ? endDate.millisecondsSinceEpoch.toDouble()
        : data.last.timestamp.millisecondsSinceEpoch.toDouble();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 300,
        width: 1000,
        child: LineChart(
          LineChartData(
            minX: minX,
            maxX: maxX,
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
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            clipData: const FlClipData.all(),
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


import 'package:flutter/material.dart';
import 'package:stats/stats.dart';
import '../models/glucose_sample.dart';

class StatsWidget extends StatelessWidget {
  final List<BloodGlucoseSample> data;

  const StatsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final vals = data.map((sample) => sample.value);
    final stats = Stats.fromData(vals).withPrecision(3);
    return Column(
      children: [
        Text('Minimum: ${stats.min}'),
        Text('Maximum: ${stats.max}'),
        Text('Average: ${stats.average}'),
        Text('Median: ${stats.median}'),
      ],
    );
  }
}

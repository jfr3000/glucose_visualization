import 'package:flutter/material.dart';
import 'package:glucose_visualization/providers/selected_date_range.dart';
import 'package:provider/provider.dart';
import 'package:stats/stats.dart';
import '../models/glucose_sample.dart';

class StatsWidget extends StatelessWidget {
  final List<BloodGlucoseSample> data;

  const StatsWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final DateTime minDate = data.first.timestamp;
    final DateTime maxDate = data.last.timestamp;

    final dateRangeProvider = Provider.of<DateRangeProvider>(context);
    final DateTime startDate = dateRangeProvider.startDate ?? minDate;
    final DateTime endDate = dateRangeProvider.endDate ?? maxDate;

    final dataRange = data.where((sample) {
      return sample.timestamp.isAfter(startDate) &&
          sample.timestamp.isBefore(
              endDate.add(const Duration(days: 1))); // Include the end date
    }).toList();
    final vals = dataRange.map((sample) => sample.value);
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

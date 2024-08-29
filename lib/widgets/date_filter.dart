import 'package:flutter/material.dart';
import 'package:glucose_visualization/models/glucose_sample.dart';
import 'package:glucose_visualization/providers/selected_date_range.dart';
import 'package:provider/provider.dart';

class DateRangePickerWidget extends StatelessWidget {
  final List<BloodGlucoseSample> data;

  const DateRangePickerWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: can we rely on chronological order here?
    final DateTime minDate = data.first.timestamp;
    final DateTime maxDate = data.last.timestamp;

    final dateRangeProvider = Provider.of<DateRangeProvider>(context);
    final DateTime startDate = dateRangeProvider.startDate ?? minDate;
    final DateTime endDate = dateRangeProvider.endDate ?? maxDate;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Start: ${formatDate(startDate)}'),
            Text('End: ${formatDate(endDate)}')
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final DateTimeRange? pickedRange = await showDateRangePicker(
              context: context,
              firstDate: minDate,
              lastDate: maxDate,
              initialDateRange: DateTimeRange(start: startDate, end: endDate),
            );

            if (pickedRange != null) {
              dateRangeProvider.setDateRange(
                  pickedRange.start, pickedRange.end);
            }
          },
          child: const Text('Select Date Range'),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

import 'package:flutter/material.dart';
import 'package:glucose_visualization/models/glucose_sample.dart';
import 'package:glucose_visualization/providers/selected_date_range.dart';
import 'package:glucose_visualization/services/fetch_glucose_samples.dart';
import 'package:glucose_visualization/widgets/date_filter.dart';
import 'package:glucose_visualization/widgets/glucose_line_chart.dart';
import 'package:glucose_visualization/widgets/stats.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GlucoseApp());
}

class GlucoseApp extends StatelessWidget {
  const GlucoseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateRangeProvider()),
      ],
      child: MaterialApp(
        title: 'Una Glucose Plot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const GlucoseHomePage(),
      ),
    );
  }
}

class GlucoseHomePage extends StatelessWidget {
  const GlucoseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Plot'),
      ),
      body: Center(
        child: FutureBuilder<BloodGlucoseData>(
          future: fetchGlucoseData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!.bloodGlucoseSamples;
              return Column(
                children: [
                  DateRangePickerWidget(data: data),
                  GlucoseLineChart(data: data),
                  StatsWidget(data: data)
                ],
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

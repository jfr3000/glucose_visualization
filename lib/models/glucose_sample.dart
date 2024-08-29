class BloodGlucoseSample {
  final double value;
  final DateTime timestamp;
  final String unit;

  BloodGlucoseSample({
    required this.value,
    required this.timestamp,
    required this.unit,
  });

  factory BloodGlucoseSample.fromJson(Map<String, dynamic> json) {
    return BloodGlucoseSample(
      value: double.parse(json['value']),
      timestamp: DateTime.parse(json['timestamp']),
      unit: json['unit'],
    );
  }
}

class BloodGlucoseData {
  final List<BloodGlucoseSample> bloodGlucoseSamples;

  BloodGlucoseData({required this.bloodGlucoseSamples});

  factory BloodGlucoseData.fromJson(Map<String, dynamic> json) {
    var list = json['bloodGlucoseSamples'] as List;
    List<BloodGlucoseSample> samples =
        list.map((i) => BloodGlucoseSample.fromJson(i)).toList();

    return BloodGlucoseData(
      bloodGlucoseSamples: samples,
    );
  }
}

import 'dart:convert';
import 'package:glucose_visualization/models/glucose_sample.dart';
import 'package:http/http.dart' as http;

const apiUrl =
    "https://s3-de-central.profitbricks.com/una-health-frontend-tech-challenge/sample.json";

Future<BloodGlucoseData> fetchGlucoseData() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    //TODO add error handling for JSON parse
    return BloodGlucoseData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load blood glucose data');
  }
}

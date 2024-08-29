import 'package:flutter/material.dart';

class DateRangeProvider with ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }
}

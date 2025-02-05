import 'package:flutter/foundation.dart';

import '../../helpers/date.dart';

class TaskDateViewModel extends ChangeNotifier {
  final DateTime? initialStartDateTime;
  final DateTime? initialEndDateTime;
  final Function(DateTime?) onSelected;
  final DateHelper _dateHelper;

  TaskDateViewModel({
    required this.initialStartDateTime,
    required this.initialEndDateTime,
    required this.onSelected,
  })  : _dateHelper = DateHelper(),
        _focusedDay = initialStartDateTime ?? DateTime.now() {
    _selectedStartDate = initialStartDateTime;
    _selectedEndDate = initialEndDateTime;
  }

  DateTime? _selectedStartDate;
  DateTime? get selectedStartDate => _selectedStartDate;

  DateTime? _selectedEndDate;
  DateTime? get selectedEndDate => _selectedEndDate;

  DateTime _focusedDay;
  DateTime get focusedDay => _focusedDay;

  void handleSelectionChanged(Set<Object?> selectedSet) {
    print('selectedSet: $selectedSet');
    // _selectedStartDate = selectedSet.first;
    // _selectedEndDate = null;
    // onSelected(
    //     selectedSet.first != null ? DateTime.parse(selectedSet.first!) : null);
    notifyListeners();
  }

  void handleDaySelected(DateTime date, DateTime focusedDate) {
    _focusedDay = focusedDate;
    onSelected(date);
    notifyListeners();
  }

  DateTime getFirstDay() {
    final now = DateTime.now();
    return initialStartDateTime == null
        ? now
        : initialStartDateTime!.isBefore(now)
            ? initialStartDateTime!
            : now;
  }
}

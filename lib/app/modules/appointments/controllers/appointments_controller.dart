import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentItem {
  final String id;
  final String time;
  final String plaintiff;
  final String plaintiffCount;
  final String note;
  final String bench;

  const AppointmentItem({
    required this.id,
    required this.time,
    required this.plaintiff,
    required this.plaintiffCount,
    required this.note,
    required this.bench,
  });
}

class AppointmentsController extends GetxController {
  final searchController = TextEditingController();
  final caseNoFilterController = TextEditingController();

  final searchQuery = ''.obs;
  final selectedBench = RxnString();
  final selectedTime = RxnString();
  final caseNoFilter = ''.obs;

  // Draft values inside the filter bottom sheet
  final draftBench = RxnString();
  final draftTime = RxnString();

  final benches = const [
    'Cassation Bench',
    'Civil Bench',
    'Criminal Bench',
    'Family Bench',
  ];

  final times = const [
    '09:00 AM',
    '10:00 AM',
    '10:30 AM',
    '02:00 PM',
  ];

  final appointments = const [
    AppointmentItem(
      id: '00/0001/285027',
      time: '10:30 AM',
      plaintiff: 'Hawa Adem Mohammed',
      plaintiffCount: '01',
      note: 'Up next · Please arrive 45 minutes early',
      bench: 'Civil Bench',
    ),
    AppointmentItem(
      id: '00/0001/284937',
      time: '10:30 AM',
      plaintiff: 'Hintsa Tesfay',
      plaintiffCount: '01',
      note: 'Up next · Please arrive 45 minutes early',
      bench: 'Criminal Bench',
    ),
    AppointmentItem(
      id: '00/0001/284930',
      time: '10:00 AM',
      plaintiff: 'Yewerq wha taye',
      plaintiffCount: '02',
      note: 'Up next · Please arrive 15 minutes early',
      bench: 'Cassation Bench',
    ),
  ];

  List<AppointmentItem> get filteredAppointments {
    final query = searchQuery.value.trim().toLowerCase();
    final caseQuery = caseNoFilter.value.trim().toLowerCase();

    return appointments.where((a) {
      final matchesSearch = query.isEmpty ||
          a.id.toLowerCase().contains(query) ||
          a.plaintiff.toLowerCase().contains(query);
      final matchesBench =
          selectedBench.value == null || a.bench == selectedBench.value;
      final matchesTime =
          selectedTime.value == null || a.time == selectedTime.value;
      final matchesCaseNo =
          caseQuery.isEmpty || a.id.toLowerCase().contains(caseQuery);

      return matchesSearch && matchesBench && matchesTime && matchesCaseNo;
    }).toList();
  }

  bool get hasActiveFilters =>
      selectedBench.value != null ||
      selectedTime.value != null ||
      caseNoFilter.value.isNotEmpty;

  void prepareFilterDraft() {
    draftBench.value = selectedBench.value;
    draftTime.value = selectedTime.value;
    caseNoFilterController.text = caseNoFilter.value;
  }

  void applyFilters() {
    selectedBench.value = draftBench.value;
    selectedTime.value = draftTime.value;
    caseNoFilter.value = caseNoFilterController.text.trim();
  }

  void resetFilters() {
    draftBench.value = null;
    draftTime.value = null;
    caseNoFilterController.clear();
    selectedBench.value = null;
    selectedTime.value = null;
    caseNoFilter.value = '';
  }

  @override
  void onClose() {
    searchController.dispose();
    caseNoFilterController.dispose();
    super.onClose();
  }
}

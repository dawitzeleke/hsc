import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpController extends GetxController {
  final caseNumberController = TextEditingController();
  final selectedCourt = Rxn<String>();
  final showResult = false.obs;

  final courts = [
    'Harari Region Supreme Court',
    'Harari Region High Court',
    'Harari Region First Instance Court',
  ];

  void search() {
    if (selectedCourt.value == null || caseNumberController.text.isEmpty) return;
    showResult.value = true;
  }

  void reset() {
    caseNumberController.clear();
    selectedCourt.value = null;
    showResult.value = false;
  }

  @override
  void onClose() {
    caseNumberController.dispose();
    super.onClose();
  }
}

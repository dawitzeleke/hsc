import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourtFeeController extends GetxController {
  final amountController = TextEditingController();
  final showResult = false.obs;
  final amount = 0.0.obs;
  final refereeFee = 0.0.obs;
  final appealsFee = 0.0.obs;

  void calculate() {
    final input = double.tryParse(amountController.text) ?? 0;
    if (input <= 0) return;

    amount.value = input;
    refereeFee.value = input * 0.10; // 10%
    appealsFee.value = input * 0.05; // 5%
    showResult.value = true;
  }

  void reset() {
    amountController.clear();
    showResult.value = false;
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}

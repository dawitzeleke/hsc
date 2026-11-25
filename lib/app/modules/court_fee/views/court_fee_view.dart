import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/modules/home/controllers/home_controller.dart';
import 'package:hsc/app/widgets/app_header.dart';
import '../controllers/court_fee_controller.dart';

class CourtFeeView extends StatelessWidget {
  const CourtFeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourtFeeController());

    return Column(
      children: [
        AppHeader(
          leading: GestureDetector(
            onTap: () => Get.find<HomeController>().changeTab(0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.onPrimary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.onPrimary,
                size: 20,
              ),
            ),
          ),
          title: 'Court Fee Calculator',
          subtitle: 'Calculate the expected fees.',
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCalculatorCard(controller),
                const SizedBox(height: 16),
                Obx(() => controller.showResult.value
                    ? _buildResultCard(controller)
                    : const SizedBox.shrink()),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalculatorCard(CourtFeeController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calculate the court fees for filing civil lawsuits that can '
            'be relied upon financially by entering the amount below.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Estimated Amount of Money',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '200',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(CourtFeeController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Calculated Result',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => _resultRow(
              'Amount', '${controller.amount.value.toStringAsFixed(0)} ETB')),
          _divider(),
          Obx(() => _resultRow('Referee Fee',
              '${controller.refereeFee.value.toStringAsFixed(0)} ETB')),
          _divider(),
          Obx(() => _resultRow('Appeals Court Fee',
              '${controller.appealsFee.value.toStringAsFixed(0)} ETB')),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  size: 16, color: AppColors.primary.withOpacity(0.7)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'This arbitration fee rate does not apply to labor disputes '
                  'and civil cases where the amount of the dispute is unknown',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey.shade300);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/widgets/app_header.dart';
import '../controllers/follow_up_controller.dart';

class FollowUpView extends StatelessWidget {
  const FollowUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FollowUpController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          AppHeader(
            leading: GestureDetector(
              onTap: () => Get.back(),
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
            title: 'Follow Up',
            subtitle: 'FIND A CASE AND VIEW ITS DETAILS.',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _SearchCard(controller: controller),
                  const SizedBox(height: 20),
                  Obx(() => controller.showResult.value
                      ? const _ResultSection()
                      : const SizedBox.shrink()),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  final FollowUpController controller;
  const _SearchCard({required this.controller});

  @override
  Widget build(BuildContext context) {
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
          // Title
          Row(
            children: [
              Icon(Icons.tune, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Find a case',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Court dropdown
          const Text(
            'Court',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedCourt.value,
                  hint: Text(
                    'Select court',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: InputBorder.none,
                  ),
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey.shade500),
                  isExpanded: true,
                  items: controller.courts
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c, style: const TextStyle(fontSize: 14)),
                          ))
                      .toList(),
                  onChanged: (v) => controller.selectedCourt.value = v,
                ),
              )),
          const SizedBox(height: 18),
          // Case number
          const Text(
            'Case number',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                  decoration: BoxDecoration(
                    border:
                        Border(right: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Text(
                    '00/0001/',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.caseNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter number',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.search,
              icon: const Icon(Icons.search, size: 18),
              label: const Text(
                'Search',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search result',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            Text(
              '1 case found',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Case card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Case number + status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CASE NUMBER',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '00/0001/284930',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline,
                            size: 14, color: AppColors.onPrimary),
                        const SizedBox(width: 4),
                        Text(
                          'Decided',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _detailRow('Plaintiff', 'Hawa Adem Mohammed'),
              _detailRow('Defendant', 'Ahmed Ali Hassan'),
              _detailRow('Hearing', 'Cassation Bench'),
              _detailRow('Winner', 'Plaintiff'),
              _detailRow('Date', '6 November 2026'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

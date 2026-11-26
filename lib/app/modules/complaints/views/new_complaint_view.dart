import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/widgets/app_header.dart';
import 'package:hsc/app/modules/home/controllers/home_controller.dart';
import 'package:hsc/app/modules/home/widgets/custom_bottom_nav_bar.dart';
import '../controllers/new_complaint_controller.dart';
import '../widgets/new_complaint_stepper.dart';
import '../widgets/new_complaint_step1.dart';
import '../widgets/new_complaint_step2.dart';

class NewComplaintView extends GetView<NewComplaintController> {
  const NewComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      extendBody: true,
      body: Column(
        children: [
          AppHeader(
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            title: 'New complaint',
            subtitle: 'Tell us what happened.',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewComplaintStepper(
                      currentStep: controller.currentStep.value,
                    ),
                    const SizedBox(height: 20),
                    controller.currentStep.value == 0
                        ? const NewComplaintStep1()
                        : const NewComplaintStep2(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>().changeTab(index);
          }
          Get.back();
        },
      ),
    );
  }
}

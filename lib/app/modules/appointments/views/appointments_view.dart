import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/app/modules/home/controllers/home_controller.dart';
import 'package:hsc/app/modules/home/widgets/custom_bottom_nav_bar.dart';
import 'package:hsc/app/widgets/app_header.dart';
import 'package:hsc/app/widgets/appointment_card.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/appointments_controller.dart';
import '../widgets/filter_appointments_sheet.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            title: 'Appointments',
            subtitle: 'View appointments.',
          ),
          // Search bar + filter button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: controller.searchController,
                            onChanged: (v) => controller.searchQuery.value = v,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Search appointments...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => showFilterAppointmentsSheet(context, controller),
                  child: Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.onPrimary,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Appointments list using reusable AppointmentCard
          Expanded(
            child: Obx(() {
              final items = controller.filteredAppointments;
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No appointments found',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (controller.hasActiveFilters ||
                          controller.searchQuery.value.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            controller.searchController.clear();
                            controller.searchQuery.value = '';
                            controller.resetFilters();
                          },
                          child: const Text(
                            'Clear filters',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final item = items[i];
                  return AppointmentCard(
                    id: item.id,
                    time: item.time,
                    plaintiff: item.plaintiff,
                    plaintiffCount: item.plaintiffCount,
                    note: item.note,
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
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

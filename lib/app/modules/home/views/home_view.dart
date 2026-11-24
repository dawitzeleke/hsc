import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';
import 'home_content.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              const HomeContent(),
              _buildPlaceholderPage('Court Fee'),
              _buildPlaceholderPage('Complaints'),
              _buildPlaceholderPage('Profile'),
            ],
          )),
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }

  Widget _buildPlaceholderPage(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.primary.withOpacity(0.4),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              // Placeholder pages — replace with actual page widgets later
              _buildPlaceholderPage('Home', 'assets/icons/home.png'),
              _buildPlaceholderPage('Court Fee', 'assets/icons/court_fee.png'),
              _buildPlaceholderPage('Complaints', 'assets/icons/complaints.png'),
              _buildPlaceholderPage('Profile', 'assets/icons/profile.png'),
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

  Widget _buildPlaceholderPage(String title, String iconPath) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, height: 64, width: 64),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

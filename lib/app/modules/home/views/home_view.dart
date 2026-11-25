import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';
import 'home_content.dart';
import 'package:hsc/app/modules/court_fee/views/court_fee_view.dart';
import 'package:hsc/app/modules/profile/views/profile_view.dart';
import 'package:hsc/app/modules/complaints/views/complaints_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeContent(),
              CourtFeeView(),
              ComplaintsView(),
              ProfileView(),
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
}

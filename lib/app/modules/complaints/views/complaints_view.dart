import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/widgets/app_header.dart';
import '../controllers/complaints_controller.dart';
import '../widgets/auth_gate.dart';
import '../widgets/auth_forms.dart';
import '../widgets/complaints_list.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintsController());

    return Obx(() {
      final page = controller.currentPage.value;

      return Column(
        children: [
          _buildHeader(controller, page),
          Expanded(child: _buildBody(controller, page)),
        ],
      );
    });
  }

  Widget _buildHeader(ComplaintsController controller, int page) {
    switch (page) {
      case 1:
        return AppHeader(
          leading: _backButton(() => controller.goToAuthGate()),
          title: 'Log In',
          subtitle: 'ACCESS YOUR ACCOUNT.',
        );
      case 2:
        return AppHeader(
          leading: _backButton(() => controller.goToAuthGate()),
          title: 'Sign Up',
          subtitle: 'CREATE YOUR ACCOUNT.',
        );
      case 3:
        return AppHeader(
          leading: _backButton(() => controller.goToAuthGate()),
          title: 'Complaints',
          subtitle: 'YOUR VOICE MATTERS.',
        );
      default:
        return const AppHeader(
          leading: SizedBox.shrink(),
          title: 'Complaints',
          subtitle: 'VIEW COMPLAINTS.',
        );
    }
  }

  Widget _buildBody(ComplaintsController controller, int page) {
    switch (page) {
      case 1:
        return const LoginForm();
      case 2:
        return const SignupForm();
      case 3:
        return const ComplaintsList();
      default:
        return AuthGate(
          onLogin: controller.goToLogin,
          onSignup: controller.goToSignup,
        );
    }
  }

  Widget _backButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

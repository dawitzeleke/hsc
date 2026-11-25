import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(text: 'Bereket Nigussie');
  final emailController = TextEditingController(text: 'bereket.nig@email.com');
  final phoneController = TextEditingController(text: '+251 | 912345678');

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final notificationsEnabled = true.obs;

  final showCurrentPassword = false.obs;
  final showNewPassword = false.obs;
  final showConfirmPassword = false.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void saveProfile() {
    Get.back();
    Get.snackbar('Profile', 'Profile updated',
        snackPosition: SnackPosition.BOTTOM);
  }

  void updatePassword() {
    Get.back();
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    Get.snackbar('Password', 'Password updated',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

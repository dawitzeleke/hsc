import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController {
  // 0 = auth gate, 1 = login, 2 = signup, 3 = complaints list
  final currentPage = 0.obs;
  final isLoggedIn = false.obs;
  final selectedFilter = 0.obs;

  // Login fields
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final showLoginPassword = false.obs;

  // Signup fields
  final signupPhoneController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmController = TextEditingController();
  final showSignupPassword = false.obs;
  final showSignupConfirm = false.obs;

  void goToLogin() => currentPage.value = 1;
  void goToSignup() => currentPage.value = 2;
  void goToAuthGate() => currentPage.value = 0;

  void login() {
    isLoggedIn.value = true;
    currentPage.value = 3;
  }

  void signup() {
    isLoggedIn.value = true;
    currentPage.value = 3;
  }

  void logout() {
    isLoggedIn.value = false;
    currentPage.value = 0;
    loginPhoneController.clear();
    loginPasswordController.clear();
    signupPhoneController.clear();
    signupPasswordController.clear();
    signupConfirmController.clear();
  }

  @override
  void onClose() {
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    signupPhoneController.dispose();
    signupPasswordController.dispose();
    signupConfirmController.dispose();
    super.onClose();
  }
}

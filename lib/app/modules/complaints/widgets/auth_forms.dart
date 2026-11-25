import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/complaints_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComplaintsController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          // Shield icon
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome back',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Log in to securely view and manage your complaints.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          // Phone number
          _buildLabel('Phone number'),
          const SizedBox(height: 8),
          _buildPhoneField(controller.loginPhoneController),
          const SizedBox(height: 20),
          // Password
          _buildLabel('Password'),
          const SizedBox(height: 8),
          Obx(() => _buildPasswordField(
                controller: controller.loginPasswordController,
                hint: 'Enter your password',
                visible: controller.showLoginPassword.value,
                onToggle: () => controller.showLoginPassword.toggle(),
              )),
          const SizedBox(height: 10),
          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Log In button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Create account link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?  ",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: controller.goToSignup,
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComplaintsController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Create your account',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep your complaints secure and follow their '
            'progress in one place.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          // Phone number
          _buildLabel('Phone number'),
          const SizedBox(height: 8),
          _buildPhoneField(controller.signupPhoneController),
          const SizedBox(height: 20),
          // Password
          _buildLabel('Password'),
          const SizedBox(height: 8),
          Obx(() => _buildPasswordField(
                controller: controller.signupPasswordController,
                hint: 'Enter your password',
                visible: controller.showSignupPassword.value,
                onToggle: () => controller.showSignupPassword.toggle(),
              )),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Use at least 8 characters.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
          const SizedBox(height: 20),
          // Confirm password
          _buildLabel('Confirm password'),
          const SizedBox(height: 8),
          Obx(() => _buildPasswordField(
                controller: controller.signupConfirmController,
                hint: 'Re-enter your password',
                visible: controller.showSignupConfirm.value,
                onToggle: () => controller.showSignupConfirm.toggle(),
              )),
          const SizedBox(height: 28),
          // Create Account button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?  ',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: controller.goToLogin,
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// Shared helpers

Widget _buildLabel(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _buildPhoneField(TextEditingController textController) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: const Text(
            '+251',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '9X XXX XXXX',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPasswordField({
  required TextEditingController controller,
  required String hint,
  required bool visible,
  required VoidCallback onToggle,
}) {
  return TextField(
    controller: controller,
    obscureText: !visible,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      suffixIcon: GestureDetector(
        onTap: onToggle,
        child: Icon(
          visible ? Icons.visibility : Icons.visibility_off,
          size: 20,
          color: Colors.grey.shade500,
        ),
      ),
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
  );
}

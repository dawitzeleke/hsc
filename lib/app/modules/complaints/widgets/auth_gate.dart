import 'package:flutter/material.dart';
import 'package:hsc/core/constants/app_colors.dart';

class AuthGate extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onSignup;

  const AuthGate({
    super.key,
    required this.onLogin,
    required this.onSignup,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Shield icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 44,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Access Complaints',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Please log in or create an account to view and '
            'manage your complaints. This ensures your data '
            'is secure and accessible.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          // Log In button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLogin,
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
          const SizedBox(height: 12),
          // Create Account button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onSignup,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

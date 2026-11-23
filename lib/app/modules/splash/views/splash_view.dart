import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Center Section: Logo, Title & Subtitle
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: Transform.scale(
                        scale: 1.21,
                        child: Image.asset(
                          'assets/images/harari_logo.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Harari Region\nSupreme Court',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'COURT SERVICES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2.0,
                      color: AppColors.onPrimary.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Section: Indicator & LOADING
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: AppColors.onPrimary,
                        backgroundColor: AppColors.onPrimary.withOpacity(0.2),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'LOADING',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                        color: AppColors.onPrimary.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

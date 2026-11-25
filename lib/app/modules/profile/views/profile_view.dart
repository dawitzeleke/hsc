import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/app/widgets/app_header.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_sections.dart';
import '../widgets/profile_sheets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Column(
      children: [
        const AppHeader(
          leading: SizedBox.shrink(),
          title: 'My profile',
          subtitle: 'YOUR ACCOUNT & PREFERENCES',
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCard(
                  onEditTap: () =>
                      showEditProfileSheet(context, controller),
                ),
                const SizedBox(height: 20),
                const PersonalInfoSection(),
                const SizedBox(height: 20),
                AccountSupportSection(
                  onPasswordTap: () =>
                      showChangePasswordSheet(context, controller),
                ),
                const SizedBox(height: 24),
                _buildLogoutButton(),
                const SizedBox(height: 16),
                _buildSecureNote(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, size: 18, color: Colors.red.shade600),
              const SizedBox(width: 8),
              Text(
                'Log out',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecureNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shield_outlined, size: 14, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(
          'Your personal information is kept secure.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}

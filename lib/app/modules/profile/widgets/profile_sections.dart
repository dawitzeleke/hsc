import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'Personal information',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _InfoTile(
          icon: Icons.email_outlined,
          label: 'Email address',
          value: 'bereket.nig@email.com',
          isTop: true,
        ),
        _InfoTile(
          icon: Icons.phone_outlined,
          label: 'Mobile number',
          value: '+44 7700 900 123',
          isTop: false,
        ),
      ],
    );
  }
}

class AccountSupportSection extends StatelessWidget {
  final VoidCallback onPasswordTap;

  const AccountSupportSection({super.key, required this.onPasswordTap});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'Account & support',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.lock_outline,
                label: 'Password & security',
                trailing: Icon(Icons.chevron_right,
                    size: 20, color: Colors.grey.shade400),
                onTap: onPasswordTap,
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              Obx(() => _SettingsTile(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    trailing: SizedBox(
                      height: 24,
                      child: Switch(
                        value: controller.notificationsEnabled.value,
                        onChanged: controller.toggleNotifications,
                        activeColor: AppColors.primary,
                      ),
                    ),
                  )),
              Divider(height: 1, color: Colors.grey.shade200),
              _SettingsTile(
                icon: Icons.help_outline,
                label: 'Help & support',
                trailing: Icon(Icons.chevron_right,
                    size: 20, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isTop;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isTop
            ? const BorderRadius.vertical(top: Radius.circular(12))
            : const BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

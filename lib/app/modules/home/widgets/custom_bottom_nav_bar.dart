import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hsc/core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onServicesTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onServicesTap,
  });

  static const _items = [
    _NavItem(
      icon: "assets/icons/home.png",
      activeIcon: "assets/icons/home.png",
      label: 'Home',
    ),
    _NavItem(
      icon: "assets/icons/court_fee.png",
      activeIcon: "assets/icons/court_fee.png",
      label: 'Court Fee',
    ),
    _NavItem(
      icon: "assets/icons/complaints.png",
      activeIcon: "assets/icons/complaints.png",
      label: 'Complaints',
    ),
    _NavItem(
      icon: "assets/icons/profile.png",
      activeIcon: "assets/icons/profile.png",
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Nav bar pill
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.onPrimary,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: List.generate(_items.length, (index) {
                        final item = _items[index];
                        final isSelected = currentIndex == index;
                        return Expanded(
                          flex: isSelected ? 2 : 1,
                          child: GestureDetector(
                            onTap: () => onTap(index),
                            behavior: HitTestBehavior.opaque,
                            child: _buildNavItem(item, isSelected),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                // Briefcase button to the right
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onServicesTap,
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/robot.png',
                      height: 27,
                      width: 27,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(_NavItem item, bool isSelected) {
    if (isSelected) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                item.activeIcon,
                height: 20,
                width: 20,
                color: AppColors.onPrimary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Image.asset(
        item.icon,
        height: 24,
        width: 24,
        color: AppColors.primary.withOpacity(0.7),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

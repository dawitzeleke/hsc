import 'package:flutter/material.dart';
import 'package:hsc/core/constants/app_colors.dart';

class ActionCards extends StatelessWidget {
  const ActionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: ActionCard(
              icon: 'assets/icons/calender.png',
              title: 'Appointments',
              subtitle: 'Stay informed on\ncourt appointments.',
              buttonText: 'View Appointments',
              isFollowUp: false,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ActionCard(
              icon: 'assets/icons/search.png',
              title: 'Follow up',
              subtitle: 'Stay informed on\nyour case progress.',
              buttonText: 'Track a case',
              isFollowUp: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool isFollowUp;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.isFollowUp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isFollowUp ? AppColors.lightPrimary : AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isFollowUp
                  ? AppColors.onPrimary
                  : const Color.fromRGBO(255, 255, 255, 0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              icon,
              width: 25,
              height: 25,
              color: isFollowUp ? AppColors.primary : AppColors.onPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: isFollowUp ? AppColors.primary : AppColors.onPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isFollowUp ? Colors.grey.shade600 : AppColors.lightPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isFollowUp ? AppColors.primary : AppColors.onPrimary,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      buttonText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: isFollowUp
                            ? AppColors.onPrimary
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.north_east,
                    size: 13,
                    color:
                        isFollowUp ? AppColors.onPrimary : AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

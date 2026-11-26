import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/app/routes/app_pages.dart';
import 'package:hsc/app/widgets/appointment_card.dart';
import 'package:hsc/core/constants/app_colors.dart';

class AppointmentsSection extends StatelessWidget {
  const AppointmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/icons/calender.png',
                    width: 25,
                    height: 25,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Appointments",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '6 November 2026 · 3 scheduled',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.APPOINTMENTS),
                  child: const Row(
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const AppointmentCard(
              id: '00/0001/284930',
              time: '10:00 AM',
              plaintiff: 'Yewerq wha taye',
              plaintiffCount: '02',
              note: 'Up next · Please arrive 15 minutes early',
            ),
            const AppointmentCard(
              id: '00/0001/285027',
              time: '10:30 AM',
              plaintiff: 'Hawa Adem Mohammed',
              plaintiffCount: '01',
              note: 'Up next · Please arrive 45 minutes early',
            ),
            const AppointmentCard(
              id: '00/0001/284937',
              time: '10:30 AM',
              plaintiff: 'Hintsa Tesfay',
              plaintiffCount: '01',
              note: 'Up next · Please arrive 45 minutes early',
            ),
          ],
        ),
      ),
    );
  }
}

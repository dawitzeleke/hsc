import 'package:flutter/material.dart';
import 'package:hsc/core/constants/app_colors.dart';

class NewComplaintStepper extends StatelessWidget {
  final int currentStep;

  const NewComplaintStepper({super.key, required this.currentStep});

  static const _completedGreen = Color(0xFF0FA958);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _StepSegment(
                  stepNumber: 'Step 1',
                  title: 'Complaint Detail',
                  isActive: currentStep == 0,
                  isCompleted: currentStep > 0,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: _StepSegment(
                  stepNumber: 'Step 2',
                  title: 'Attachment & Contact Detail',
                  isActive: currentStep == 1,
                  isCompleted: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepSegment extends StatelessWidget {
  final String stepNumber;
  final String title;
  final bool isActive;
  final bool isCompleted;

  const _StepSegment({
    required this.stepNumber,
    required this.title,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final showDot = isActive || isCompleted;
    final accentColor =
        isCompleted ? NewComplaintStepper._completedGreen : AppColors.primary;
    final bgColor =
        showDot ? Colors.white : const Color(0xFFF0F2F4);

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showDot) ...[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepNumber,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: showDot ? FontWeight.w700 : FontWeight.w500,
                    color: isCompleted
                        ? NewComplaintStepper._completedGreen
                        : isActive
                            ? AppColors.primary
                            : const Color(0xFF374151),
                    height: 1.2,
                  ),
                ),
                if (showDot) ...[
                  const SizedBox(height: 2),
                  Text(
                    isCompleted ? 'Completed' : 'In Progress',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

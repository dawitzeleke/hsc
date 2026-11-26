import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/new_complaint_controller.dart';
import 'complaint_form_fields.dart';

class NewComplaintStep1 extends StatelessWidget {
  const NewComplaintStep1({super.key});

  String? _requiredText(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewComplaintController>();

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => ComplaintDropdownField(
              label: 'Court / office *',
              hint: 'Select court / office',
              value: controller.selectedCourt.value,
              items: controller.courts,
              onChanged: (v) => controller.selectedCourt.value = v,
              validator: (v) => v == null ? 'Please select court / office' : null,
            ),
          ),
          const SizedBox(height: 18),
          ComplaintTextField(
            label: "Judge's Name (optional)",
            hint: "Enter judge's name",
            controller: controller.judgeNameController,
          ),
          const SizedBox(height: 18),
          Obx(
            () => ComplaintDropdownField(
              label: 'Complaint category *',
              hint: 'Select category',
              value: controller.selectedCategory.value,
              items: controller.categories,
              onChanged: (v) => controller.selectedCategory.value = v,
              validator: (v) => v == null ? 'Please select a category' : null,
            ),
          ),
          const SizedBox(height: 18),
          ComplaintTextField(
            label: 'Subject *',
            hint: 'Enter subject',
            controller: controller.subjectController,
            validator: (v) => _requiredText(v, 'a subject'),
          ),
          const SizedBox(height: 18),
          ComplaintTextField(
            label: 'What happened? *',
            hint: 'Description',
            controller: controller.descriptionController,
            maxLines: 4,
            validator: (v) => _requiredText(v, 'a description'),
          ),
          const SizedBox(height: 18),
          ComplaintTextField(
            label: 'Date of incident *',
            hint: 'Select date',
            controller: controller.incidentDateController,
            readOnly: true,
            onTap: () => controller.pickIncidentDate(context),
            suffixIcon: Icon(
              Icons.calendar_month_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Please select incident date' : null,
          ),
          const SizedBox(height: 18),
          ComplaintTextField(
            label: 'Case number (optional)',
            hint: 'Enter case number',
            controller: controller.caseNumberController,
          ),
          const SizedBox(height: 8),
          Text(
            'Add a case number if your complaint relates to a case.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import 'package:hsc/app/routes/app_pages.dart';
import '../widgets/complaint_submitted_dialog.dart';
import 'complaints_controller.dart';

class NewComplaintController extends GetxController {
  final currentStep = 0.obs;
  final formKey = GlobalKey<FormState>();

  final courts = const [
    'Harari Region Supreme Court',
    'Harari Region High Court',
    'Harari Region First Instance Court',
    'Court Administration Office',
  ];

  final categories = const [
    'Service delay',
    'Case records',
    'Online services',
    'Staff conduct',
    'Other',
  ];

  // Step 1 fields
  final selectedCourt = RxnString();
  final judgeNameController = TextEditingController();
  final selectedCategory = RxnString();
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final incidentDate = Rxn<DateTime>();
  final incidentDateController = TextEditingController();
  final caseNumberController = TextEditingController();

  // Step 2 fields
  final attachmentName = RxnString();
  final attachmentSize = RxnString();
  final contactNameController = TextEditingController();
  final contactPhoneController =
      TextEditingController(text: '+251 91 234 5678');
  final isConfirmed = false.obs;

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Future<void> pickIncidentDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: incidentDate.value ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      incidentDate.value = picked;
      incidentDateController.text =
          '${picked.day.toString().padLeft(2, '0')} ${_months[picked.month - 1]}, ${picked.year}';
    }
  }

  void setAttachment(String name, String size) {
    attachmentName.value = name;
    attachmentSize.value = size;
  }

  void clearAttachment() {
    attachmentName.value = null;
    attachmentSize.value = null;
  }

  void nextStep() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      currentStep.value = 1;
    }
  }

  void previousStep() {
    FocusManager.instance.primaryFocus?.unfocus();
    currentStep.value = 0;
  }

  void resetForm() {
    selectedCourt.value = null;
    judgeNameController.clear();
    selectedCategory.value = null;
    subjectController.clear();
    descriptionController.clear();
    incidentDate.value = null;
    incidentDateController.clear();
    caseNumberController.clear();
    clearAttachment();
    contactNameController.clear();
    contactPhoneController.text = '+251 91 234 5678';
    isConfirmed.value = false;
    currentStep.value = 0;
  }

  void submitComplaint() {
    if (!isConfirmed.value) {
      Get.snackbar(
        'Confirmation Required',
        'Please confirm that the information provided is accurate.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')} ${_months[now.month - 1]} ${now.year}';
    final hour12 = now.hour == 0
        ? 12
        : (now.hour > 12 ? now.hour - 12 : now.hour);
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final submittedAt =
        '$formattedDate · $hour12:${now.minute.toString().padLeft(2, '0')} $period';

    var referenceId = 'CMP-${now.year}-0149';

    if (Get.isRegistered<ComplaintsController>()) {
      final complaintsController = Get.find<ComplaintsController>();
      final offset = (complaintsController.complaints.length - 3).clamp(0, 9999);
      final nextNum = 149 + offset;
      referenceId = 'CMP-${now.year}-${nextNum.toString().padLeft(4, '0')}';

      complaintsController.addComplaint(
        ComplaintItem(
          id: referenceId,
          title: subjectController.text.trim(),
          category: selectedCategory.value ?? 'Other',
          date: formattedDate,
          status: 'In review',
          statusNote: 'Received · Awaiting review',
          courtOffice: selectedCourt.value ?? 'Harari Region Supreme Court',
          judgeName: judgeNameController.text.trim(),
          description: descriptionController.text.trim(),
          caseNumber: caseNumberController.text.trim().isEmpty
              ? '-'
              : caseNumberController.text.trim(),
          incidentDate: incidentDateController.text.trim(),
          contactName: contactNameController.text.trim().isEmpty
              ? 'Bereket Nigussie'
              : contactNameController.text.trim(),
          contactPhone: contactPhoneController.text.trim(),
          attachmentName: attachmentName.value ?? '',
          attachmentSize: attachmentSize.value ?? '',
        ),
      );
    }

    Get.dialog(
      ComplaintSubmittedDialog(
        referenceId: referenceId,
        submittedAt: submittedAt,
        onViewComplaints: () {
          Get.until(
            (route) => route.settings.name == Routes.HOME || route.isFirst,
          );
        },
        onFileAnother: resetForm,
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    judgeNameController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    incidentDateController.dispose();
    caseNumberController.dispose();
    contactNameController.dispose();
    contactPhoneController.dispose();
    super.onClose();
  }
}

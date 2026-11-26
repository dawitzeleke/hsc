import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsc/core/constants/app_colors.dart';
import '../controllers/new_complaint_controller.dart';
import 'complaint_form_fields.dart';

class NewComplaintStep2 extends StatelessWidget {
  const NewComplaintStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewComplaintController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComplaintFieldLabel('Attachments (optional)'),
        Obx(() => _buildAttachmentBox(context, controller)),
        const SizedBox(height: 20),
        ComplaintTextField(
          label: "Contact person's full name",
          hint: 'Enter name',
          controller: controller.contactNameController,
        ),
        const SizedBox(height: 20),
        ComplaintTextField(
          label: 'Contact phone number',
          hint: '+251 91 234 5678',
          controller: controller.contactPhoneController,
          keyboardType: TextInputType.phone,
          suffixIcon: const Icon(
            Icons.verified_user_outlined,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "We'll send updates to your registered number.",
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Obx(
          () => GestureDetector(
            onTap: () => controller.isConfirmed.toggle(),
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: Checkbox(
                    value: controller.isConfirmed.value,
                    onChanged: (v) =>
                        controller.isConfirmed.value = v ?? false,
                    activeColor: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'I confirm that the information provided is accurate to the '
                    'best of my knowledge.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: controller.previousStep,
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimary.withOpacity(0.55),
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: controller.submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Submit Complaint',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachmentBox(
    BuildContext context,
    NewComplaintController controller,
  ) {
    final name = controller.attachmentName.value;
    if (name != null) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.lightPrimary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${controller.attachmentSize.value ?? ''} · Uploaded',
                    style: TextStyle(fontSize: 11.5, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: controller.clearAttachment,
              child: Icon(Icons.close, size: 20, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showAttachmentPicker(context, controller),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.lightPrimary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.file_upload_outlined,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Add a photo or document',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'JPG, PNG or PDF · Up to 5 MB per file',
              style: TextStyle(fontSize: 11.5, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  void _showAttachmentPicker(
    BuildContext context,
    NewComplaintController controller,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select attachment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.photo_outlined, color: AppColors.primary),
                title: const Text('Court_Notice.jpg'),
                subtitle: const Text('1.2 MB · Image'),
                onTap: () {
                  controller.setAttachment('Court_Notice.jpg', '1.2 MB');
                  Get.back();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('Attachment.pdf'),
                subtitle: const Text('248 KB · PDF Document'),
                onTap: () {
                  controller.setAttachment('Attachment.pdf', '248 KB');
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/theme/app_color.dart';

import '../../../../controller/subcontractor_job_controller.dart';
import '../../../../core/shared_widgets/custom_text.dart';

import 'package:gap/gap.dart';

class AttachmentsSectionWidget extends StatelessWidget {
  const AttachmentsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubcontractorJobController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CustomText(
              text: 'Attachments',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _showTooltip(
                  context, 'Upload photos of completed work or bid documents'),
              child: const Icon(
                Icons.help_outline,
                size: 16,
                color: AppColor.midGray,
              ),
            ),
          ],
        ),
        const Gap(10),
        GestureDetector(
          onTap: () => _pickFile(controller),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.white,
              border:
                  Border.all(color: AppColor.midGray, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.attach_file, color: AppColor.midGray),
                SizedBox(width: 8),
                CustomText(
                  text: 'Add photos or documents',
                  fontSize: 14,
                  color: AppColor.midGray,
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        Obx(() => Column(
              children: controller.attachments.asMap().entries.map((entry) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.backgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.value.split('/').last,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.removeAttachment(entry.key),
                        child: const Icon(Icons.close,
                            size: 16, color: Colors.red),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  void _pickFile(SubcontractorJobController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      controller.addAttachment(result.files.single.path ?? '');
    }
  }

  void _showTooltip(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColor.black.withOpacity(0.8),
      ),
    );
  }
}

part of 'widgets.dart';

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MediationProcessPageController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Upload Evidence',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          Text(
            'You can upload photos, screenshots, or documents to help explain your issue.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),

          // Upload button
          GestureDetector(
            onTap: () => _showUploadOptions(context),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColor.darkGrayShade, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
                color: AppColor.backgroundColor.withOpacity(0.1),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: AppColor.darkGrayShade),
                  SizedBox(width: 8),
                  Text(
                    'Add Evidence',
                    style: TextStyle(
                      color: AppColor.darkGrayShade,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Uploaded files
          Obx(() => controller.uploadedFiles.isNotEmpty
              ? Column(
                  children: controller.uploadedFiles.map((file) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _getFileIcon(file['type']),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  file['label'] ?? 'Untitled',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColor.midGray,
                                  ),
                                ),
                                Text(
                                  file['type'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => controller.removeFile(file['id']),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox.shrink()),

          if (controller.uploadedFiles.length >= 10)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Maximum 10 files allowed',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return const Icon(Icons.image, color: Colors.blue);
      case 'video':
        return const Icon(Icons.videocam, color: Colors.red);
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      default:
        return const Icon(Icons.insert_drive_file, color: Colors.grey);
    }
  }

  void _showUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Evidence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _handleFileUpload(context, 'camera');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _handleFileUpload(context, 'gallery');
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Upload Document'),
              onTap: () {
                Navigator.pop(context);
                _handleFileUpload(context, 'document');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleFileUpload(BuildContext context, String type) {
    // Show label input dialog
    final labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Label'),
        content: TextField(
          controller: labelController,
          style: const TextStyle(color: AppColor.midGray),
          decoration: const InputDecoration(
            hintText: 'e.g., "Chat with PM" or "Damaged wall"',
            hintStyle: TextStyle(color: AppColor.midGray),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _processFileUpload(type, labelController.text.trim());
            },
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _processFileUpload(String type, String label) {
    final controller = Get.find<MediationProcessPageController>();

    // Simulate file upload - replace with actual implementation
    controller.addFile(
      File(''), // Replace with actual file
      type == 'document' ? 'pdf' : 'image',
      label.isEmpty ? 'Untitled' : label,
    );
  }
}

part of 'widgets.dart';

class PhotoUploadWidget extends StatelessWidget {
  const PhotoUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadProgressController>();

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
            text: 'Photos (Before and After Work)',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          const SizedBox(height: 16),

          // Add Photo button
          GestureDetector(
            onTap: () => _showUploadOptions(context),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.darkGrayShade),
                borderRadius: BorderRadius.circular(12),
                color: AppColor.backgroundColor.withOpacity(0.1),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: AppColor.darkGrayShade),
                  SizedBox(width: 8),
                  Text(
                    'Add Photo',
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

          // Uploaded images
          Obx(() => controller.uploadedImages.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: controller.uploadedImages.length,
                  itemBuilder: (context, index) {
                    final image = controller.uploadedImages[index];
                    return _buildImageThumbnail(image, context);
                  },
                )
              : const SizedBox.shrink()),

          Obx(() => controller.uploadedImages.length >= 8
              ? Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Maximum 8 photos allowed',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildImageThumbnail(
      Map<String, dynamic> image, BuildContext context) {
    final controller = Get.find<UploadProgressController>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    color: Colors.grey[200],
                  ),
                  child: _getImageWidget(image['type']),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => controller.removeImage(image['id']),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: DropdownButton<String>(
              value: image['tag'],
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(
                fontSize: 12,
                color: AppColor.midGray,
              ),
              items: controller.imageTags.map((tag) {
                return DropdownMenuItem(
                  value: tag,
                  child: Text(tag),
                );
              }).toList(),
              onChanged: (newTag) {
                if (newTag != null) {
                  controller.updateImageTag(image['id'], newTag);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageWidget(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return const Icon(Icons.image, color: Colors.blue, size: 40);
      case 'video':
        return const Icon(Icons.videocam, color: Colors.red, size: 40);
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40);
      default:
        return const Icon(Icons.insert_drive_file,
            color: Colors.grey, size: 40);
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
              'Add Photo',
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
    final controller = Get.find<UploadProgressController>();

    // Show tag selection dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Tag'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: controller.imageTags.map((tag) {
            return ListTile(
              title: Text(tag),
              onTap: () {
                Navigator.pop(context);
                _processFileUpload(type, tag);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _processFileUpload(String type, String tag) {
    final controller = Get.find<UploadProgressController>();

    // Simulate file upload - replace with actual implementation
    controller.addImage(
      File(''), // Replace with actual file
      type == 'document' ? 'pdf' : 'image',
      tag,
    );
  }
}

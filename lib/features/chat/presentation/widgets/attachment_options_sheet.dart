part of 'widget.dart';

class AttachmentOptionsSheet extends StatelessWidget {
  final Function(String type) onAttachmentSelected;

  const AttachmentOptionsSheet({
    super.key,
    required this.onAttachmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Add Attachment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildAttachmentOption(
                  icon: Icons.camera_alt,
                  title: 'Take Photo',
                  subtitle: 'Capture work progress or issues',
                  onTap: () {
                    Navigator.pop(context);
                    onAttachmentSelected('camera');
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.photo_library,
                  title: 'Photo Gallery',
                  subtitle: 'Select from your photos',
                  onTap: () {
                    Navigator.pop(context);
                    onAttachmentSelected('gallery');
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.picture_as_pdf,
                  title: 'PDF Document',
                  subtitle: 'Upload permits, scope, or contracts',
                  onTap: () {
                    Navigator.pop(context);
                    onAttachmentSelected('pdf');
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.work,
                  title: 'Link Job',
                  subtitle: 'Reference a specific job',
                  onTap: () {
                    Navigator.pop(context);
                    onAttachmentSelected('job');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGray),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.mutedGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColor.mutedGold,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.midGray,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColor.midGray,
            ),
          ],
        ),
      ),
    );
  }
}

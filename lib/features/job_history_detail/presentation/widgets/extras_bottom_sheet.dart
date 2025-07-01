part of 'widgets.dart';

class ExtrasBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> extrasData;
  final String extrasStatus;
  final VoidCallback onClose;

  const ExtrasBottomSheet({
    super.key,
    required this.extrasData,
    required this.extrasStatus,
    required this.onClose,
  });

  // Helper method to format date
  String _formatDate(String? timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  // Helper method to calculate total
  double _calculateTotal() {
    return extrasData.fold(
        0.0, (sum, item) => sum + (item['price'] as double? ?? 0.0));
  }

  // Method to get the appropriate status text
  String _getExtrasStatusText() {
    switch (extrasStatus) {
      case 'pending':
        return 'Pending';
      case 'approved':
        return 'Approved';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColor.lightGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Added Extras',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: AppColor.midGray),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Extras list
          if (extrasData.isEmpty)
            const Center(
              child: Text(
                'No extras added yet',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.midGray,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ),
            )
          else
            ...extrasData.asMap().entries.map((entry) {
              final index = entry.key;
              final extra = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.lightGray, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            extra['description'] ?? 'No description',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                              fontFamily: 'HelveticaNeueMedium',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Added: ${_formatDate(extra['timestamp'])}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.midGray,
                              fontFamily: 'HelveticaNeueMedium',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${extra['price'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mutedGold,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          const SizedBox(height: 16),
          // Total section
          if (extrasData.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.mutedGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.mutedGold, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Extras:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                      fontFamily: 'HelveticaNeueMedium',
                    ),
                  ),
                  Text(
                    '\$${_calculateTotal().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColor.mutedGold,
                      fontFamily: 'HelveticaNeueMedium',
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

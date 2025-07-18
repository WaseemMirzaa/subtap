part of 'widget.dart';

class JobLinkAttachment extends StatelessWidget {
  final String jobId;
  final String jobTitle;
  final String status;
  final double budget;

  const JobLinkAttachment({
    super.key,
    required this.jobId,
    required this.jobTitle,
    required this.status,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.mutedGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.mutedGold.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.mutedGold,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.work,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Job $jobId',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.mutedGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      jobTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.midGray,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '\$${budget.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColor.midGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return AppColor.midGray;
    }
  }
}
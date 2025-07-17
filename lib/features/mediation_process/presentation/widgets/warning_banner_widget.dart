part of 'widgets.dart';

class WarningBannerWidget extends StatelessWidget {
  const WarningBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[300]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[700],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Submitting a dispute may pause job payments until it is resolved.',
              style: TextStyle(
                color: Colors.orange[800],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
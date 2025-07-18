part of 'widget.dart';

class LoadEarlierMessages extends StatelessWidget {
  final VoidCallback onLoadMore;
  final bool isLoading;

  const LoadEarlierMessages({
    super.key,
    required this.onLoadMore,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.mutedGold),
                ),
              )
            : GestureDetector(
                onTap: onLoadMore,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.mutedGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.mutedGold.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: AppColor.mutedGold,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Load earlier messages...',
                        style: TextStyle(
                          color: AppColor.mutedGold,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
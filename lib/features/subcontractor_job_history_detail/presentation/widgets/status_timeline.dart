part of 'widgets.dart';

class StatusTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> statuses;

  const StatusTimeline({
    super.key,
    required this.statuses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(statuses.length, (index) {
        final status = statuses[index];
        final isLast = index == statuses.length - 1;
        final isCompleted = status['isCompleted'] == true;
        final isCurrent = !isCompleted &&
            (index == 0 || statuses[index - 1]['isCompleted'] == true);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline icon and line
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? Colors.green
                        : isCurrent
                            ? Colors.orange
                            : AppColor.lightGray,
                    border: Border.all(
                      color: isCompleted
                          ? Colors.green
                          : isCurrent
                              ? Colors.orange
                              : AppColor.midGray,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : isCurrent
                            ? const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 18,
                              )
                            : const Icon(
                                Icons.lock_outline,
                                color: AppColor.midGray,
                                size: 18,
                              ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 3,
                    height: 50,
                    color: isCompleted ? Colors.green : AppColor.lightGray,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Status and date
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status['status']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.w500,
                        color: isCompleted
                            ? AppColor.black
                            : isCurrent
                                ? AppColor.black
                                : AppColor.midGray,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                    if (status['date']!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          status['date']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColor.midGray,
                            fontFamily: 'HelveticaNeueMedium',
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

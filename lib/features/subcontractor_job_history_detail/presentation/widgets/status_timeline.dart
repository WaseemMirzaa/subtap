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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline icon and line
            Column(
              children: [
                Container(
                  width: 33,
                  height: 33,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    color: status['isCompleted'] == true
                        ? AppColor.white
                        : AppColor.midGray,
                  ),
                  child: status['isCompleted'] == true
                      ? Center(
                          child: SvgPicture.asset(
                            Assets
                                .svgsCheck, // Replace with your SVG asset path
                            width: 13,
                            height: 9,
                            fit: BoxFit.contain,

                            color: Colors.black,
                          ),
                        )
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: AppColor.white,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Status and date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status['status']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: status['isCompleted'] == true
                          ? AppColor.black
                          : AppColor.midGray,
                      fontFamily: 'HelveticaNeueMedium',
                    ),
                  ),
                  if (status['date']!.isNotEmpty)
                    Text(
                      status['date']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColor.midGray,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

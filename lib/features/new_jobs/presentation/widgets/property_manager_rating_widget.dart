part of 'widgets.dart';

class PropertyManagerRatingWidget extends StatelessWidget {
  final PropertyManagerModel? propertyManager;

  const PropertyManagerRatingWidget({super.key, this.propertyManager});

  @override
  Widget build(BuildContext context) {
    if (propertyManager == null) return const SizedBox.shrink();

    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: AssetImage(propertyManager!.imageUrl ?? ''),
        ),
        const SizedBox(width: 6),
        Text(
          'Rated ${propertyManager!.rating?.toStringAsFixed(1) ?? '0.0'} ★ by ${propertyManager!.totalJobs ?? 0} subcontractors',
          style: const TextStyle(
            fontSize: 12,
            color: AppColor.midGray,
            fontWeight: FontWeight.w400,
            fontFamily: 'HelveticaNeueMedium',
          ),
        ),
      ],
    );
  }
}
part of 'widgets.dart';

class ExtrasHelperText extends StatelessWidget {
  const ExtrasHelperText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColor.white,
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Describe any extra time, materials, or work needed. Your request will be reviewed by the property manager.',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
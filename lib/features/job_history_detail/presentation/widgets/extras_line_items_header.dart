part of 'widgets.dart';

class ExtrasLineItemsHeader extends StatelessWidget {
  const ExtrasLineItemsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomText(
            text: 'Description',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: CustomText(
            text: 'Qty',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomText(
            text: 'Price (\$)',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: CustomText(
            text: 'Total',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
        ),
        SizedBox(width: 40), // Space for actions
      ],
    );
  }
}
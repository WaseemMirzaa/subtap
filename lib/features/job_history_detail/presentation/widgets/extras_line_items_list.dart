part of 'widgets.dart';

class ExtrasLineItemsList extends StatelessWidget {
  const ExtrasLineItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const ExtrasLineItemsHeader(),
        const SizedBox(height: 12),
        
        // Line items
        ...controller.lineItems.asMap().entries.map((entry) {
          int index = entry.key;
          var item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ExtrasLineItemRow(
              index: index,
              item: item,
            ),
          );
        }).toList(),
        
        // Add item button
        const SizedBox(height: 8),
        const ExtrasAddItemButton(),
      ],
    ));
  }
}
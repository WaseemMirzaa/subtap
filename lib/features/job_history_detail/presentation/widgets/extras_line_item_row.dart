part of 'widgets.dart';

class ExtrasLineItemRow extends StatelessWidget {
  final int index;
  final Map<String, dynamic> item;

  const ExtrasLineItemRow({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExtrasController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Description field
              Expanded(
                flex: 3,
                child: CustomTextField(
                  controller: item['description'],
                  hintText: 'e.g., Additional labor time',
                  fillColor: AppColor.offWhite,
                  borderColor: AppColor.lightGray,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  borderRadius: 6,
                  height: 40,
                  onChanged: (value) => controller.validateLineItem(index),
                ),
              ),
              const SizedBox(width: 8),

              // Quantity field
              Expanded(
                flex: 1,
                child: CustomTextField(
                  controller: item['quantity'],
                  hintText: '1',
                  fillColor: AppColor.offWhite,
                  borderColor: AppColor.lightGray,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  borderRadius: 6,
                  height: 40,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.calculateLineTotal(index),
                ),
              ),
              const SizedBox(width: 8),

              // Price field
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: item['price'],
                  hintText: '100.00',
                  fillColor: AppColor.offWhite,
                  borderColor: AppColor.lightGray,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  borderRadius: 6,
                  height: 40,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) => controller.calculateLineTotal(index),
                ),
              ),
              const SizedBox(width: 8),

              // Total display
              Expanded(
                flex: 2,
                child: Obx(() => Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColor.mutedGold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: AppColor.mutedGold.withOpacity(0.3)),
                      ),
                      child: Center(
                        child: Text(
                          '\$${controller.getLineTotal(index).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mutedGold,
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 8),

              // Action buttons
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    // Edit button
                    GestureDetector(
                      onTap: () => controller.editLineItem(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          '✏️',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Delete button
                    if (controller.lineItems.length > 1)
                      GestureDetector(
                        onTap: () => controller.removeLineItem(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Text(
                            '🗑️',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Error message for this line item
          Obx(() => controller.getLineItemError(index).isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.getLineItemError(index),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

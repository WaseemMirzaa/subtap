part of 'widgets.dart';

class CustomExtraBottomSheet extends StatefulWidget {
  const CustomExtraBottomSheet({super.key});

  @override
  _CustomExtraBottomSheetState createState() => _CustomExtraBottomSheetState();
}

class _CustomExtraBottomSheetState extends State<CustomExtraBottomSheet> {
  late final JobRequestController controller;
  late final ExtrasController extrasController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    controller = Get.put(JobRequestController(), tag: 'extraBottomSheet');
    extrasController = Get.find<ExtrasController>();
  }

  @override
  void dispose() {
    // Dispose of JobRequestController when the widget is disposed
    if (Get.isRegistered<JobRequestController>(tag: 'extraBottomSheet')) {
      Get.delete<JobRequestController>(tag: 'extraBottomSheet');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: AppColor.lightGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Line Items Section
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.47,
                          child: CustomText(
                            text: 'Line Item Description',
                            fontSize: screenWidth > 600 ? 18 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: controller.lineItems.length > 1
                              ? screenWidth * 0.39
                              : screenWidth * 0.29,
                          child: CustomText(
                            text: 'Price (\$)',
                            fontSize: screenWidth > 600 ? 18 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    // Dynamic Line Items
                    Column(
                      children: controller.lineItems.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          var item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Description field
                                SizedBox(
                                  width: screenWidth * 0.46,
                                  child: CustomTextField(
                                    fillColor: AppColor.white,
                                    controller: item['description'],
                                    borderColor: AppColor.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 14,
                                    ),
                                    borderRadius: 10,
                                    height: 45,
                                    hintText: 'Description field',
                                    fontStyle: FontStyle.normal,
                                    hintTextColor: AppColor.darkGrayShade,
                                    keyboardType: TextInputType.text,
                                    readOnly: controller.makeCounterOffer.value,
                                  ),
                                ),
                                // Price field
                                SizedBox(
                                  width: screenWidth * 0.29,
                                  child: CustomTextField(
                                    fillColor: AppColor.white,
                                    controller: item['price'],
                                    borderColor: AppColor.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 14,
                                    ),
                                    borderRadius: 10,
                                    height: 46,
                                    hintText: 'Price field',
                                    hintStyle: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'HelveticaNeueLight',
                                      color: AppColor.midGray,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    fontStyle: FontStyle.normal,
                                    hintTextColor: AppColor.darkGrayShade,
                                    keyboardType: TextInputType.number,
                                    readOnly: controller.makeCounterOffer.value,
                                  ),
                                ),
                                // Delete Icon
                                if (!controller.makeCounterOffer.value &&
                                    controller.lineItems.length > 1)
                                  GestureDetector(
                                    onTap: () =>
                                        controller.removeLineItem(index),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: SvgPicture.asset(
                                        Assets.svgsDelete,
                                        width: 20,
                                        height: 20,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    // Add Item Button
                    if (!controller.makeCounterOffer.value)
                      GestureDetector(
                        onTap: controller.addNewLineItem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Assets.svgsAddIcon,
                              width: 12,
                              height: 12,
                              color: AppColor.black,
                            ),
                            const SizedBox(width: 8),
                            const CustomText(
                              text: 'Add Item',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
            const Gap(20),
            // Submit Button with Loader
            Obx(() => CustomButton(
                  text: 'Submit',
                  isLoading: extrasController.isSubmitting.value,
                  loadingColor: Colors.white,
                  onTap: extrasController.isSubmitting.value
                      ? null
                      : () async {
                          try {
                            extrasController.isSubmitting.value = true;
                            print('Submitting extras...');
                            print('Line items: ${controller.lineItems}');

                            // Validate line items
                            bool isValid = true;
                            String errorMessage = '';

                            if (controller.lineItems.isEmpty) {
                              isValid = false;
                              errorMessage = 'Please add at least one item';
                            } else {
                              for (var item in controller.lineItems) {
                                final description =
                                    item['description']?.text.trim() ?? '';
                                final price = item['price']?.text.trim() ?? '';

                                if (description.isEmpty || price.isEmpty) {
                                  isValid = false;
                                  errorMessage =
                                      'Please fill in all description and price fields';
                                  break;
                                }

                                // Validate price is a valid number
                                final priceValue = double.tryParse(price);
                                if (priceValue == null || priceValue <= 0) {
                                  isValid = false;
                                  errorMessage =
                                      'Please enter valid prices greater than 0';
                                  break;
                                }
                              }
                            }

                            if (isValid) {
                              // Create extras data
                              List<Map<String, dynamic>> extrasData = [];
                              for (var item in controller.lineItems) {
                                extrasData.add({
                                  'description':
                                      item['description']!.text.trim(),
                                  'price':
                                      double.parse(item['price']!.text.trim()),
                                  'timestamp': DateTime.now().toIso8601String(),
                                });
                              }

                              // Simulate async operation (e.g., API call)
                              await Future.delayed(const Duration(seconds: 1));

                              // Show success message
                              Get.snackbar(
                                'Success',
                                'Extra items submitted successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: AppColor.white,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 3),
                              );

                              // Defer Navigator.pop to avoid race conditions
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context, {
                                    'success': true,
                                    'extrasData': extrasData,
                                  });
                                }
                              });
                            } else {
                              Get.snackbar(
                                'Error',
                                errorMessage,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: AppColor.white,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 3),
                              );
                            }
                          } catch (e) {
                            print('Error in CustomExtraBottomSheet submit: $e');
                            Get.snackbar(
                              'Error',
                              'An unexpected error occurred: $e',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: AppColor.white,
                              margin: const EdgeInsets.all(16),
                              duration: const Duration(seconds: 3),
                            );
                          } finally {
                            extrasController.isSubmitting.value = false;
                          }
                        },
                  color: AppColor.mutedGold,
                  textColor: Colors.white,
                  fontWeight: FontWeight.w400,
                  radius: 14,
                  width: double.infinity,
                  fontFamily: 'HelveticaNeueMedium',
                )),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

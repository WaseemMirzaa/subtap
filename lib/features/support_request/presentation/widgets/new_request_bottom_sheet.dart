import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/support_request_controller.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class NewRequestBottomSheet extends StatefulWidget {
  const NewRequestBottomSheet({super.key});

  @override
  State<NewRequestBottomSheet> createState() => _NewRequestBottomSheetState();
}

class _NewRequestBottomSheetState extends State<NewRequestBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String selectedType = 'General Support';
  final List<String> requestTypes = [
    'General Support',
    'Order Issue',
    'Payment Problem',
    'Technical Issue',
    'Dispute/Mediation'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _orderIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Create New Request',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 20),

              // Form
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _titleController,
                        label: 'Request Title',
                        hint: 'Brief description of your issue',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _orderIdController,
                        label: 'Order ID (Optional)',
                        hint: 'e.g., FO52072C9E905',
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Description',
                        hint:
                            'Please provide detailed information about your issue',
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      onTap: () => Navigator.pop(context),
                      color: AppColor.whiteSmoke,
                      textColor: AppColor.midGray,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Submit Request',
                      onTap: _submitRequest,
                      color: AppColor.mutedGold,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: AppColor.midGray,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                color: AppColor.mediumGray, fontWeight: FontWeight.w200),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.lightGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.mutedGold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Request Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGray),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: selectedType,
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down,
                    color: AppColor.darkGrayShade, size: 24),
                openMenuIcon: Icon(Icons.keyboard_arrow_up,
                    color: AppColor.mutedGold, size: 24),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColor.lightGray),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              buttonStyleData: ButtonStyleData(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.white,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              items: requestTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedType = newValue;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _submitRequest() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final controller = Get.find<SupportRequestController>();

    final newRequest = SupportRequest(
      id: 'SR${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text,
      orderId:
          _orderIdController.text.isNotEmpty ? _orderIdController.text : 'N/A',
      status: SupportStatus.pending,
      type: _getRequestType(selectedType),
      submittedAt: DateTime.now(),
      lastUpdatedAt: DateTime.now(),
      lastUpdatedBy: 'System',
      responsePreview: 'Your request has been submitted and is being reviewed.',
      isUnread: false,
      messages: [
        SupportMessage(
          id: 'msg${DateTime.now().millisecondsSinceEpoch}',
          text: _descriptionController.text,
          isFromUser: true,
          timestamp: DateTime.now(),
        ),
      ],
    );

    controller.addNewRequest(newRequest);

    Navigator.pop(context);

    Get.snackbar(
      'Success',
      'Your support request has been submitted successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  SupportType _getRequestType(String type) {
    switch (type) {
      case 'Dispute/Mediation':
        return SupportType.dispute;
      case 'Payment Problem':
        return SupportType.refund;
      case 'Technical Issue':
        return SupportType.technical;
      default:
        return SupportType.general;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';

class DateTimePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final Function(String?)? onChanged;
  final DateTime? firstDate;

  const DateTimePicker({
    super.key,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.onChanged,
    this.firstDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly
          ? null
          : () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: controller.text.isNotEmpty
                    ? DateTime.parse(controller.text)
                    : DateTime.now(),
                firstDate: firstDate ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                final formattedDate =
                    pickedDate.toIso8601String().split('T')[0];
                controller.text = formattedDate;
                if (onChanged != null) {
                  onChanged!(formattedDate);
                }
              }
            },
      child: AbsorbPointer(
        child: CustomTextField(
          fillColor: AppColor.white,
          controller: controller,
          borderColor: AppColor.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 14,
          ),
          borderRadius: 10,
          height: 45,
          hintText: hintText,
          fontStyle: FontStyle.normal,
          hintTextColor: AppColor.darkGrayShade,
          keyboardType: TextInputType.datetime,
          readOnly: true,
        ),
      ),
    );
  }
}

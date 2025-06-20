import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_textfield.dart';
import 'package:subtap/core/theme/app_color.dart';

class DateTimePicker extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;

  const DateTimePicker({
    super.key,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  Future<void> _selectDate(BuildContext context) async {
    if (widget.readOnly) return; // Don't show picker if read-only

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          fillColor: AppColor.white,
          controller: widget.controller,
          borderColor: AppColor.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 15,
          ),
          borderRadius: 10,
          height: 45,
          hintText: widget.hintText,
          fontStyle: FontStyle.normal,
          hintTextColor: AppColor.darkGrayShade,
          keyboardType: TextInputType.none,
          readOnly:
              true, // Always read-only since we handle input via date picker
        ),
      ),
    );
  }
}

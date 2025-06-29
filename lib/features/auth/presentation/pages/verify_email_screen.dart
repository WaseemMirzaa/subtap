import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/shared_widgets/custom_button.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of TextEditingControllers for each TextField
    final List<TextEditingController> controllers =
        List.generate(5, (_) => TextEditingController());
    // Create a list of FocusNodes for each TextField
    final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

    return Scaffold(
      backgroundColor: AppColor.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          text: 'Verify Your Email',
          color: AppColor.black,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0).copyWith(top: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: "We've Sent a Verification Code\nto Your Email.",
                textAlign: TextAlign.center,
                color: AppColor.black,
                fontSize: 18,
                maxLines: 2,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => SizedBox(
                    width: 57,
                    height: 50,
                    child: TextFormField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF1A1A1A),
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 4), // Adjusted padding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 4) {
                          FocusScope.of(context)
                              .requestFocus(focusNodes[index + 1]);
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(focusNodes[index - 1]);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                onTap: () {
                  // Combine the input from all controllers to form the code
                  // String code = controllers.map((c) => c.text).join();
                  // if (code.length == 5) {
                  Get.toNamed(AppRoutes.selectRole);
                  //  else {
                  //   // Optionally show a snackbar or error message
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //         content: Text('Please enter a complete code')),
                  //   );
                  // }
                },
                text: 'Verify Email',
                radius: 20,
                height: 55,
              ),
              const SizedBox(height: 13),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Resend Email',
                  style: TextStyle(color: AppColor.backColor, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

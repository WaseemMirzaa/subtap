import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/upload_progress_controller.dart';
import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';
import 'package:subtap/features/subcontractor_home/presentation/widgets/widgets.dart';

class UploadProgressPage extends StatelessWidget {
  const UploadProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(UploadProgressController());

    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const UploadProgressAppbar(),
      body: Column(
        children: [
          // Scrollable content
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with job info and banner
                  UploadProgressHeaderWidget(),

                  SizedBox(height: 20),

                  // Form sections
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ProgressNotesWidget(),
                        SizedBox(height: 16),
                        AdditionalCommentsWidget(),
                        SizedBox(height: 16),
                        PhotoUploadWidget(),
                        SizedBox(height: 100), // Space for bottom buttons
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom submit buttons
          if (!isKeyboardOpen) const UploadProgressSubmitButtons(),
        ],
      ),
    );
  }
}

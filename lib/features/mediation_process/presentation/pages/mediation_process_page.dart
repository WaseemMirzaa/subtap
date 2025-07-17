part of 'pages.dart';

class MediationProcessPage extends StatefulWidget {
  const MediationProcessPage({super.key});

  @override
  State<MediationProcessPage> createState() => _MediationProcessPageState();
}

class _MediationProcessPageState extends State<MediationProcessPage> {
  @override
  void initState() {
    super.initState();
    // Initialize controller
    Get.put(MediationProcessPageController());
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SubtapScaffold(
      appBar: const MediationProcessAppbar(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator (optional)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColor.mutedGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Step 1/1',
                      style: TextStyle(
                        color: AppColor.mutedGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Warning banner
                  const WarningBannerWidget(),

                  const SizedBox(height: 20),

                  // Form sections
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        DisputeCategoryWidget(),
                        SizedBox(height: 16),
                        JobReferenceWidget(),
                        SizedBox(height: 16),
                        ReasonWidget(),
                        SizedBox(height: 16),
                        FileUploadWidget(),
                        SizedBox(height: 100), // Space for bottom button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed bottom submit button
          if (!isKeyboardOpen) const SubmitButtonWidget(),
        ],
      ),
    );
  }
}

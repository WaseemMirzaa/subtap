part of 'pages.dart';

class SubcontractorMyaccountPage extends StatelessWidget {
  const SubcontractorMyaccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return SubtapScaffold(
      appBar: const MyAccountAppbar(),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: isKeyboardOpen
                  ? MediaQuery.of(context).viewInsets.bottom + 95
                  : 95, // Add padding for the bottom button
            ),
            child: Padding(
              padding: kHV20,
              child: Column(
                spacing: 10,
                children: [
                  // Profile Avatar
                  Center(
                    child: CustomCircleAvatar(
                      radius: 50,
                      hasBorder: false,
                      child: Image(
                        image: const AssetImage(Assets.imagesAvatarImage),
                        width: context.width,
                        height: context.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // First Name Field
                  const TextFieldCustom(
                    prefixLabel: 'First Name',
                    initialValue: 'Sophia',
                    textColor: AppColor.black,
                    fillColor: Colors.white,
                    borderColor: AppColor.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),

                  // Last Name Field
                  const TextFieldCustom(
                    prefixLabel: 'Last Name',
                    initialValue: 'Anderson',
                    fillColor: Colors.white,
                    borderColor: AppColor.white,
                    textColor: AppColor.black,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),

                  // Email Field
                  const TextFieldCustom(
                    prefixLabel: 'Email',
                    initialValue: 'sophiaanderson@info.com',
                    textColor: AppColor.black,
                    fillColor: Colors.white,
                    borderColor: AppColor.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // Phone Field
                  const TextFieldCustom(
                    prefixLabel: 'Phone',
                    initialValue: '+9876543210',
                    textColor: AppColor.black,
                    fillColor: Colors.white,
                    borderColor: AppColor.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    keyboardType: TextInputType.phone,
                  ),

                  // Address Field
                  const TextFieldCustom(
                    prefixLabel: 'Address',
                    initialValue: '123 Maple Sreet, Unit 4B, SpringField',
                    textColor: AppColor.black,
                    fillColor: Colors.white,
                    borderColor: AppColor.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    maxLines: 1,
                  ),
                  // Replace Spacer with fixed height
                ],
              ),
            ),
          ),
          // Bottom button
          if (!isKeyboardOpen)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 95,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Update Profile',
                        onTap: () {
                          Get.back();
                        },
                        color: AppColor.mutedGold,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w400,
                        radius: 17,
                      ),
                    ),
                    kGap10,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

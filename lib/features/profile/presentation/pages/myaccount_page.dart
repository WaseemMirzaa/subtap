part of 'pages.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const MyAccountAppbar(),
      body: Stack(
        children: [
          Padding(
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
                const Spacer(),
                // Removed the Update Profile button
                const SizedBox(height: 95), // Add space for the bottom button
              ],
            ),
          ),
          // Bottom button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 95,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      onTap: () {},
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

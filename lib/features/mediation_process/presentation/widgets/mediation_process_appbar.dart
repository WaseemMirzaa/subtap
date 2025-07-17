part of 'widgets.dart';

class MediationProcessAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const MediationProcessAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MediationProcessPageController>();

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 140,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColor.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: Container(
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Center(
                  child: CustomText(
                    text: 'Add Mediation',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => controller.jobTitle.value.isNotEmpty
                    ? CustomText(
                        text: 'Job: ${controller.jobTitle.value}',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white.withOpacity(0.8),
                      )
                    : const SizedBox.shrink()),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(
                    text:
                        'Use this form to request mediation. Our team will review in 24–48 hours.',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}

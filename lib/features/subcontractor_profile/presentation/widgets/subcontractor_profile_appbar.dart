part of 'widgets.dart';

class SubcontractorProfileAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(bool) onViewChanged;

  const SubcontractorProfileAppbar({
    super.key,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double avatarRadius = size.width * 0.14;
    final double avatarImageSize = avatarRadius * 2;

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 335,
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(width: 25),
                        const Expanded(
                          child: Center(
                            child: CustomText(
                              text: 'Profile',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.onboarding);
                            },
                            child: SvgPicture.asset(
                              Assets.svgsExitDoor,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kGap25,
                CustomCircleAvatar(
                  radius: avatarRadius,
                  child: Image(
                    image: const AssetImage(Assets.imagesAvatarImage),
                    width: avatarImageSize,
                    height: avatarImageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                kGap20,
                const CustomText(
                  text: 'Sophia Anderson',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                const CustomText(
                  text: '@Sophiaanderson',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                const SizedBox(height: 12),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 2,
                ),
                const SizedBox(height: 12),
                _IconRow(onViewChanged: onViewChanged),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(335);
}

class _IconRow extends StatefulWidget {
  final Function(bool) onViewChanged;

  const _IconRow({
    required this.onViewChanged,
  });

  @override
  _IconRowState createState() => _IconRowState();
}

class _IconRowState extends State<_IconRow> {
  bool _isChatIconTapped = true;
  bool _isPortfolioIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isChatIconTapped = true;
              _isPortfolioIconTapped = false;
            });
            widget.onViewChanged(false);
          },
          child: SvgPicture.asset(
            Assets.svgsChati,
            width: 20,
            height: 20,
            color: _isChatIconTapped ? AppColor.mutedGold : null,
          ),
        ),
        const SizedBox(width: 70),
        const SizedBox(
          height: 25,
          child: VerticalDivider(
            color: Colors.black,
            thickness: 2,
          ),
        ),
        const SizedBox(width: 70),
        InkWell(
          onTap: () {
            setState(() {
              _isChatIconTapped = false;
              _isPortfolioIconTapped = true;
            });
            widget.onViewChanged(true);
          },
          child: SvgPicture.asset(
            Assets.svgsPortfolio,
            width: 20,
            height: 20,
            color: _isPortfolioIconTapped ? AppColor.mutedGold : null,
          ),
        ),
      ],
    );
  }
}

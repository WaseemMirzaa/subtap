part of 'widgets.dart';

class FavSubcontractorProfileAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const FavSubcontractorProfileAppbar(
      {super.key,
      required this.onViewChanged,
      this.subcontractorData,
      required this.showPortfolio,
      required this.fromSubcontractorsPage});

  final bool fromSubcontractorsPage;
  final Function(bool) onViewChanged;
  final bool showPortfolio;
  final Map<String, dynamic>? subcontractorData;

  @override
  Size get preferredSize => const Size.fromHeight(349);

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
                  padding: const EdgeInsets.only(top: 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: AppColor.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
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
                        const SizedBox(
                            width:
                                48), // This creates balance with the back button
                      ],
                    ),
                  ),
                ),
                kGap20,
                CustomCircleAvatar(
                  radius: avatarRadius,
                  child: Image(
                    image: AssetImage(
                      subcontractorData?['avatarImage'] ??
                          Assets.imagesAvatarImage,
                    ),
                    width: avatarImageSize,
                    height: avatarImageSize,
                    fit: BoxFit.cover,
                  ),
                ),
                kGap20,
                CustomText(
                  text: subcontractorData?['name'] ?? 'Sophia Anderson',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                // CustomText(
                //   text:
                //       '@${subcontractorData?['name']?.replaceAll(' ', '').toLowerCase() ?? 'sophiaanderson'}',
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   color: AppColor.white,
                // ),
                const SizedBox(height: 8),
                CustomText(
                  text: (fromSubcontractorsPage
                      ? (subcontractorData?['expertise'] ??
                          'No expertise available')
                      : (subcontractorData?['description'] ??
                          'No description available')),
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
}

class _IconRow extends StatefulWidget {
  const _IconRow({
    required this.onViewChanged,
  });

  final Function(bool) onViewChanged;

  @override
  _IconRowState createState() => _IconRowState();
}

class _IconRowState extends State<_IconRow> {
  bool _isChatIconTapped = false;
  bool _isPortfolioIconTapped = true;

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
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

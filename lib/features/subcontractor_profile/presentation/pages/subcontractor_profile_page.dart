part of 'pages.dart';

class SubcontractorProfilePage extends StatefulWidget {
  const SubcontractorProfilePage({super.key});

  @override
  State<SubcontractorProfilePage> createState() =>
      _SubcontractorProfilePageState();
}

class _SubcontractorProfilePageState extends State<SubcontractorProfilePage> {
  final List<Map<String, dynamic>> profileOptions = [
    {
      'title': 'My Account',
      'icon': Assets.svgsMyaccount,
      'route': AppRoutes.subcontractorMyAccountPage,
    },
    {
      'title': 'My Support Requests',
      'icon': Assets.svgsToDoList,
      'route': AppRoutes.supportRequests,
    },
    {
      'title': 'Notifications Preferences',
      'icon': Assets.svgsMyaccountNotification,
      'route': AppRoutes.subcontractornotificationPage,
    },
    {
      'title': 'Change Password',
      'icon': Assets.svgsMyaccountChangepass,
      'route': AppRoutes.changePassword,
    },
    {
      'title': 'Profile Visibility',
      'icon': Assets.svgsVisibility, // You'll need this icon
      'isToggle': true,
    },
    {
      'title': 'Switch Roles',
      'icon': Assets.svgsSwitch, // You'll need this icon
      'route': AppRoutes.selectRole,
    },
    {
      'title': 'Terms & Conditions',
      'icon': Assets.svgsTerms,
      // 'route': AppRoutes.termsAndConditions,
    },
    {
      'title': 'Payout Settings',
      'icon': Assets.svgsPayout,
      // 'route': AppRoutes.payoutSettings,
    },
    {
      'title': 'Verification Status',
      'icon': Assets.svgsVerification,
      // 'route': AppRoutes.verificationStatus,
    },
    {
      'title': 'Delete Account',
      'icon': Assets.svgsAccountDelete,
      // 'route': AppRoutes.deleteAccount,
    },
  ];

  bool _showPortfolio = false;
  bool _profileVisible = false;

  void _handleOptionTap(BuildContext context, Map<String, dynamic> option) {
    final String? route = option['route'];
    if (route != null) {
      Navigator.pushNamed(context, route);
    }
  }

  void _togglePortfolioView(bool showPortfolio) {
    setState(() {
      _showPortfolio = showPortfolio;
    });
  }

  void _uploadPortfolio() {
    // Implement upload functionality
    debugPrint('Upload portfolio tapped');
  }

  void _handlePortfolioItemTap(int index) {
    // Handle individual portfolio item tap
    debugPrint('Portfolio item $index tapped');
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: SubcontractorProfileAppbar(
        onViewChanged: _togglePortfolioView,
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _showPortfolio ? _buildPortfolioView() : _buildProfileOptions(),
          ),
          if (_showPortfolio) _buildUploadButton(),
        ],
      ),
    );
  }

  Widget _buildProfileOptions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: profileOptions.length,
            itemBuilder: (context, index) {
              final option = profileOptions[index];
              final isToggle = option['isToggle'] ?? false;
              if (isToggle && option['title'] == 'Profile Visibility') {
                // Simple toggle for Profile Visibility
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColor.customOffWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              option['icon'],
                              width: 18,
                              height: 19,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomText(
                            text: option['title'],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        Switch(
                          value: _profileVisible,
                          onChanged: (value) {
                            setState(() {
                              _profileVisible = value;
                            });
                          },
                          activeColor: AppColor.mutedGold,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Regular ProfileCard for other options
                return SubcontractorProfileCard(
                  title: option['title'],
                  svgAsset: option['icon'],
                  onTap: () => _handleOptionTap(context, option),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _buildPortfolioGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 18,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => _handlePortfolioItemTap(index),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage(Assets.imagesPortfolio),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      color: Colors.transparent, // Ensures no white background
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: CustomButton(
        radius: 14,
        text: 'Tap to Upload Portfolio',
        onTap: _uploadPortfolio,
        width: double.infinity,
        color: AppColor.mutedGold,
        textColor: Colors.white,
      ),
    );
  }
}

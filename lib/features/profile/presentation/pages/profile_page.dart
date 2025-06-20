part of 'pages.dart';

class ProfileScreen extends StatelessWidget {
  final List<Map<String, dynamic>> profileOptions = [
    {
      'title': 'My Account',
      'icon': Assets.svgsMyaccount,
      'route': AppRoutes.myAccountPage,
    },
    {
      'title': 'Notifications',
      'icon': Assets.svgsMyaccountNotification,
      'route': AppRoutes.notificationPage,
    },
    {
      'title': 'Change Password',
      'icon': Assets.svgsMyaccountChangepass,
      // 'route': AppRoutes.transactionHistory,
    },
  ];

  ProfileScreen({super.key});
  void _handleOptionTap(BuildContext context, Map<String, dynamic> option) {
    final String? route = option['route'];
    if (route != null) {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: const ProfileAppBar(),
      body: Column(
        children: [
          Expanded(
            // Takes remaining space
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileOptions.length,
                    itemBuilder: (context, index) {
                      final option = profileOptions[index];
                      return ProfileCard(
                        title: option['title'],
                        svgAsset: option['icon'],
                        onTap: () => _handleOptionTap(context, option),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Logout button at the bottom
        ],
      ),
    );
  }
}

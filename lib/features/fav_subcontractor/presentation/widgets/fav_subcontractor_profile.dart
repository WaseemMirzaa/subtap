part of 'widgets.dart';

class FavSubcontractorProfile extends StatefulWidget {
  const FavSubcontractorProfile({super.key});

  @override
  State<FavSubcontractorProfile> createState() =>
      _FavSubcontractorProfileState();
}

class _FavSubcontractorProfileState extends State<FavSubcontractorProfile> {
  bool _showPortfolio = true;
  Map<String, dynamic>? subcontractorData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        subcontractorData = Get.arguments?['subcontractor'];
      });
    });
  }

  void _togglePortfolioView(bool showPortfolio) {
    setState(() {
      _showPortfolio = showPortfolio;
    });
  }

  void _hireForJob() {
    final bool fromJobHistory = Get.arguments?['fromJobHistory'] ?? false;
    if (fromJobHistory) {
      // Navigate to JobHistoryPage with Active Jobs tab selected
      Get.offAllNamed(AppRoutes.jobHistory,
          arguments: {'selectedTab': 'Active Jobs'});
      Get.snackbar('Success', 'Offer accepted', backgroundColor: Colors.green);
    } else {
      if (subcontractorData != null) {
        Get.toNamed(
          AppRoutes.jobRequest,
          arguments: {
            'initialTitle': subcontractorData!['expertise'], // Use expertise
            'subcontractor': subcontractorData,
          },
        );
      } else {
        debugPrint('Subcontractor data is null');
      }
    }
  }

  void _handlePortfolioItemTap(int index) {
    debugPrint('Portfolio item $index tapped');
  }

  @override
  Widget build(BuildContext context) {
    subcontractorData ??= Get.arguments?['subcontractor'];

    return SubtapScaffold(
      appBar: FavSubcontractorProfileAppbar(
        onViewChanged: _togglePortfolioView,
        subcontractorData: subcontractorData,
        showPortfolio: _showPortfolio,
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _showPortfolio ? _buildPortfolioView() : _buildFeedbackView(),
          ),
          if (!(Get.arguments?['fromSubcontractorsPage'] ?? false))
            _buildHireButton(),
        ],
      ),
    );
  }

  Widget _buildFeedbackView() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 21,
                ignoreGestures: true,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColor.vibrantYellow,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 10),
              const Text(
                "He always gives a perfect service. Great attention to detail and awesome "
                "service every time. Highly recommended!",
                style: TextStyle(
                  fontFamily: 'openSans',
                  fontSize: 12,
                  color: AppColor.midGray,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Jason Rao",
                style: TextStyle(
                  fontFamily: 'openSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
        ),
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

  Widget _buildHireButton() {
    final bool fromJobHistory = Get.arguments?['fromJobHistory'] ?? false;
    return Container(
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
              text: fromJobHistory ? 'Accept Offer' : 'Hire for a Job',
              onTap: _hireForJob,
              color: AppColor.mutedGold,
              textColor: Colors.white,
              fontWeight: FontWeight.w400,
              radius: 17,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

part of 'pages.dart';

class SummaryDetailPage extends StatelessWidget {
  const SummaryDetailPage({super.key});

  // Sample data for categories (same as SummaryCard)
  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Assets.svgsGeneral,
      'label': 'General Handyman',
      'price': '\$1,200',
      'color': AppColor.mutedGold,
      'description':
          'General handyman services include a wide range of home repairs and maintenance tasks, such as fixing drywall, painting, and minor carpentry.',
    },
    {
      'icon': Assets.svgsPlumbing,
      'label': 'Plumbing',
      'price': '\$800',
      'color': AppColor.darkBlueShade,
      'description':
          'Plumbing services cover installation, repair, and maintenance of pipes, fixtures, and other plumbing systems.',
    },
    {
      'icon': Assets.svgsElectrical,
      'label': 'Electrical',
      'price': '\$1,000',
      'color': AppColor.orangeColor,
      'description':
          'Electrical services include wiring, lighting installation, and repair of electrical systems for safety and functionality.',
    },
    {
      'icon': Assets.svgsRoofing,
      'label': 'Roofing',
      'price': '\$1,200',
      'color': AppColor.navyBlue,
      'description':
          'Roofing services involve the installation, repair, and maintenance of roofs to protect buildings from weather elements.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const SummaryDetailAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Fiscal Summary Details',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
            kGap20,
            ...categories.map((category) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCategoryCard(
                    icon: category['icon'],
                    label: category['label'],
                    price: category['price'],
                    color: category['color'],
                    description: category['description'],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String icon,
    required String label,
    required String price,
    required Color color,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, width: 24, height: 24),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: label,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          kGap10,
          CustomText(
            text: 'Price: $price',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.mutedGold,
          ),
          kGap10,
          CustomText(
            text: description,
            fontSize: 13,
            maxLines: 3,
            color: AppColor.midGray,
          ),
        ],
      ),
    );
  }
}

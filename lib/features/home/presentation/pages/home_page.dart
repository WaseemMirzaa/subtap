part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const HomeAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Space for app bar
                const CustomText(
                  text: 'Job Status',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                kGap10,
                const JobStatusCard(
                  firstTitle: 'Open',
                  firstValue: '03',
                  secondTitle: 'Awaiting',
                  secondValue: 'Bids',
                  thirdTitle: 'In Progress',
                  thirdValue: '27',
                ),
                kGap20,
                const CustomText(
                  text: 'Fiscal Summary',
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                kGap10,
                const SummaryCard(),
                kGap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Favorites',
                      color: AppColor.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const CustomText(
                        text: 'View All',
                        color: AppColor.mutedGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    )
                  ],
                ),
                kGap10,
                const FavouritesCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

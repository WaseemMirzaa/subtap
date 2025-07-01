part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get the HomeController instance
  final HomePageController homeController = Get.put(HomePageController());

  // Function to pick a date
  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? homeController.startDate.value
          : homeController.endDate.value,
      firstDate: isStartDate ? DateTime(2000) : homeController.startDate.value,
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isStartDate) {
        homeController.updateStartDate(picked);
        // If new start date is after current end date, update end date too
        if (picked.isAfter(homeController.endDate.value)) {
          homeController.updateEndDate(picked);
        }
      } else {
        homeController.updateEndDate(picked);
      }
    }
  }

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
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _pickDate(context, true); // Pick start date
                            await _pickDate(context, false); // Pick end date
                          },
                          child: const Icon(
                            Icons.calendar_today,
                            color: AppColor.black,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Start: ${homeController.formattedStartDate}',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'End: ${homeController.formattedEndDate}',
                          style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                kGap10,
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.summaryDetailPage);
                  },
                  child: const SummaryCard(),
                ),
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
                      onPressed: () {
                        Get.toNamed(AppRoutes.favoritesSubcontractor);
                      },
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

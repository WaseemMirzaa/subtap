part of 'widget.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          // Top row with amount and chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Amount and Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: '\$4200',
                      fontSize: 26,
                      color: AppColor.mutedGold,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 8),
                    const CustomText(
                      text: 'This Month',
                      fontSize: 12,
                      color: AppColor.midGray,
                    ),
                    const SizedBox(height: 16),
                    // Legend items (without values)
                    _buildLegendItem(
                      icon: Assets.svgsGeneral,
                      label: 'General Handyman',
                      color: AppColor.mutedGold,
                    ),
                    _buildLegendItem(
                      icon: Assets.svgsPlumbing,
                      label: 'Plumbing',
                      color: AppColor.darkBlueShade,
                    ),
                    _buildLegendItem(
                      icon: Assets.svgsElectrical,
                      label: 'Electrical',
                      color: AppColor.orangeColor,
                    ),
                    _buildLegendItem(
                      icon: Assets.svgsRoofing,
                      label: 'Roofing',
                      color: AppColor.navyBlue,
                    ),
                  ],
                ),
              ),

              // Right side - Chart and Values
              Column(
                children: [
                  // Chart
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: SfCircularChart(
                      margin: EdgeInsets.zero,
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: [
                            ChartData(
                                'General Handyman', 1200, AppColor.mutedGold),
                            ChartData('Plumbing', 800, AppColor.darkBlueShade),
                            ChartData('Electrical', 1000, AppColor.orangeColor),
                            ChartData('Roofing', 1200, AppColor.navyBlue),
                          ],
                          xValueMapper: (ChartData data, _) => data.category,
                          yValueMapper: (ChartData data, _) => data.value,
                          pointColorMapper: (ChartData data, _) => data.color,
                          innerRadius: '70%',
                          radius: '100%',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Values under chart
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildValueText('\$1,200'),
                      const SizedBox(height: 12),
                      _buildValueText('\$800'),
                      const SizedBox(height: 12),
                      _buildValueText('\$1,000'),
                      const SizedBox(height: 12),
                      _buildValueText('\$1,200'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 16, height: 16),
          const SizedBox(width: 8),
          CustomText(
            text: label,
            fontSize: 13,
            color: AppColor.midGray,
          ),
          const SizedBox(width: 8),
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueText(String value) {
    return CustomText(
      text: value,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColor.black,
    );
  }
}

class ChartData {
  final String category;
  final num value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

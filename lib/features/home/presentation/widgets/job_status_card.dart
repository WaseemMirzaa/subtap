part of 'widget.dart';

class JobStatusCard extends StatelessWidget {
  final String firstTitle;
  final String firstValue;
  final String secondTitle;
  final String secondValue;
  final String thirdTitle;
  final String thirdValue;
  final String? fourthTitle;
  final String? fourthValue;

  const JobStatusCard({
    super.key,
    required this.firstTitle,
    required this.firstValue,
    required this.secondTitle,
    required this.secondValue,
    required this.thirdTitle,
    required this.thirdValue,
    this.fourthTitle,
    this.fourthValue,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildStatusColumn(firstTitle, firstValue),
      _buildDivider(),
      _buildStatusColumn(secondTitle, secondValue),
      _buildDivider(),
      _buildStatusColumn(thirdTitle, thirdValue),
    ];

    if (fourthTitle != null && fourthValue != null) {
      children.add(_buildDivider());
      children.add(_buildStatusColumn(fourthTitle!, fourthValue!));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(27, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  Widget _buildStatusColumn(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColor.black,
            fontSize: 12,
            fontFamily: 'HelveticaNeueMedium',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.midGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'HelveticaNeueMedium',
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 37,
      width: 2,
      color: Colors.grey[300],
    );
  }
}

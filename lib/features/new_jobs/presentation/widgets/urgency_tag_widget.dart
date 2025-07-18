part of 'widgets.dart';

class UrgencyTagWidget extends StatelessWidget {
  final String? tag;

  const UrgencyTagWidget({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    if (tag == null || tag!.isEmpty) return const SizedBox.shrink();

    final tagData = _getTagData(tag!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tagData['color'],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tagData['text'],
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: tagData['textColor'],
          fontFamily: 'HelveticaNeueMedium',
        ),
      ),
    );
  }

  Map<String, dynamic> _getTagData(String tag) {
    switch (tag.toLowerCase()) {
      case 'urgent':
        return {
          'text': 'URGENT',
          'color': Colors.red.withOpacity(0.1),
          'textColor': Colors.red,
        };
      case 'expiring soon':
        return {
          'text': 'EXPIRING SOON',
          'color': Colors.orange.withOpacity(0.1),
          'textColor': Colors.orange,
        };
      case 'new':
        return {
          'text': 'NEW',
          'color': Colors.green.withOpacity(0.1),
          'textColor': Colors.green,
        };
      case 'expired':
        return {
          'text': 'EXPIRED',
          'color': Colors.grey.withOpacity(0.1),
          'textColor': Colors.grey,
        };
      default:
        return {
          'text': tag.toUpperCase(),
          'color': AppColor.lightGray,
          'textColor': AppColor.midGray,
        };
    }
  }
}
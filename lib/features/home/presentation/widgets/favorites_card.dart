part of 'widget.dart';

class FavouritesCard extends StatelessWidget {
  const FavouritesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to top
        children: [
          // Left side - Avatar
          const CustomCircleAvatar(
            radius: 24,
            child: Image(
              image: AssetImage(Assets.imagesHomePerson),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Center - Name and Profession
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // New Row to align name and favorite icon
                  children: [
                    const Expanded(
                      child: CustomText(
                        text: 'Michael Thompson',
                        fontSize: 16,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      Assets.svgsFavorite,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const CustomText(
                  text: 'General Handyman',
                  fontSize: 13,
                  color: AppColor.midGray,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

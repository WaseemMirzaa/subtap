part of 'pages.dart';

class JobPostPage extends StatelessWidget {
  const JobPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      isAppBar: true,
      appBarSecond: const JobPostAppBar(),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: listCate.length,
          itemBuilder: (_, index) {
            var e = listCate[index];
            return ExpansionTile(
              collapsedIconColor: AppColor.midGray,
              initiallyExpanded: true,
              iconColor: AppColor.midGray,
              tilePadding: const EdgeInsets.only(left: 16),
              collapsedShape:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              shape: const OutlineInputBorder(borderSide: BorderSide.none),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              title: CustomText(
                text: e.title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              leading: SvgPicture.asset(e.svg),
              children: e.subCat.map((sub) {
                return InkWell(
                  onTap: () {
                    // Pass the selected subcategory text to JobRequestPage
                    Get.toNamed(
                      AppRoutes.jobRequest,
                      arguments: {'initialTitle': sub['text']!},
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        SvgPicture.asset(sub['svg']!),
                        CustomText(
                          text: sub['text']!,
                          fontSize: 15,
                          color: AppColor.midGray,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

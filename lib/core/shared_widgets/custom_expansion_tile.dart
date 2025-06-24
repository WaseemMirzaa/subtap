import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';

class CustomExpansionTile extends StatefulWidget {
  final String svgAsset;
  final String title;
  final List<SubCategory> subCategories;

  const CustomExpansionTile({
    required this.svgAsset,
    required this.title,
    required this.subCategories,
    Key? key,
  }) : super(key: key);

  @override
  CustomExpansionTileState createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header (always visible)
        ListTile(
          leading: SvgPicture.asset(
            widget.svgAsset,
            width: 19.45,
            height: 17,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.black, // Replace with AppColor.black
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.black, // Replace with AppColor.black
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),

        // Subcategories (visible when expanded)
        if (_isExpanded)
          Column(
            children: widget.subCategories.map((subCategory) {
              return Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    subCategory.svgAsset,
                    width: 16,
                    height: 16,
                  ),
                  title: Text(
                    subCategory.title,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColor.midGray, // Replace with AppColor.midGrey
                    ),
                  ),
                  onTap: subCategory.onTap,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

// Model for subcategories
class SubCategory {
  final String svgAsset;
  final String title;
  final VoidCallback? onTap;

  SubCategory({
    required this.svgAsset,
    required this.title,
    this.onTap,
  });
}

class JobCategoriesModel {
  final String title;
  final String svg;
  final List<Map<String, String>> subCat;

  JobCategoriesModel(
      {required this.subCat, required this.svg, required this.title});
}

List<JobCategoriesModel> listCate = [
  JobCategoriesModel(subCat: [
    {
      "svg": Assets.svgsGeneral,
      "text": "General Handyman",
    },
    {
      "svg": Assets.svgsCarpentar,
      "text": "Carpentry & Framing",
    },
    {
      "svg": Assets.svgsDrywall,
      "text": "Drywall & Finishing",
    },
    {
      "svg": Assets.svgsPainting,
      "text": "Painting",
    }
  ], svg: Assets.svgsTrade, title: "General Trades"),
  JobCategoriesModel(subCat: [
    {
      "svg": Assets.svgsPlumbing,
      "text": "Plumbing",
    },
    {
      "svg": Assets.svgsHvac,
      "text": "HVAC (Heating, Ventilation, AC)",
    },
    {
      "svg": Assets.svgsGasLine,
      "text": "Gas Line Services",
    }
  ], svg: Assets.svgsMechinal, title: "Plumbing & Mechanical"),
  JobCategoriesModel(subCat: [
    {
      "svg": Assets.svgsElectrical,
      "text": "Electrical",
    },
    {
      "svg": Assets.svgsLowVoltage,
      "text": "Low Voltage / Data Cabling",
    },
    {
      "svg": Assets.svgsSecuritySystem,
      "text": "Security System Install",
    }
  ], svg: Assets.svgsTech, title: "Electrical & Tech"),
  JobCategoriesModel(subCat: [
    {
      "svg": Assets.svgsRoofing,
      "text": "Roofing",
    },
    {
      "svg": Assets.svgsConcerete,
      "text": "Concrete / Masonry",
    },
    {
      "svg": Assets.svgsFencing,
      "text": "Fencing",
    },
    {
      "svg": Assets.svgsWindow,
      "text": "Window & Door Install",
    },
    {
      "svg": Assets.svgsGarage,
      "text": "Garage Door Services",
    },
  ], svg: Assets.svgsExteriorTrades, title: "Exterior Trades")
];

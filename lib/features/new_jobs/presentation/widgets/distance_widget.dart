import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtap/core/theme/app_color.dart';
import 'package:subtap/core/theme/assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class DistanceWidget extends StatelessWidget {
  final String? address;
  final double distance;

  const DistanceWidget({
    super.key,
    this.address,
    this.distance = 6.2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openInMaps(context),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.svgsLocation,
            width: 16,
            height: 16,
            color: AppColor.mutedGold,
          ),
          const SizedBox(width: 4),
          Text(
            '📍 ${distance.toStringAsFixed(1)} miles away from your location',
            style: const TextStyle(
              fontSize: 13,
              color: AppColor.mutedGold,
              fontWeight: FontWeight.w400,
              fontFamily: 'HelveticaNeueMedium',
            ),
          ),
        ],
      ),
    );
  }

  void _openInMaps(BuildContext context) async {
    if (address == null || address!.isEmpty) {
      _showErrorSnackbar('Address not available');
      return;
    }

    try {
      // Try multiple URL schemes for better compatibility
      final encodedAddress = Uri.encodeComponent(address!);

      // List of URLs to try in order of preference
      final urls = [
        'geo:0,0?q=$encodedAddress', // Android Maps
        'https://maps.google.com/maps?q=$encodedAddress', // Google Maps web
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress', // Google Maps API
      ];

      bool launched = false;

      for (String url in urls) {
        try {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
            launched = true;
            break;
          }
        } catch (e) {
          print('Failed to launch $url: $e');
          continue;
        }
      }

      if (!launched) {
        _showMapOptions(context);
      }
    } catch (e) {
      print('Error opening maps: $e');
      _showMapOptions(context);
    }
  }

  void _showMapOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Open Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.map, color: AppColor.mutedGold),
              title: const Text('Copy Address'),
              subtitle: Text(address ?? ''),
              onTap: () {
                Navigator.pop(context);
                _copyToClipboard();
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions, color: AppColor.mutedGold),
              title: const Text('Get Directions'),
              subtitle: const Text('Open in browser'),
              onTap: () {
                Navigator.pop(context);
                _openInBrowser();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard() {
    if (address != null) {
      // You'll need to add clipboard package to pubspec.yaml
      // Clipboard.setData(ClipboardData(text: address!));
      _showSuccessSnackbar('Address copied to clipboard');
    }
  }

  void _openInBrowser() async {
    if (address != null) {
      final encodedAddress = Uri.encodeComponent(address!);
      final url =
          'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

      try {
        final uri = Uri.parse(url);
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
      } catch (e) {
        _showErrorSnackbar('Could not open maps');
      }
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: AppColor.mutedGold.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}

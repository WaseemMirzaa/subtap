import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';
import 'package:subtap/features/property_manager_profile/presentation/widgets/property_manager_profile_appbar.dart';
import 'package:subtap/models/models.dart';
import 'package:subtap/core/theme/app_color.dart';

class PropertyManagerProfilePage extends StatefulWidget {
  const PropertyManagerProfilePage({super.key});

  @override
  State<PropertyManagerProfilePage> createState() =>
      _PropertyManagerProfilePageState();
}

class _PropertyManagerProfilePageState
    extends State<PropertyManagerProfilePage> {
  late PropertyManagerModel propertyManager;
  bool _showJobs = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    propertyManager = args?['propertyManager'] as PropertyManagerModel;
  }

  void _toggleView(bool showJobs) {
    setState(() {
      _showJobs = showJobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubtapScaffold(
      appBar: PropertyManagerProfileAppbar(
        propertyManager: propertyManager,
        onViewChanged: _toggleView,
      ),
      body: Column(
        children: [
          Expanded(
            child: _showJobs ? _buildJobsView() : _buildProfileView(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Section
          CustomText(
            text: 'About ${propertyManager.name}',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const CustomText(
              text:
                  'Experienced property manager with over 8 years in the industry. Specializing in residential and commercial property management, maintenance coordination, and tenant relations. Committed to providing exceptional service and maintaining properties to the highest standards.',
              fontSize: 14,
              maxLines: 8,
              color: AppColor.midGray,
            ),
          ),
          const SizedBox(height: 24),

          // Contact Information
          const CustomText(
            text: 'Contact Information',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle:
                '${propertyManager.name.toLowerCase().replaceAll(' ', '.')}@example.com',
          ),
          _buildContactItem(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle: '+1 (555) 123-4567',
          ),
          _buildContactItem(
            icon: Icons.location_on_outlined,
            title: 'Location',
            subtitle: 'New York, NY',
          ),
          const SizedBox(height: 24),

          // Services Offered
          const CustomText(
            text: 'Services Offered',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          _buildServiceChips(),
          const SizedBox(height: 24),

          // Statistics
          const CustomText(
            text: 'Statistics',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          _buildStatistics(),
          const SizedBox(height: 24),

          // Availability
          const Text(
            'Availability',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 8),
                CustomText(
                  text: 'Available for new projects',
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Jobs Posted by ${propertyManager.name}',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),
          // Mock job listings
          _buildJobCard(
            title: 'Apartment Maintenance - Kitchen Repair',
            description:
                'Need immediate repair of kitchen sink and cabinet doors in unit 3B.',
            price: '\$250',
            location: 'Manhattan, NY',
            postedTime: '2 hours ago',
            isUrgent: true,
          ),
          _buildJobCard(
            title: 'Bathroom Renovation',
            description:
                'Complete bathroom renovation required for rental property.',
            price: '\$1,200',
            location: 'Brooklyn, NY',
            postedTime: '1 day ago',
            isUrgent: false,
          ),
          _buildJobCard(
            title: 'HVAC System Maintenance',
            description:
                'Routine maintenance and cleaning of HVAC system for office building.',
            price: '\$400',
            location: 'Queens, NY',
            postedTime: '3 days ago',
            isUrgent: false,
          ),
          _buildJobCard(
            title: 'Emergency Plumbing Repair',
            description:
                'Urgent plumbing issue in basement - water leak needs immediate attention.',
            price: '\$350',
            location: 'Manhattan, NY',
            postedTime: '5 days ago',
            isUrgent: true,
          ),
          _buildJobCard(
            title: 'Electrical Wiring Update',
            description:
                'Update electrical wiring in 2-bedroom apartment for safety compliance.',
            price: '\$800',
            location: 'Bronx, NY',
            postedTime: '1 week ago',
            isUrgent: false,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.mutedGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColor.mutedGold),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChips() {
    final services = [
      'Property Maintenance',
      'Tenant Management',
      'Emergency Repairs',
      'Renovations',
      'Cleaning Services',
      'Security Systems',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: services.map((service) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.mutedGold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.mutedGold.withOpacity(0.3)),
          ),
          child: Text(
            service,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.mutedGold,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Jobs',
            value: '${propertyManager.totalJobs}',
            icon: Icons.work_outline,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Rating',
            value: '${propertyManager.rating}',
            icon: Icons.star_outline,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Response Time',
            value: '< 2h',
            icon: Icons.access_time,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColor.mutedGold),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({
    required String title,
    required String description,
    required String price,
    required String location,
    required String postedTime,
    required bool isUrgent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (isUrgent)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'URGENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mutedGold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 14, color: Colors.black54),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    postedTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

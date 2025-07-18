part of 'widgets.dart';

class ImprovedJobCard extends StatefulWidget {
  final JobHistory job;
  final VoidCallback? onTap;
  final VoidCallback? onAcceptJob;
  final VoidCallback? onNotInterested;
  final VoidCallback? onBookmark;
  final VoidCallback? onReport;
  final bool isBookmarked;

  const ImprovedJobCard({
    super.key,
    required this.job,
    this.onTap,
    this.onAcceptJob,
    this.onNotInterested,
    this.onBookmark,
    this.onReport,
    this.isBookmarked = false,
  });

  @override
  State<ImprovedJobCard> createState() => _ImprovedJobCardState();
}

class _ImprovedJobCardState extends State<ImprovedJobCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) {
              _animationController.reverse();
              widget.onTap?.call();
            },
            onTapCancel: () => _animationController.reverse(),
            child: Container(
              margin: const EdgeInsets.only(
                  bottom: 20,
                  left: 8,
                  right: 2), // Increased horizontal margin for wider card
              padding:
                  const EdgeInsets.all(20), // Increased padding for more width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildJobDetails(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.offWhite,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.asset(
              widget.job.svgIcon ?? '',
              width: 28,
              height: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.job.title ?? 'No Title',
                      style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600, // Increased weight
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Urgency tag instead of hourglass
                  if (widget.job.urgencyTag != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getUrgencyColor(widget.job.urgencyTag!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.job.urgencyTag!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              // Trade sublabel
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsGeneral,
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.job.trade ?? 'General Trade',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColor.midGray,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: widget.onBookmark,
          child: Icon(
            widget.isBookmarked
                ? Icons.bookmark
                : Icons.bookmark_border_outlined,
            color: widget.isBookmarked ? AppColor.mutedGold : AppColor.midGray,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildJobDetails() {
    return Column(
      children: [
        // Budget Row - Enhanced formatting with payment type
        Row(
          children: [
            SvgPicture.asset(Assets.svgsTargetBudget, width: 16, height: 16),
            const SizedBox(width: 6),
            Expanded(
              // Wrap in Expanded to prevent overflow
              child: RichText(
                overflow: TextOverflow.ellipsis, // Handle overflow
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Budget: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                    TextSpan(
                      text: widget.job.targetBudget ?? '\$0',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColor.mutedGold,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'HelveticaNeueMedium',
                      ),
                    ),
                    if (widget.job.paymentType != null) ...[
                      TextSpan(
                        text: ' ${widget.job.paymentType}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.midGray,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'HelveticaNeueMedium',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8), // Add spacing before badge
            // Estimated hours badge - ⏱ Est. Time Req.
            if (widget.job.estimatedHours != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.lightGray,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.job.estimatedHours!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColor.midGray,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'HelveticaNeueMedium',
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),

        // Location Row - City + ZIP only
        Row(
          children: [
            SvgPicture.asset(Assets.svgsLocation, width: 16, height: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                widget.job.address ?? 'Location TBD',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColor.midGray,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Property Manager Rating - ⭐ PM Rating
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage:
                  AssetImage(widget.job.propertyManager?.imageUrl ?? ''),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Rated ${widget.job.propertyManager?.rating?.toStringAsFixed(1) ?? '0.0'} ★ by ${widget.job.propertyManager?.totalJobs ?? 0} subcontractors',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.midGray,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'HelveticaNeueMedium',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Posted X Days Ago - 📅 Job freshness
        Row(
          children: [
            const Icon(Icons.schedule_outlined,
                size: 16, color: AppColor.midGray),
            const SizedBox(width: 6),
            Text(
              _getPostedTimeAgo(),
              style: const TextStyle(
                fontSize: 12,
                color: AppColor.midGray,
                fontWeight: FontWeight.w400,
                fontFamily: 'HelveticaNeueMedium',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getPostedTimeAgo() {
    // Use urgencyTag to determine posted time
    if (widget.job.urgencyTag != null) {
      switch (widget.job.urgencyTag!.toLowerCase()) {
        case 'new':
          return 'Posted 1 day ago';
        case 'urgent':
          return 'Posted 3 hours ago';
        case 'expiring soon':
          return 'Posted 5 days ago';
        case 'expired':
          return 'Posted 15 days ago';
        default:
          return 'Posted recently';
      }
    }

    // Fallback to original date calculation if no urgencyTag
    if (widget.job.dueDate != null) {
      try {
        final dueDate =
            DateTime.parse(widget.job.dueDate!.split(',').last.trim());
        final now = DateTime.now();
        final difference = now.difference(dueDate).inDays;

        if (difference < 0) {
          final daysAgo = (-difference / 7).round();
          if (daysAgo == 0) return 'Posted today';
          if (daysAgo == 1) return 'Posted 1 day ago';
          return 'Posted $daysAgo days ago';
        } else {
          return 'Expired ${difference} days ago';
        }
      } catch (e) {
        return 'Posted 2 days ago';
      }
    }
    return 'Posted recently';
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Apply Now',
            onTap: widget.onAcceptJob,
            color: AppColor.mutedGold,
            textColor: Colors.white,
            height: 36,
            radius: 10, // Less rounding on buttons
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        // Consistent outline icons
        _buildActionIcon(Icons.close_outlined, widget.onNotInterested),
        const SizedBox(width: 8),
        _buildActionIcon(Icons.flag_outlined, widget.onReport),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.lightGray,
          borderRadius: BorderRadius.circular(8), // Less rounding
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColor.midGray,
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'urgent':
        return Colors.red;
      case 'expiring soon':
        return Colors.orange;
      case 'new':
        return Colors.green;
      case 'expired':
        return Colors.grey;
      default:
        return AppColor.midGray;
    }
  }
}

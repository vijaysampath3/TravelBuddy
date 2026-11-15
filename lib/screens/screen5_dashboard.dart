import 'package:flutter/material.dart';
import '../models/buddy_registration_data.dart';
import '../theme/app_theme.dart';
import 'screen1_login.dart';
import 'screen2_identity.dart';
import 'screen_bookings.dart';

class Screen5BuddyDashboard extends StatefulWidget {
  const Screen5BuddyDashboard({super.key});

  @override
  State<Screen5BuddyDashboard> createState() => _Screen5BuddyDashboardState();
}

class _Screen5BuddyDashboardState extends State<Screen5BuddyDashboard> {
  int _currentTabIndex = 0;

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F3),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE8E0D6)),
                    ),
                    child: const Icon(Icons.close_rounded, size: 18, color: AppTheme.slateText),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              title: 'Welcome to Travel Buddy Partner!',
              desc: 'Start guiding travellers and earning in Visakhapatnam.',
              time: 'Just now',
              icon: Icons.celebration_rounded,
            ),
            const SizedBox(height: 12),
            _buildNotificationItem(
              title: 'Complete your profile',
              desc: 'Add your guiding bio and languages to get 3x more bookings.',
              time: '2 hours ago',
              icon: Icons.assignment_ind_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String desc,
    required String time,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFE8DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.iconBoxBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primaryOrange, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(desc, style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText)),
                const SizedBox(height: 4),
                Text(time, style: AppTheme.sans(fontSize: 10, color: AppTheme.lightSlate)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEarningsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Earnings Overview', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF00897B), Color(0xFF004D40)]),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Earnings', style: AppTheme.sans(fontSize: 12, color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text('₹18,450.00', style: AppTheme.sans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Completed Tours: 12', style: AppTheme.sans(fontSize: 11.5, color: Colors.white)),
                      Text('Next Payout: 10 Nov', style: AppTheme.sans(fontSize: 11.5, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Traveller Reviews', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('4.9', style: AppTheme.sans(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryOrange)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (_) => const Icon(Icons.star_rounded, color: Color(0xFFFFA000), size: 18)),
                    ),
                    const SizedBox(height: 2),
                    Text('Based on 18 traveller reviews', style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActionsSheet(BuddyRegistrationData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('All Quick Actions', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined, color: AppTheme.primaryOrange),
              title: Text('Set Weekly Availability', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.of(context).push(MaterialPageRoute(builder: (c) => const Screen2IdentityVerification()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined, color: AppTheme.primaryOrange),
              title: Text('Manage Covered Areas', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(data.areasCovered.join(', '), style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText)),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.translate_rounded, color: AppTheme.primaryOrange),
              title: Text('Languages Known', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text('Telugu, English, Hindi', style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText)),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = RegistrationScope.of(context);

    return Scaffold(
      backgroundColor: AppTheme.creamBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar (Shown for Home and Requests tabs; Bookings and Profile have specialized headers)
            if (_currentTabIndex == 0 || _currentTabIndex == 2)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Title / Logo
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Travel ',
                          style: AppTheme.serif(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        TextSpan(
                          text: 'Buddy',
                          style: AppTheme.serif(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkNavy,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notification Bell with Badge
                  GestureDetector(
                    onTap: _showNotificationsSheet,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_none_rounded,
                            color: AppTheme.darkNavy,
                            size: 22,
                          ),
                          Positioned(
                            top: 10,
                            right: 11,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: IndexedStack(
                index: _currentTabIndex,
                children: [
                  _buildHomeTab(data),
                  _buildBookingsTab(),
                  _buildRequestsTab(),
                  _buildProfileTab(data),
                ],
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuddyRegistrationData data) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // Greeting Row (dynamic)
          Builder(
            builder: (context) {
              final data = RegistrationScope.of(context);
              final name = data.fullName.isNotEmpty ? data.fullName.split(' ').first : 'Buddy';
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello, ',
                      style: AppTheme.serif(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    TextSpan(
                      text: '$name!',
                      style: AppTheme.serif(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 3),

          Text(
            'Welcome to Travel Buddy Local Buddy Portal',
            style: AppTheme.sans(
              fontSize: 12.5,
              color: AppTheme.slateText,
            ),
          ),
          const SizedBox(height: 6),

          // Subtle orange line
          Container(
            width: 38,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Profile Completion Card ("Complete Your Basic Info")
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEFE8DF)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  // Beach image on right side
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    width: 140,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.transparent, Colors.black],
                          stops: [0.0, 0.4],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/beach_card.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Left Card Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppTheme.iconBoxBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.assignment_ind_outlined,
                                color: AppTheme.iconOrange,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Complete Your\nBasic Info',
                                    style: AppTheme.serif(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.darkNavy,
                                      height: 1.15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 190),
                          child: Text(
                            'Add your basic details to start receiving guide requests from travellers.',
                            style: AppTheme.sans(
                              fontSize: 10.5,
                              color: AppTheme.slateText,
                              height: 1.3,
                            ),
                          ),
                        ),
                        // Add Basic Info Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Screen2IdentityVerification(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryOrange
                                      .withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Add Basic Info',
                                  style: AppTheme.sans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 13,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Dashboard 2x2 Cards Grid
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTabIndex = 1),
                  child: _buildDashboardCard(
                    title: 'My Bookings',
                    subtitle: 'View and manage your bookings',
                    icon: Icons.calendar_today_outlined,
                    iconColor: const Color(0xFFE65100),
                    bgColor: const Color(0xFFFFF7F2),
                    borderColor: const Color(0xFFFDE8DD),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTabIndex = 2),
                  child: _buildDashboardCard(
                    title: 'Guide Requests',
                    subtitle: 'New travel guide requests',
                    icon: Icons.location_on_rounded,
                    iconColor: const Color(0xFF0288D1),
                    bgColor: const Color(0xFFF2F8FD),
                    borderColor: const Color(0xFFDCEBFA),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _showEarningsSheet,
                  child: _buildDashboardCard(
                    title: 'Earnings',
                    subtitle: 'Track your income and payments',
                    icon: Icons.account_balance_wallet_outlined,
                    iconColor: const Color(0xFF00897B),
                    bgColor: const Color(0xFFF2FBF6),
                    borderColor: const Color(0xFFDCF4E8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: _showReviewsSheet,
                  child: _buildDashboardCard(
                    title: 'Reviews',
                    subtitle: 'See feedback from travellers',
                    icon: Icons.star_outline_rounded,
                    iconColor: const Color(0xFFE65100),
                    bgColor: const Color(0xFFFAF4FC),
                    borderColor: const Color(0xFFF3E5F8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Quick Actions Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Actions',
                style: AppTheme.serif(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkNavy,
                ),
              ),
              GestureDetector(
                onTap: () => _showQuickActionsSheet(data),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: AppTheme.sans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: AppTheme.primaryOrange,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 5 Horizontal Quick Action Items
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildQuickActionItem(
                  icon: Icons.calendar_month_outlined,
                  label: 'Set\nAvailability',
                  iconColor: const Color(0xFFE65100),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c) => const Screen2IdentityVerification())),
                ),
                _buildQuickActionItem(
                  icon: Icons.location_on_rounded,
                  label: 'My\nAreas',
                  iconColor: const Color(0xFFF57C00),
                  onTap: () => _showQuickActionsSheet(data),
                ),
                _buildQuickActionItem(
                  icon: Icons.translate_rounded,
                  label: 'Languages',
                  iconColor: const Color(0xFF0288D1),
                  onTap: () => _showQuickActionsSheet(data),
                ),
                _buildQuickActionItem(
                  icon: Icons.star_outline_rounded,
                  label: 'Interests',
                  iconColor: const Color(0xFFFFA000),
                  onTap: () => _showQuickActionsSheet(data),
                ),
                _buildQuickActionItem(
                  icon: Icons.description_outlined,
                  label: 'View\nProfile',
                  iconColor: const Color(0xFFD84315),
                  onTap: () => setState(() => _currentTabIndex = 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Recent Requests Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Requests',
                style: AppTheme.serif(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkNavy,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentTabIndex = 2),
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: AppTheme.sans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: AppTheme.primaryOrange,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Empty State Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEDE5DC)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/empty_requests_hq.png',
                  width: 44,
                  height: 48,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No new requests yet',
                        style: AppTheme.serif(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkNavy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Complete your profile to start receiving requests from travellers.',
                        style: AppTheme.sans(
                          fontSize: 11,
                          color: AppTheme.slateText,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildBookingsTab() {
    return BookingsScreen(
      onNotificationTap: _showNotificationsSheet,
    );
  }

  Widget _buildRequestsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: [
        Text('Guide Requests', style: AppTheme.serif(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Travellers interested in exploring with you', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEDE5DC)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person, color: AppTheme.darkNavy),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rahul & Sneha (Mumbai)', style: AppTheme.sans(fontSize: 13.5, fontWeight: FontWeight.bold)),
                        Text('Looking for Simhachalam temple guide', style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Request declined', style: AppTheme.sans(color: Colors.white)), backgroundColor: AppTheme.darkNavy),
                        );
                      },
                      child: Text('Decline', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tour request accepted! Added to My Bookings.', style: AppTheme.sans(color: Colors.white)), backgroundColor: AppTheme.successGreen),
                        );
                      },
                      child: const Text('Accept', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab(BuddyRegistrationData data) {
    // Avatar letter from name
    final nameLetter = data.fullName.isNotEmpty ? data.fullName[0].toUpperCase() : 'B';
    final displayName = data.fullName.isNotEmpty ? data.fullName : 'Your Name';

    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        // ── Header ──────────────────────────────────────────────
        Container(
          color: AppTheme.creamBg,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            children: [
              // Title row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _currentTabIndex = 0),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE8E0D6)),
                      ),
                      child: const Icon(Icons.chevron_left_rounded, color: AppTheme.darkNavy, size: 22),
                    ),
                  ),
                  Text('My Profile', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) => const Screen2IdentityVerification()));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.edit_outlined, color: AppTheme.primaryOrange, size: 15),
                        const SizedBox(width: 4),
                        Text('Edit', style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Avatar + name + badges
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 88, height: 88,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppTheme.primaryOrange.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Center(
                      child: Text(nameLetter, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0288D1),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(displayName, style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkNavy)),
                  const SizedBox(width: 6),
                  const Icon(Icons.verified_rounded, color: Color(0xFF0288D1), size: 18),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_rounded, color: AppTheme.primaryOrange, size: 13),
                  const SizedBox(width: 3),
                  Text(
                    'Local Buddy  •  ${data.city.isNotEmpty ? data.city : 'City not set'}',
                    style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (_) => const Icon(Icons.star_rounded, color: Color(0xFFFFA000), size: 16)),
                  const SizedBox(width: 6),
                  Text('5.0 (50 reviews)', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                ],
              ),
              const SizedBox(height: 10),
              // Interest tag pills from registration
              Wrap(
                spacing: 6, runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  _buildTagPill(Icons.emoji_people_outlined, 'Friendly local guide', const Color(0xFFFFECE4), AppTheme.primaryOrange),
                  ...data.selectedInterests.take(3).map((i) =>
                    _buildTagPill(_interestIcon(i), i, const Color(0xFFFFF4EE), AppTheme.primaryOrange)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ── Personal Information ─────────────────────────────────
        _buildSection(
          icon: Icons.person_outline_rounded,
          title: 'Personal Information',
          child: Column(
            children: [
              _buildInfoRow(Icons.badge_outlined, 'Full Name', data.fullName.isNotEmpty ? data.fullName : '—'),
              _buildDivider(),
              _buildInfoRow(Icons.mail_outline_rounded, 'Email', data.emailAddress.isNotEmpty ? data.emailAddress : '—'),
              _buildDivider(),
              _buildInfoRow(Icons.phone_outlined, 'Mobile Number', data.mobileNumber.isNotEmpty ? data.mobileNumber : '—'),
              _buildDivider(),
              _buildInfoRow(Icons.cake_outlined, 'Date of Birth', data.dateOfBirth.isNotEmpty ? data.dateOfBirth : '—'),
              _buildDivider(),
              _buildInfoRow(Icons.person_2_outlined, 'Gender', 'Not specified'),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // ── Location & Languages ─────────────────────────────────
        _buildSection(
          icon: Icons.location_on_outlined,
          title: 'Location & Languages',
          child: Column(
            children: [
              _buildInfoRow(Icons.location_city_outlined, 'City', data.city.isNotEmpty ? data.city : '—'),
              _buildDivider(),
              // Areas You Cover – chips
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.map_outlined, size: 17, color: AppTheme.iconOrange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Areas You Cover', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                          const SizedBox(height: 6),
                          data.areasCovered.isNotEmpty
                              ? Wrap(
                                  spacing: 6, runSpacing: 6,
                                  children: data.areasCovered.map((a) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF4EE),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppTheme.primaryOrange.withValues(alpha: 0.4)),
                                    ),
                                    child: Text(a, style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange)),
                                  )).toList(),
                                )
                              : Text('No areas added', style: AppTheme.sans(fontSize: 12, color: AppTheme.lightSlate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              // Languages Known
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.translate_rounded, size: 17, color: AppTheme.iconOrange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Languages Known', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8, runSpacing: 6,
                            children: [
                              _buildLangChip('🇬🇧', 'English'),
                              _buildLangChip('🇮🇳', 'Hindi'),
                              _buildLangChip('🌐', 'Telugu'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // ── About Me ─────────────────────────────────────────────
        _buildSection(
          icon: Icons.description_outlined,
          title: 'About Me',
          child: Text(
            data.aboutMe.isNotEmpty
                ? data.aboutMe
                : 'Hi! I am a local from ${data.city.isNotEmpty ? data.city : 'my city'}. I love showing travellers the best places, local food and hidden spots. I enjoy meeting new people and sharing my city\'s culture, beaches and unique experiences.',
            style: AppTheme.sans(fontSize: 12.5, color: AppTheme.darkNavy, height: 1.5),
          ),
        ),

        const SizedBox(height: 10),

        // ── Other Details ─────────────────────────────────────────
        _buildSection(
          icon: Icons.star_outline_rounded,
          title: 'Other Details',
          child: Column(
            children: [
              _buildInfoRow(Icons.workspace_premium_outlined, 'Guiding Experience', data.guideExperience.isNotEmpty ? data.guideExperience : '—'),
              _buildDivider(),
              // Interests
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.favorite_border_rounded, size: 17, color: AppTheme.iconOrange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interests & Activities', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                          const SizedBox(height: 6),
                          data.selectedInterests.isNotEmpty
                              ? Wrap(
                                  spacing: 6, runSpacing: 6,
                                  children: data.selectedInterests.map((i) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF4EE),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppTheme.primaryOrange.withValues(alpha: 0.4)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(_interestIcon(i), size: 12, color: AppTheme.primaryOrange),
                                        const SizedBox(width: 4),
                                        Text(i, style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange)),
                                      ],
                                    ),
                                  )).toList(),
                                )
                              : Text('No interests selected', style: AppTheme.sans(fontSize: 12, color: AppTheme.lightSlate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              // Availability
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_month_outlined, size: 17, color: AppTheme.iconOrange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Availability', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                          const SizedBox(height: 4),
                          Builder(builder: (context) {
                            final enabled = data.weeklyAvailability.entries
                                .where((e) => e.value.isEnabled)
                                .toList();
                            if (enabled.isEmpty) {
                              return Text('Not set', style: AppTheme.sans(fontSize: 12, color: AppTheme.lightSlate));
                            }
                            final dayNames = enabled.map((e) => e.key).join(', ');
                            final firstSlot = enabled.first.value;
                            final timeRange = firstSlot.startTime.isNotEmpty
                                ? '${firstSlot.startTime} – ${firstSlot.endTime}'
                                : 'Flexible';
                            return Text(
                              '$dayNames ($timeRange)',
                              style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.darkNavy),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ── Complete Registration button ──────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: AppTheme.primaryRed.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile submitted successfully!', style: AppTheme.sans(color: Colors.white)),
                      backgroundColor: AppTheme.darkNavy,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Complete Registration', style: AppTheme.sans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ── Logout ───────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: const BorderSide(color: Color(0xFFE53935)),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (c) => const Screen1Login()),
                (r) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: Color(0xFFE53935), size: 18),
                const SizedBox(width: 8),
                Text('Logout from Buddy Portal', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFE53935))),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSection({required IconData icon, required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDE5DC)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(gradient: AppTheme.primaryGradient, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: Colors.white, size: 17),
              ),
              const SizedBox(width: 10),
              Text(title, style: AppTheme.serif(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.darkNavy)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 17, color: AppTheme.iconOrange),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText))),
          Flexible(
            flex: 2,
            child: Text(value, textAlign: TextAlign.right, style: AppTheme.sans(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.darkNavy)),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => const Divider(height: 1, color: Color(0xFFF0EAE1));

  Widget _buildTagPill(IconData icon, String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 4),
          Text(label, style: AppTheme.sans(fontSize: 10.5, fontWeight: FontWeight.w600, color: fg)),
        ],
      ),
    );
  }

  Widget _buildLangChip(String flag, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0EA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0D8CE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(flag, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(name, style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.darkNavy)),
        ],
      ),
    );
  }

  IconData _interestIcon(String interest) {
    switch (interest) {
      case 'Beaches': return Icons.beach_access_rounded;
      case 'Food': return Icons.restaurant_rounded;
      case 'Heritage': return Icons.account_balance_outlined;
      case 'Adventure': return Icons.terrain_rounded;
      case 'Nature': return Icons.eco_outlined;
      case 'Photography': return Icons.photo_camera_outlined;
      case 'Culture': return Icons.theater_comedy_outlined;
      case 'Night Life': return Icons.nightlight_round_outlined;
      default: return Icons.star_outline_rounded;
    }
  }



  Widget _buildDashboardCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 19,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: iconColor.withValues(alpha: 0.6),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTheme.serif(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkNavy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.sans(
              fontSize: 10,
              color: AppTheme.slateText,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEFE8DF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTheme.sans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkNavy,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home'),
          _buildNavItem(1, Icons.calendar_month_outlined, 'Bookings'),
          _buildNavItem(2, Icons.assignment_outlined, 'Requests'),
          _buildNavItem(3, Icons.person_outline_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentTabIndex == index;

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryRed.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.sans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppTheme.slateText,
                size: 20,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTheme.sans(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.slateText,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

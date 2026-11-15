import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'screen1_login.dart';
import 'traveller_ai_assistant.dart';

class TravellerHomeScreen extends StatefulWidget {
  final TravellerRegistrationData data;
  const TravellerHomeScreen({super.key, required this.data});

  @override
  State<TravellerHomeScreen> createState() => _TravellerHomeScreenState();
}

class _TravellerHomeScreenState extends State<TravellerHomeScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;
  late TextEditingController _searchCtrl;
  PageController? _bannerController;
  PageController get _featuredBannerController =>
      _bannerController ??= PageController();
  int _currentBannerPage = 0;

  final List<_FeaturedBannerItem> _featuredBannerItems = [
    const _FeaturedBannerItem(
      categoryTag: 'ADVENTURE & WATER SPORTS',
      title: 'Rushikonda\nBlue Flag Beach',
      subtitle: 'Surfing, Water Sports & Scenic Views',
      distance: '6.2 km',
      rating: '4.8 (2.4K)',
      imagePath: 'assets/images/booking_rushikonda.png',
      slogan: 'Where the Ocean\nMeets Adventure',
      priceInfo: 'Activity packages from ₹499',
    ),
    const _FeaturedBannerItem(
      categoryTag: 'NATURE & HILL RESORT',
      title: 'Araku Valley &\nCoffee Hills',
      subtitle: 'Waterfalls, Plantations & Borra Caves',
      distance: '114 km',
      rating: '4.9 (3.8K)',
      imagePath: 'assets/images/booking_araku_hq.png',
      slogan: 'Serenity in the\nEastern Ghats',
      priceInfo: 'Day trips from ₹1,299',
    ),
    const _FeaturedBannerItem(
      categoryTag: 'SCENIC PANORAMA',
      title: 'Kailasagiri\nHilltop Park',
      subtitle: 'Panoramic Coastal Views & Ropeway',
      distance: '8.5 km',
      rating: '4.7 (1.9K)',
      imagePath: 'assets/images/booking_kailasagiri.png',
      slogan: 'Above the Clouds\nOverlooking Sea',
      priceInfo: 'Ropeway & Entry from ₹150',
    ),
    const _FeaturedBannerItem(
      categoryTag: 'GOLDEN COAST RETREAT',
      title: 'Yarada Beach &\nCliff Coast',
      subtitle: 'Golden Sands Surrounded by Green Hills',
      distance: '15.0 km',
      rating: '4.8 (2.1K)',
      imagePath: 'assets/images/booking_yarada.png',
      slogan: 'Untouched Beauty\nOf Vizag Coast',
      priceInfo: 'Beachside tours from ₹699',
    ),
    const _FeaturedBannerItem(
      categoryTag: 'HERITAGE & CLIFFS',
      title: "Dolphin's Nose\n& Lighthouse",
      subtitle: 'Historic Promontory & Coastal Views',
      distance: '12.3 km',
      rating: '4.6 (1.5K)',
      imagePath: 'assets/images/booking_dolphins_nose.png',
      slogan: 'Historic Beacon\nBy the Ocean',
      priceInfo: 'Lighthouse tour from ₹250',
    ),
  ];

  final List<_CategoryItem> _categories = [
    _CategoryItem('Explore', Icons.explore_rounded, Color(0xFFFF5E36)),
    _CategoryItem('Hotels', Icons.apartment_rounded, Color(0xFF3B82F6)),
    _CategoryItem('Transport', Icons.directions_bus_rounded, Color(0xFF10B981)),
    _CategoryItem('Car Rentals', Icons.vpn_key_rounded, Color(0xFF8B5CF6)),
    _CategoryItem('All', Icons.grid_view_rounded, Color(0xFFF59E0B)),
  ];

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController(text: 'Visakhapatnam');
    _bannerController = PageController();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _bannerController?.dispose();
    super.dispose();
  }

  void _showAiAssistantDialog() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerAiAssistantScreen(data: widget.data),
      ),
    );
  }

  void _showCartSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trip Bookings Cart', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF7F3),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEDE5DC)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/booking_rushikonda.png', width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rushikonda Beach Tour', style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text('Full Day • ₹2,499', style: AppTheme.sans(fontSize: 12, color: AppTheme.primaryOrange)),
                      ],
                    ),
                  ),
                  const Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Proceeding to checkout...', style: AppTheme.sans(color: Colors.white)),
                      backgroundColor: AppTheme.darkNavy,
                    ),
                  );
                },
                child: Text('Checkout (1 Item)', style: AppTheme.sans(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails({required String title, required String subtitle, String? price}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: const Color(0xFFE5DDD5), borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text(title, style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(subtitle, style: AppTheme.sans(fontSize: 13, color: AppTheme.slateText)),
            if (price != null) ...[
              const SizedBox(height: 12),
              Text(price, style: AppTheme.sans(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryOrange)),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      side: const BorderSide(color: AppTheme.primaryOrange),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to Wishlist!', style: AppTheme.sans(color: Colors.white)),
                          backgroundColor: AppTheme.darkNavy,
                        ),
                      );
                    },
                    child: Text('Save to Wishlist', style: AppTheme.sans(color: AppTheme.primaryOrange, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppTheme.primaryOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Booking confirmed for $title!', style: AppTheme.sans(color: Colors.white)),
                          backgroundColor: AppTheme.darkNavy,
                        ),
                      );
                    },
                    child: Text('Book Now', style: AppTheme.sans(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTapped(int index) {
    setState(() => _selectedNavIndex = index);
    if (index == 0) return;

    final titles = ['Home', 'Wishlist', 'Safety & SOS', 'Buddies', 'Profile'];
    final title = titles[index];

    if (index == 2) {
      // Safety SOS Bottom Sheet
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 14),
              Text('Travel Buddy Safety SOS', style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                '24/7 verified traveller safety assistance, local emergency helplines & live tracking support.',
                textAlign: TextAlign.center,
                style: AppTheme.sans(fontSize: 12.5, color: AppTheme.slateText),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: const BorderSide(color: AppTheme.primaryRed),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Connecting to Emergency Services: 112...'), backgroundColor: AppTheme.primaryRed),
                        );
                      },
                      icon: const Icon(Icons.call_rounded, color: AppTheme.primaryRed, size: 18),
                      label: Text('Call 112', style: AppTheme.sans(color: AppTheme.primaryRed, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Live location broadcast to verified emergency buddies!'), backgroundColor: AppTheme.darkNavy),
                        );
                      },
                      icon: const Icon(Icons.share_location_rounded, color: Colors.white, size: 18),
                      label: Text('Share SOS', style: AppTheme.sans(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (index == 4) {
      // Profile Sheet
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppTheme.iconBoxBg,
                child: Text(
                  widget.data.fullName.isNotEmpty ? widget.data.fullName[0].toUpperCase() : 'T',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryOrange),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.data.fullName.isNotEmpty ? widget.data.fullName : 'Guest Explorer',
                style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.data.email.isNotEmpty ? widget.data.email : 'traveller@travelbuddy.com',
                style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified_rounded, size: 14, color: AppTheme.successGreen),
                    const SizedBox(width: 4),
                    Text(
                      widget.data.isPassportVerified ? 'Verified Explorer' : 'Explorer Profile',
                      style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF047857)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.logout_rounded, color: AppTheme.primaryRed),
                title: Text('Sign Out', style: AppTheme.sans(color: AppTheme.primaryRed, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Screen1Login()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      // General Placeholder
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (ctx) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: AppTheme.iconBoxBg, shape: BoxShape.circle),
                child: Icon(
                  index == 1
                      ? Icons.favorite_rounded
                      : index == 2
                          ? Icons.explore_rounded
                          : Icons.people_alt_rounded,
                  color: AppTheme.primaryOrange,
                  size: 32,
                ),
              ),
              const SizedBox(height: 14),
              Text(title, style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                'This section will be expanded in the next update.',
                textAlign: TextAlign.center,
                style: AppTheme.sans(fontSize: 13, color: AppTheme.slateText),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Close', style: AppTheme.sans(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAEEE2),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TOP SEARCH & ACTION BAR
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    // Search bar
                    Expanded(
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.inputBg,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppTheme.softBorder),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search_rounded, color: AppTheme.primaryOrange, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchCtrl,
                                style: AppTheme.sans(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppTheme.darkNavy),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: 'Search destinations...',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // "Ask AI" pill button
                    GestureDetector(
                      onTap: _showAiAssistantDialog,
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryRed.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 15),
                            const SizedBox(width: 5),
                            Text(
                              'Ask AI',
                              style: AppTheme.sans(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Shopping Cart button
                    GestureDetector(
                      onTap: _showCartSheet,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFEDE6DD)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.shopping_cart_outlined, color: Color(0xFF2563EB), size: 20),
                            Positioned(
                              top: 9,
                              right: 9,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: AppTheme.primaryOrange, shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. CATEGORY NAVIGATION ROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_categories.length, (i) {
                    final item = _categories[i];
                    final isSelected = _selectedCategoryIndex == i;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategoryIndex = i);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected category: ${item.label}', style: AppTheme.sans(color: Colors.white)),
                            backgroundColor: AppTheme.darkNavy,
                            duration: const Duration(milliseconds: 900),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isSelected ? item.color.withValues(alpha: 0.12) : AppTheme.inputBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? item.color : AppTheme.softBorder,
                                width: isSelected ? 1.5 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(item.icon, color: item.color, size: 24),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.label,
                            style: AppTheme.sans(
                              fontSize: 11.5,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? AppTheme.darkNavy : AppTheme.slateText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),

              // 3. FEATURED DESTINATION BANNER CAROUSEL
              SizedBox(
                height: 224,
                child: PageView.builder(
                  controller: _featuredBannerController,
                  itemCount: _featuredBannerItems.length,
                  onPageChanged: (index) {
                    setState(() => _currentBannerPage = index);
                  },
                  itemBuilder: (context, index) {
                    final item = _featuredBannerItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFEDD5B8), width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDC9566).withValues(alpha: 0.16),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(23),
                          child: Stack(
                            children: [
                              // Background Destination photo
                              Positioned.fill(
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),

                              // Warm sunset orange-cream gradient overlay on left
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.0, 0.44, 0.72, 1.0],
                                      colors: [
                                        Color(0xFFFFF0E4), // Rich warm peach-orange
                                        Color(0xF2FFF0E4), // 95% opacity warm tone
                                        Color(0x66FFF0E4), // Gentle warm transition
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Warm bottom-left amber glow
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      stops: const [0.0, 0.5, 1.0],
                                      colors: [
                                        const Color(0xFFFFD1B2).withValues(alpha: 0.45),
                                        const Color(0xFFFFD1B2).withValues(alpha: 0.12),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Slogan script on the right side
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.42),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                                  ),
                                  child: Text(
                                    item.slogan,
                                    textAlign: TextAlign.right,
                                    style: AppTheme.serif(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),

                              // Content on the left
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Orange Category tag
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFECE0),
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(color: const Color(0xFFFFCCA8), width: 1),
                                          ),
                                          child: Text(
                                            item.categoryTag,
                                            style: AppTheme.sans(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.primaryOrange,
                                              letterSpacing: 0.6,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),

                                        // Destination Name
                                        Text(
                                          item.title,
                                          style: AppTheme.serif(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.darkNavy,
                                            height: 1.15,
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                        // Subtitle
                                        Text(
                                          item.subtitle,
                                          style: AppTheme.sans(
                                            fontSize: 11,
                                            color: const Color(0xFF6E5D52),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 6),

                                        // Info chips (Distance & Rating)
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_rounded, size: 13, color: AppTheme.primaryOrange),
                                            const SizedBox(width: 3),
                                            Text(item.distance, style: AppTheme.sans(fontSize: 11, color: const Color(0xFF6E5D52))),
                                            const SizedBox(width: 10),
                                            const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                                            const SizedBox(width: 3),
                                            Text(
                                              item.rating,
                                              style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Explore Now button
                                    GestureDetector(
                                      onTap: () => _showItemDetails(
                                        title: item.title.replaceAll('\n', ' '),
                                        subtitle: '${item.subtitle} • Visakhapatnam',
                                        price: item.priceInfo,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          gradient: AppTheme.primaryGradient,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.primaryRed.withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Explore Now',
                                              style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(Icons.arrow_forward_rounded, size: 13, color: Colors.white),
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
                    );
                  },
                ),
              ),

              // Interactive pagination dots for featured banner
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_featuredBannerItems.length, (i) {
                  final isActive = _currentBannerPage == i;
                  return GestureDetector(
                    onTap: () {
                      _featuredBannerController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive ? AppTheme.primaryOrange : const Color(0xFFECCBBA),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // 4. FEATURED EXPERIENCES SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured Experiences',
                      style: AppTheme.serif(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                    ),
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Viewing all experiences', style: AppTheme.sans(color: Colors.white))),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'See all',
                            style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_forward_rounded, size: 12, color: AppTheme.primaryOrange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Two Horizontal Experience Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Card 1: Visakhapatnam Getaway
                    Expanded(
                      child: _buildExperienceCard(
                        imagePath: 'assets/images/booking_rk_beach.png',
                        title: 'Visakhapatnam Getaway',
                        subtitle: '3 Days • Beach • Food • Culture',
                        price: '₹6,999',
                        onTap: () => _showItemDetails(
                          title: 'Visakhapatnam Getaway',
                          subtitle: '3 Days • Beach • Food • Culture',
                          price: 'From ₹6,999',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Card 2: Araku Valley Escape
                    Expanded(
                      child: _buildExperienceCard(
                        imagePath: 'assets/images/booking_araku_hq.png',
                        title: 'Araku Valley Escape',
                        subtitle: '2 Days • Nature • Waterfalls • Hills',
                        price: '₹4,999',
                        onTap: () => _showItemDetails(
                          title: 'Araku Valley Escape',
                          subtitle: '2 Days • Nature • Waterfalls • Hills',
                          price: 'From ₹4,999',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. TRENDING DESTINATIONS SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Destinations',
                      style: AppTheme.serif(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                    ),
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Viewing trending destinations', style: AppTheme.sans(color: Colors.white))),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'See all',
                            style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_forward_rounded, size: 12, color: AppTheme.primaryOrange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 4 Compact Destination Image Cards in Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildCompactDestinationCard(
                        imagePath: 'assets/images/booking_rushikonda.png',
                        name: 'Rushikonda',
                        category: 'Beach & Water Sports',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCompactDestinationCard(
                        imagePath: 'assets/images/booking_araku_hq.png',
                        name: 'Araku Valley',
                        category: 'Hills & Nature',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCompactDestinationCard(
                        imagePath: 'assets/images/booking_kailasagiri.png',
                        name: 'Kailasagiri',
                        category: 'View Point',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildCompactDestinationCard(
                        imagePath: 'assets/images/booking_yarada.png',
                        name: 'Yarada Beach',
                        category: 'Beach & Adventure',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6. AI RECOMMENDATIONS SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded, color: AppTheme.primaryOrange, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          'AI Recommends For You',
                          style: AppTheme.serif(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Viewing all AI suggestions', style: AppTheme.sans(color: Colors.white))),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'See all',
                            style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryOrange),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_forward_rounded, size: 12, color: AppTheme.primaryOrange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Recommendation Card (Wide Card)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () => _showItemDetails(
                    title: '7-Day Vizag & Araku Explorer',
                    subtitle: 'Beaches, Hills, Culture & Heritage • Complete guided circuit',
                    price: '₹14,999 / person',
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.offWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.softBorder),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Left Image (Simhachalam temple)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/booking_simhachalam.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Center content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '7-Day Vizag & Araku Explorer',
                                style: AppTheme.serif(fontSize: 13.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                              ),
                              const SizedBox(height: 5),

                              // Category tags
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: ['Beaches', 'Hills', 'Culture', 'Nature'].map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3ECE4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tag,
                                      style: AppTheme.sans(fontSize: 9.5, color: AppTheme.slateText, fontWeight: FontWeight.w600),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 5),

                              Text(
                                'Perfect balance of adventure, relaxation and local experiences.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Right Action Circle Button
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 7. BOTTOM NAVIGATION BAR - Floating Scooped Pill Bar
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          MediaQuery.of(context).padding.bottom + 8,
        ),
        child: SizedBox(
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Curved Scooped Pill Background
              Positioned.fill(
                child: CustomPaint(
                  painter: _CurvedNotchedPillPainter(
                    backgroundColor: const Color(0xFFFBF4ED),
                    borderColor: const Color(0xFFEDD5B8),
                  ),
                ),
              ),

              // 2. Navigation Items Row
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildNavItem(
                        index: 0,
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home_rounded,
                        label: 'Home',
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        index: 1,
                        icon: Icons.favorite_border_rounded,
                        activeIcon: Icons.favorite_rounded,
                        label: 'Wishlist',
                      ),
                    ),

                    // Center gap for circular button
                    const SizedBox(width: 58),

                    Expanded(
                      child: _buildNavItem(
                        index: 3,
                        icon: Icons.people_outline_rounded,
                        activeIcon: Icons.people_rounded,
                        label: 'Buddies',
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        index: 4,
                        icon: Icons.person_outline_rounded,
                        activeIcon: Icons.person_rounded,
                        label: 'Profile',
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Central Emergency / Safety Button with Shield & Exclamation
              Positioned(
                top: -14,
                child: GestureDetector(
                  onTap: () => _onBottomNavTapped(2),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5E36), Color(0xFFE53935)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE53935).withValues(alpha: 0.38),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.shield_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 3.2,
                                  height: 8.5,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE53935),
                                    borderRadius: BorderRadius.circular(1.5),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: 3.2,
                                  height: 3.2,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE53935),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _selectedNavIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onBottomNavTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? AppTheme.darkNavy : AppTheme.slateText,
            size: 22,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppTheme.sans(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppTheme.darkNavy : AppTheme.slateText,
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryOrange : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required String price,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.offWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.softBorder),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDC9566).withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  color: const Color(0xFFE5DDD5),
                  child: const Center(child: Icon(Icons.landscape_rounded, color: AppTheme.slateText)),
                ),
              ),
            ),
            // Text Details
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.serif(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.sans(fontSize: 10, color: AppTheme.slateText),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'From ', style: AppTheme.sans(fontSize: 10, color: AppTheme.slateText)),
                            TextSpan(
                              text: price,
                              style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryOrange),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                      ),
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

  Widget _buildCompactDestinationCard({
    required String imagePath,
    required String name,
    required String category,
  }) {
    return GestureDetector(
      onTap: () => _showItemDetails(title: name, subtitle: category),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.offWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.softBorder),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDC9566).withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                height: 60,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 60,
                  color: const Color(0xFFE5DDD5),
                  child: const Center(child: Icon(Icons.image_outlined, color: AppTheme.slateText)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.serif(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  Text(
                    category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.sans(fontSize: 8.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem {
  final String label;
  final IconData icon;
  final Color color;
  const _CategoryItem(this.label, this.icon, this.color);
}

class _FeaturedBannerItem {
  final String categoryTag;
  final String title;
  final String subtitle;
  final String distance;
  final String rating;
  final String imagePath;
  final String slogan;
  final String priceInfo;

  const _FeaturedBannerItem({
    required this.categoryTag,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.rating,
    required this.imagePath,
    required this.slogan,
    required this.priceInfo,
  });
}

class _CurvedNotchedPillPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;

  const _CurvedNotchedPillPainter({
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final r = h / 2; // Pill radius
    final cx = w / 2;

    const double notchRadius = 32.0;
    const double s = 14.0; // Curve transition width

    final path = Path();
    // Start at top edge after left rounded end
    path.moveTo(r, 0);

    // Line to start of scoop
    path.lineTo(cx - notchRadius - s, 0);

    // Smooth entry into scoop down to center point
    path.cubicTo(
      cx - notchRadius - 4, 0,
      cx - notchRadius + 2, 25,
      cx, 25,
    );

    // Smooth exit from scoop back to top line
    path.cubicTo(
      cx + notchRadius - 2, 25,
      cx + notchRadius + 4, 0,
      cx + notchRadius + s, 0,
    );

    // Line to top-right corner
    path.lineTo(w - r, 0);

    // Right rounded cap (180 deg)
    path.arcToPoint(
      Offset(w - r, h),
      radius: Radius.circular(r),
      clockwise: true,
    );

    // Bottom straight line
    path.lineTo(r, h);

    // Left rounded cap (180 deg)
    path.arcToPoint(
      Offset(r, 0),
      radius: Radius.circular(r),
      clockwise: true,
    );

    path.close();

    // Soft drop shadow
    canvas.drawShadow(
      path,
      const Color(0xFFDC9566).withValues(alpha: 0.18),
      12,
      false,
    );

    // Fill background
    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Stroke border
    final strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _CurvedNotchedPillPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.borderColor != borderColor;
}


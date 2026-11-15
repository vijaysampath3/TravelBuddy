import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'screen_booking_details.dart';

// ── Data Model ───────────────────────────────────────────────────────────────

enum BookingStatus { pending, accepted, rejected }

class DestinationPlace {
  final String name;
  final String imagePath;
  final String? description;

  const DestinationPlace({
    required this.name,
    required this.imagePath,
    this.description,
  });
}

class BookingRecord {
  final String id;
  final String destination;
  final String location;
  final String description;
  final String date;
  final String timeAgo;
  final int travellers;
  final String duration;
  final String traveller;
  final double rating;
  final int reviews;
  final String imagePath;
  final String? travellerAvatar;
  final String country;
  final String countryFlag;
  final int hourlyRate;
  final List<DestinationPlace> destinations;
  String? buddyNote;
  BookingStatus status;

  BookingRecord({
    required this.id,
    required this.destination,
    required this.location,
    required this.description,
    required this.date,
    required this.timeAgo,
    required this.travellers,
    required this.duration,
    required this.traveller,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    this.travellerAvatar,
    this.country = 'India',
    this.countryFlag = '🇮🇳',
    this.hourlyRate = 250,
    this.destinations = const [],
    this.buddyNote,
    required this.status,
  });
}

// ── Seven Destination Sample Bookings in Visakhapatnam ────────────────────────

final List<BookingRecord> _sampleBookings = [
  BookingRecord(
    id: 'BK001',
    destination: 'Kailasagiri Hill View Tour',
    location: 'Kailasagiri, Visakhapatnam',
    description: 'Scenic hilltop viewpoints and panoramic coastal views.',
    date: '12 Nov 2026',
    timeAgo: '2 hours ago',
    travellers: 2,
    duration: 'Full Day',
    traveller: 'Rahul Mehta',
    rating: 4.8,
    reviews: 12,
    imagePath: 'assets/images/booking_kailasagiri.png',
    travellerAvatar: 'assets/images/traveller_rahul.png',
    country: 'India',
    countryFlag: '🇮🇳',
    hourlyRate: 250,
    destinations: const [
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Hilltop viewpoint over the bay.'),
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Beach promenade and city views.'),
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Historic naval submarine.'),
      DestinationPlace(name: 'Rushikonda', imagePath: 'assets/images/booking_rushikonda.png', description: 'Golden sand beach and water sports.'),
      DestinationPlace(name: 'Yarada Beach', imagePath: 'assets/images/booking_yarada.png', description: 'Secluded beach flanked by hills.'),
      DestinationPlace(name: 'Araku Valley', imagePath: 'assets/images/booking_araku_hq.png', description: 'Picturesque valley and coffee gardens.'),
    ],
    status: BookingStatus.pending,
  ),
  BookingRecord(
    id: 'BK002',
    destination: 'RK Beach City Experience',
    location: 'Ramakrishna Beach, Visakhapatnam',
    description: 'Beach promenade, local attractions and coastal sightseeing.',
    date: '18 Nov 2026',
    timeAgo: '5 hours ago',
    travellers: 3,
    duration: 'Full Day',
    traveller: 'Sneha Reddy',
    rating: 5.0,
    reviews: 28,
    imagePath: 'assets/images/booking_rk_beach.png',
    travellerAvatar: 'assets/images/traveller_sneha.png',
    country: 'India',
    countryFlag: '🇮🇳',
    hourlyRate: 200,
    destinations: const [
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Scenic beach promenade.'),
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Historic INS Kursura submarine museum.'),
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Scenic hilltop park.'),
      DestinationPlace(name: "Dolphin's Nose", imagePath: 'assets/images/booking_dolphins_nose.png', description: 'Lighthouse and coastal viewpoint.'),
      DestinationPlace(name: 'Rushikonda', imagePath: 'assets/images/booking_rushikonda.png', description: 'Popular beach and coast.'),
    ],
    status: BookingStatus.pending,
  ),
  BookingRecord(
    id: 'BK003',
    destination: 'Rushikonda Beach Experience',
    location: 'Rushikonda, Visakhapatnam',
    description: 'Beach exploration and coastal activities.',
    date: '20 Oct 2026',
    timeAgo: '1 day ago',
    travellers: 4,
    duration: '1 – 3 Hours',
    traveller: 'Emily Carter',
    rating: 5.0,
    reviews: 50,
    imagePath: 'assets/images/booking_rushikonda.png',
    travellerAvatar: 'assets/images/traveller_emily.png',
    country: 'Germany',
    countryFlag: '🇩🇪',
    hourlyRate: 250,
    destinations: const [
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Beach promenade and coastline.'),
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'INS Kursura submarine museum.'),
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Panoramic coastal view point.'),
      DestinationPlace(name: 'Araku Valley', imagePath: 'assets/images/booking_araku_hq.png', description: 'Scenic hill station retreat.'),
      DestinationPlace(name: 'Rushikonda', imagePath: 'assets/images/booking_rushikonda.png', description: 'Golden sands and water activities.'),
      DestinationPlace(name: 'Yarada Beach', imagePath: 'assets/images/booking_yarada.png', description: 'Peaceful secluded beach.'),
    ],
    status: BookingStatus.accepted,
  ),
  BookingRecord(
    id: 'BK004',
    destination: 'Yarada Beach Escape',
    location: 'Yarada, Visakhapatnam',
    description: 'Scenic beach surrounded by green hills.',
    date: '10 Oct 2026',
    timeAgo: '3 days ago',
    travellers: 2,
    duration: 'Half Day',
    traveller: 'Ananya Iyer',
    rating: 4.7,
    reviews: 9,
    imagePath: 'assets/images/booking_yarada.png',
    travellerAvatar: 'assets/images/traveller_ananya.png',
    country: 'United Kingdom',
    countryFlag: '🇬🇧',
    hourlyRate: 300,
    destinations: const [
      DestinationPlace(name: 'Yarada Beach', imagePath: 'assets/images/booking_yarada.png', description: 'Secluded beach flanked by hills.'),
      DestinationPlace(name: "Dolphin's Nose", imagePath: 'assets/images/booking_dolphins_nose.png', description: 'Historic lighthouse viewpoint.'),
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Famous city beachfront.'),
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Coastal hill station.'),
    ],
    status: BookingStatus.rejected,
  ),
  BookingRecord(
    id: 'BK005',
    destination: 'INS Kursura Submarine Museum',
    location: 'RK Beach Road, Visakhapatnam',
    description: 'Explore the historic Indian Navy submarine museum.',
    date: '25 Oct 2026',
    timeAgo: '4 days ago',
    travellers: 3,
    duration: '3 – 5 Hours',
    traveller: 'Karthik Rao',
    rating: 5.0,
    reviews: 22,
    imagePath: 'assets/images/booking_submarine.png',
    travellerAvatar: 'assets/images/traveller_vikram.png',
    country: 'United States',
    countryFlag: '🇺🇸',
    hourlyRate: 250,
    destinations: const [
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Historic naval submarine.'),
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Promenade and local stalls.'),
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Hilltop views of Vizag.'),
      DestinationPlace(name: 'Simhachalam', imagePath: 'assets/images/booking_simhachalam.png', description: 'Ancient temple architecture.'),
    ],
    status: BookingStatus.accepted,
  ),
  BookingRecord(
    id: 'BK006',
    destination: 'Simhachalam Temple Visit',
    location: 'Simhachalam, Visakhapatnam',
    description: 'Explore the historic Varaha Lakshmi Narasimha Temple.',
    date: '20 Oct 2026',
    timeAgo: '5 days ago',
    travellers: 2,
    duration: 'Half Day',
    traveller: 'Priya Nair',
    rating: 4.9,
    reviews: 31,
    imagePath: 'assets/images/booking_simhachalam.png',
    travellerAvatar: 'assets/images/traveller_sneha.png',
    country: 'India',
    countryFlag: '🇮🇳',
    hourlyRate: 200,
    destinations: const [
      DestinationPlace(name: 'Simhachalam', imagePath: 'assets/images/booking_simhachalam.png', description: '11th-century temple heritage.'),
      DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Overlook the coastline.'),
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Sunset seaside walk.'),
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Naval museum tour.'),
    ],
    status: BookingStatus.pending,
  ),
  BookingRecord(
    id: 'BK007',
    destination: "Dolphin's Nose Lighthouse Tour",
    location: 'Dolphin Hill, Visakhapatnam',
    description: 'Panoramic coastal and harbour viewpoints.',
    date: '05 Nov 2026',
    timeAgo: '1 day ago',
    travellers: 3,
    duration: 'Half Day',
    traveller: 'Arjun Kapoor',
    rating: 4.6,
    reviews: 12,
    imagePath: 'assets/images/booking_dolphins_nose.png',
    travellerAvatar: 'assets/images/traveller_rahul.png',
    country: 'Australia',
    countryFlag: '🇦🇺',
    hourlyRate: 350,
    destinations: const [
      DestinationPlace(name: "Dolphin's Nose", imagePath: 'assets/images/booking_dolphins_nose.png', description: 'High cliff lighthouse vista.'),
      DestinationPlace(name: 'Yarada Beach', imagePath: 'assets/images/booking_yarada.png', description: 'Quiet coastal stretch.'),
      DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'City beach walk.'),
      DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Historic museum exhibit.'),
    ],
    status: BookingStatus.rejected,
  ),
];

// ── Bookings Screen ──────────────────────────────────────────────────────────

class BookingsScreen extends StatefulWidget {
  final VoidCallback? onNotificationTap;
  const BookingsScreen({super.key, this.onNotificationTap});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final List<BookingRecord> _bookings = List.from(_sampleBookings);
  String _selectedTab = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter criteria
  String? _filterStatus;
  String? _filterDuration;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BookingRecord> get _filteredBookings {
    return _bookings.where((b) {
      // Status tab filter
      if (_selectedTab == 'Pending' && b.status != BookingStatus.pending) return false;
      if (_selectedTab == 'Accepted' && b.status != BookingStatus.accepted) return false;
      if (_selectedTab == 'Rejected' && b.status != BookingStatus.rejected) return false;

      // Search query filter (traveller name, destination, date, location)
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matches = b.destination.toLowerCase().contains(q) ||
            b.location.toLowerCase().contains(q) ||
            b.date.toLowerCase().contains(q) ||
            b.traveller.toLowerCase().contains(q);
        if (!matches) return false;
      }

      // Filter sheet criteria
      if (_filterStatus != null && _filterStatus != 'All') {
        if (b.status.name.toLowerCase() != _filterStatus!.toLowerCase()) return false;
      }
      if (_filterDuration != null && _filterDuration != 'Any') {
        if (b.duration != _filterDuration) return false;
      }

      return true;
    }).toList();
  }

  void _openBookingDetails(BookingRecord b) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BookingDetailsScreen(
          booking: b,
          onStatusChanged: (newStatus) {
            setState(() {
              b.status = newStatus;
            });
          },
        ),
      ),
    );
    setState(() {});
  }

  void _acceptBooking(BookingRecord b) {
    setState(() {
      b.status = BookingStatus.accepted;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted tour for ${b.destination}!', style: AppTheme.sans(color: Colors.white)),
        backgroundColor: AppTheme.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _rejectBooking(BookingRecord b) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reject Booking Request?',
          style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
        ),
        content: Text(
          'Are you sure you want to decline the booking for "${b.destination}" with ${b.traveller}?',
          style: AppTheme.sans(fontSize: 13, color: AppTheme.slateText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTheme.sans(color: AppTheme.slateText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                b.status = BookingStatus.rejected;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking request rejected', style: AppTheme.sans(color: Colors.white)),
                  backgroundColor: AppTheme.darkNavy,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showBookingDetailsSheet(BookingRecord b) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.70,
        maxChildSize: 0.90,
        minChildSize: 0.50,
        expand: false,
        builder: (_, scrollCtrl) => SingleChildScrollView(
          controller: scrollCtrl,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking Details',
                    style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
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
              const SizedBox(height: 4),
              Text('Reference ID: ${b.id}', style: AppTheme.sans(fontSize: 11.5, color: AppTheme.lightSlate)),
              const SizedBox(height: 14),

              // Destination Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.asset(
                    b.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFFAF7F3),
                      child: const Center(
                        child: Icon(Icons.landscape_rounded, size: 36, color: AppTheme.lightSlate),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Destination Title & Status Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      b.destination,
                      style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusBadge(b.status),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 13, color: AppTheme.primaryOrange),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(b.location, style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Description
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F3),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEDE5DC)),
                ),
                child: Text(
                  b.description,
                  style: AppTheme.sans(fontSize: 12.5, color: AppTheme.darkNavy, height: 1.4),
                ),
              ),
              const SizedBox(height: 16),

              // Details List
              _buildDetailItem(Icons.person_outline_rounded, 'Traveller', b.traveller),
              _buildDetailItem(Icons.people_outline_rounded, 'Number of Travellers', '${b.travellers} Travellers'),
              _buildDetailItem(Icons.calendar_today_outlined, 'Booking Date', b.date),
              _buildDetailItem(Icons.access_time_rounded, 'Duration', b.duration),
              _buildDetailItem(Icons.star_rounded, 'Traveller Rating', '${b.rating} (${b.reviews} reviews)'),
              _buildDetailItem(Icons.history_rounded, 'Requested', b.timeAgo),

              const SizedBox(height: 20),

              // Actions inside details
              if (b.status == BookingStatus.pending) ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          side: const BorderSide(color: Color(0xFFE53935)),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          _rejectBooking(b);
                        },
                        child: Text(
                          'Reject Request',
                          style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFE53935)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          _acceptBooking(b);
                        },
                        child: Text(
                          'Accept Request',
                          style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.iconBoxBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppTheme.iconOrange),
          ),
          const SizedBox(width: 10),
          Text(label, style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
          const Spacer(),
          Text(
            value,
            style: AppTheme.sans(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.darkNavy),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    String? tempStatus = _filterStatus;
    String? tempDuration = _filterDuration;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 22,
            right: 22,
            top: 22,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 22,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Bookings',
                    style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
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
              const SizedBox(height: 18),

              // Booking Status filter
              Text('Booking Status', style: AppTheme.sans(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['All', 'Pending', 'Accepted', 'Rejected'].map((s) {
                  final isSelected = (tempStatus == null && s == 'All') || tempStatus == s;
                  return GestureDetector(
                    onTap: () => setModalState(() => tempStatus = s == 'All' ? null : s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryOrange : const Color(0xFFFAF7F3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppTheme.primaryOrange : const Color(0xFFE0D8CE)),
                      ),
                      child: Text(
                        s,
                        style: AppTheme.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.darkNavy,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),

              // Travel Type (Duration) filter
              Text('Travel Type (Duration)', style: AppTheme.sans(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Any', 'Full Day', 'Half Day', 'Evening'].map((d) {
                  final isSelected = (tempDuration == null && d == 'Any') || tempDuration == d;
                  return GestureDetector(
                    onTap: () => setModalState(() => tempDuration = d == 'Any' ? null : d),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryOrange : const Color(0xFFFAF7F3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppTheme.primaryOrange : const Color(0xFFE0D8CE)),
                      ),
                      child: Text(
                        d,
                        style: AppTheme.sans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.darkNavy,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Action buttons: Reset & Apply
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: const BorderSide(color: Color(0xFFE0D8CE)),
                      ),
                      onPressed: () {
                        setState(() {
                          _filterStatus = null;
                          _filterDuration = null;
                        });
                        Navigator.pop(ctx);
                      },
                      child: Text('Reset', style: AppTheme.sans(fontSize: 13, color: AppTheme.slateText)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              _filterStatus = tempStatus;
                              _filterDuration = tempDuration;
                            });
                            Navigator.pop(ctx);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Center(
                              child: Text(
                                'Apply Filters',
                                style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildStatusBadge(BookingStatus status) {
    final Color badgeBg;
    final Color badgeText;
    final String label;
    final IconData icon;

    switch (status) {
      case BookingStatus.pending:
        badgeBg = const Color(0xFFFFF3E0);
        badgeText = const Color(0xFFE65100);
        label = 'Pending';
        icon = Icons.access_time_rounded;
        break;
      case BookingStatus.accepted:
        badgeBg = const Color(0xFFE8F5E9);
        badgeText = const Color(0xFF2E7D32);
        label = 'Accepted';
        icon = Icons.check_circle_rounded;
        break;
      case BookingStatus.rejected:
        badgeBg = const Color(0xFFFFEBEE);
        badgeText = const Color(0xFFD32F2F);
        label = 'Rejected';
        icon = Icons.cancel_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: badgeText),
          const SizedBox(width: 3),
          Text(
            label,
            style: AppTheme.sans(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: badgeText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredBookings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Header Section ──────────────────────────────────────
        Container(
          color: AppTheme.creamBg,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Travel Buddy Branding & Notification Bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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

                  // Notification Bell with Orange Dot
                  GestureDetector(
                    onTap: widget.onNotificationTap,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE8E0D6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
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
                            top: 9,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
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
              const SizedBox(height: 12),

              // Heading & Subtitle
              Text(
                'Bookings',
                style: AppTheme.serif(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkNavy,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Manage travel guide requests from travellers.',
                style: AppTheme.sans(
                  fontSize: 12,
                  color: AppTheme.slateText,
                ),
              ),
              const SizedBox(height: 14),

              // ── Four Status Tabs ─────────────────────────────
              Container(
                height: 40,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE3),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: ['All', 'Pending', 'Accepted', 'Rejected'].map((tab) {
                    final isActive = _selectedTab == tab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = tab),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: isActive ? AppTheme.primaryGradient : null,
                            color: isActive ? null : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primaryRed.withValues(alpha: 0.25),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              tab,
                              style: AppTheme.sans(
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                                color: isActive ? Colors.white : AppTheme.darkNavy,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),

              // ── Search & Filter Row ──────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFE8E0D6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: AppTheme.lightSlate, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: AppTheme.sans(fontSize: 12.5, color: AppTheme.darkNavy),
                              onChanged: (v) => setState(() => _searchQuery = v),
                              decoration: InputDecoration(
                                hintText: 'Search by traveller, location or date...',
                                hintStyle: AppTheme.sans(fontSize: 11.5, color: AppTheme.lightSlate),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                              child: const Icon(Icons.close_rounded, size: 16, color: AppTheme.slateText),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filter Icon Button
                  GestureDetector(
                    onTap: _showFilterSheet,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (_filterStatus != null || _filterDuration != null)
                            ? const Color(0xFFFFF0EB)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: (_filterStatus != null || _filterDuration != null)
                              ? AppTheme.primaryOrange
                              : const Color(0xFFE8E0D6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune_rounded, color: AppTheme.primaryOrange, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        // ── Vertically Scrollable Booking Cards List ────────────
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.search_off_rounded, size: 50, color: AppTheme.lightSlate),
                      const SizedBox(height: 10),
                      Text(
                        'No matching bookings found',
                        style: AppTheme.serif(fontSize: 16, color: AppTheme.slateText),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Try adjusting your search or status filter.',
                        style: AppTheme.sans(fontSize: 11.5, color: AppTheme.lightSlate),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final item = filtered[i];
                    return _buildBookingCard(item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildBookingCard(BookingRecord b) {
    return GestureDetector(
      onTap: () => _openBookingDetails(b),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEDE5DC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Destination Photograph
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.asset(
                b.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFFAF7F3),
                  child: const Center(
                    child: Icon(Icons.landscape_rounded, size: 24, color: AppTheme.lightSlate),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),

          // Right side: All Card Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1: Destination Title & Status Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        b.destination,
                        style: AppTheme.serif(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkNavy,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    _buildStatusBadge(b.status),
                  ],
                ),
                const SizedBox(height: 3),

                // Row 2: Location & Relative Time
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 11, color: AppTheme.primaryOrange),
                    const SizedBox(width: 2.5),
                    Expanded(
                      child: Text(
                        b.location,
                        style: AppTheme.sans(fontSize: 10, color: AppTheme.slateText),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      b.timeAgo,
                      style: AppTheme.sans(fontSize: 9.5, color: AppTheme.lightSlate),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Row 3: Date, Traveller Count, Duration
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 10, color: AppTheme.iconOrange),
                      const SizedBox(width: 2.5),
                      Text(b.date, style: AppTheme.sans(fontSize: 9.5, color: AppTheme.slateText)),
                      const SizedBox(width: 6),
                      const Icon(Icons.people_outline_rounded, size: 10.5, color: AppTheme.iconOrange),
                      const SizedBox(width: 2.5),
                      Text('${b.travellers} Travellers', style: AppTheme.sans(fontSize: 9.5, color: AppTheme.slateText)),
                      const SizedBox(width: 6),
                      const Icon(Icons.access_time_rounded, size: 10, color: AppTheme.iconOrange),
                      const SizedBox(width: 2.5),
                      Text(b.duration, style: AppTheme.sans(fontSize: 9.5, color: AppTheme.slateText)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // Row 4: Traveller Profile + Actions (Inline)
                Row(
                  children: [
                    // Traveller avatar
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          b.traveller.isNotEmpty ? b.traveller[0] : 'T',
                          style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),

                    // Traveller Name + Rating
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            b.traveller,
                            style: AppTheme.sans(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkNavy,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, size: 10, color: Color(0xFFFFA000)),
                                const SizedBox(width: 1.5),
                                Text(
                                  '${b.rating} (${b.reviews})',
                                  style: AppTheme.sans(fontSize: 9, color: AppTheme.slateText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),

                    // Action buttons
                    if (b.status == BookingStatus.pending) ...[
                      // Reject Button
                      GestureDetector(
                        onTap: () => _rejectBooking(b),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8F3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFF0E5D8)),
                          ),
                          child: Text(
                            'Reject',
                            style: AppTheme.sans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF9E3D30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),

                      // Accept Button
                      GestureDetector(
                        onTap: () => _acceptBooking(b),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryRed.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      // View Details Button
                      GestureDetector(
                        onTap: () => _openBookingDetails(b),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE0D8CE)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Details',
                                style: AppTheme.sans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(width: 1),
                              const Icon(Icons.chevron_right_rounded, size: 12, color: AppTheme.darkNavy),
                            ],
                          ),
                        ),
                      ),
                    ],
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
}

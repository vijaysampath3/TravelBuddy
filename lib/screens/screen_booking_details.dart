import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'screen_bookings.dart';

class BookingDetailsScreen extends StatefulWidget {
  final BookingRecord booking;
  final ValueChanged<BookingStatus>? onStatusChanged;

  const BookingDetailsScreen({
    super.key,
    required this.booking,
    this.onStatusChanged,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late BookingStatus _currentStatus;
  late int _selectedTravellers;
  late String _selectedDuration;
  late String _selectedDate;
  late final TextEditingController _noteController;
  bool _showAllDestinations = false;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.booking.status;
    _selectedTravellers = widget.booking.travellers;
    _selectedDuration = widget.booking.duration.isNotEmpty
        ? widget.booking.duration
        : '1 – 3 Hours';
    _selectedDate = widget.booking.date;
    _noteController = TextEditingController(text: widget.booking.buddyNote ?? '');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _updateStatus(BookingStatus newStatus) {
    setState(() {
      _currentStatus = newStatus;
      widget.booking.status = newStatus;
    });
    widget.onStatusChanged?.call(newStatus);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 120)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryOrange,
              onPrimary: Colors.white,
              onSurface: AppTheme.darkNavy,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final formatted = '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      setState(() {
        _selectedDate = formatted;
      });
    }
  }

  void _showTravellersDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Number of Travellers',
                  style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(6, (index) {
              final count = index + 1;
              final label = count == 1 ? '1 (You + 1 Buddy)' : '$count (${count} Travellers)';
              final isSelected = _selectedTravellers == count;
              return ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
                leading: Icon(
                  Icons.person_outline_rounded,
                  color: isSelected ? AppTheme.primaryOrange : AppTheme.slateText,
                ),
                title: Text(
                  label,
                  style: AppTheme.sans(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryOrange, size: 20)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedTravellers = count;
                  });
                  Navigator.pop(ctx);
                },
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showDurationDialog() {
    final options = ['1 – 3 Hours', '3 – 5 Hours', 'Half Day', 'Full Day'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Travelling Time',
                  style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...options.map((opt) {
              final isSelected = _selectedDuration == opt;
              return ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: isSelected ? const Color(0xFFFFF3E0) : Colors.transparent,
                leading: Icon(
                  Icons.access_time_rounded,
                  color: isSelected ? AppTheme.primaryOrange : AppTheme.slateText,
                ),
                title: Text(
                  opt,
                  style: AppTheme.sans(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryOrange, size: 20)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedDuration = opt;
                  });
                  Navigator.pop(ctx);
                },
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showDestinationPreview(DestinationPlace dest) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: SizedBox(
                width: double.infinity,
                height: 190,
                child: Image.asset(
                  dest.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFFAF7F3),
                    child: const Center(
                      child: Icon(Icons.landscape_rounded, size: 40, color: AppTheme.lightSlate),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dest.name,
                    style: AppTheme.serif(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dest.description ?? 'Popular attraction in Visakhapatnam.',
                    style: AppTheme.sans(fontSize: 12.5, color: AppTheme.slateText, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Close', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.booking;
    final destinations = b.destinations.isNotEmpty
        ? b.destinations
        : [
            DestinationPlace(name: 'RK Beach', imagePath: 'assets/images/booking_rk_beach.png', description: 'Scenic beach promenade.'),
            DestinationPlace(name: 'Submarine Museum', imagePath: 'assets/images/booking_submarine.png', description: 'Historic INS Kursura submarine.'),
            DestinationPlace(name: 'Kailasagiri', imagePath: 'assets/images/booking_kailasagiri.png', description: 'Hilltop viewpoint over the bay.'),
            DestinationPlace(name: 'Araku Valley', imagePath: 'assets/images/booking_araku_hq.png', description: 'Lush hill station.'),
          ];

    final visibleDestinations = _showAllDestinations ? destinations : destinations.take(4).toList();
    final remainingCount = destinations.length > 4 ? destinations.length - 4 : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEDE5DC)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back_ios_new_rounded, size: 15, color: AppTheme.darkNavy),
                      ),
                    ),
                  ),

                  // Travel Buddy Branding
                  RichText(
                    text: TextSpan(
                      style: AppTheme.serif(fontSize: 20, fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(text: 'Travel ', style: TextStyle(color: AppTheme.primaryOrange)),
                        TextSpan(text: 'Buddy', style: TextStyle(color: AppTheme.darkNavy)),
                      ],
                    ),
                  ),

                  // Calendar Button
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEDE5DC)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.calendar_month_outlined, size: 18, color: AppTheme.primaryOrange),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable Body ─────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading & Subtitle
                    RichText(
                      text: TextSpan(
                        style: AppTheme.serif(fontSize: 24, fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(text: 'Booking ', style: TextStyle(color: AppTheme.darkNavy)),
                          TextSpan(text: 'Details', style: TextStyle(color: AppTheme.primaryOrange)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Review and customize your travel experience',
                      style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
                    ),
                    const SizedBox(height: 14),

                    // ── Card 1: Traveller Information ──────────────────
                    _buildTravellerCard(b),
                    const SizedBox(height: 12),

                    // ── Card 2: Destinations ────────────────────────────
                    _buildDestinationsCard(visibleDestinations, remainingCount),
                    const SizedBox(height: 12),

                    // ── Card 3: Number of Travellers ────────────────────
                    _buildTravellersCard(),
                    const SizedBox(height: 12),

                    // ── Card 4: Travelling Time ─────────────────────────
                    _buildTravellingTimeCard(),
                    const SizedBox(height: 12),

                    // ── Card 5: Booking Amount ──────────────────────────
                    _buildBookingAmountCard(b),
                    const SizedBox(height: 12),

                    // ── Card 6: Buddy Note ──────────────────────────────
                    _buildBuddyNoteCard(),
                    const SizedBox(height: 12),

                    // ── Card 7: Booking Status ──────────────────────────
                    _buildBookingStatusCard(b),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 1. Traveller Info Card ────────────────────────────────────────────────
  Widget _buildTravellerCard(BookingRecord b) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEDE5DC), width: 1.5),
            ),
            child: ClipOval(
              child: b.travellerAvatar != null
                  ? Image.asset(
                      b.travellerAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildInitialsAvatar(b),
                    )
                  : _buildInitialsAvatar(b),
            ),
          ),
          const SizedBox(width: 12),

          // Traveller Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  b.traveller,
                  style: AppTheme.serif(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkNavy,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(b.countryFlag, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      b.country,
                      style: AppTheme.sans(fontSize: 11, color: AppTheme.slateText),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFA000)),
                    const SizedBox(width: 3),
                    Text(
                      '${b.rating} (${b.reviews} reviews)',
                      style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Badge + Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHeaderStatusBadge(_currentStatus),
              const SizedBox(height: 4),
              Text(
                _currentStatus == BookingStatus.accepted
                    ? 'Confirmed ${b.timeAgo}'
                    : (_currentStatus == BookingStatus.pending
                        ? 'Requested ${b.timeAgo}'
                        : 'Declined ${b.timeAgo}'),
                style: AppTheme.sans(fontSize: 9.5, color: AppTheme.lightSlate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsAvatar(BookingRecord b) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Center(
        child: Text(
          b.traveller.isNotEmpty ? b.traveller[0] : 'T',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeaderStatusBadge(BookingStatus status) {
    final Color bg;
    final Color text;
    final String label;
    final IconData icon;

    switch (status) {
      case BookingStatus.accepted:
        bg = const Color(0xFFE8F5E9);
        text = const Color(0xFF2E7D32);
        label = 'Accepted';
        icon = Icons.check_circle_rounded;
        break;
      case BookingStatus.pending:
        bg = const Color(0xFFFFF3E0);
        text = const Color(0xFFE65100);
        label = 'Pending';
        icon = Icons.access_time_rounded;
        break;
      case BookingStatus.rejected:
        bg = const Color(0xFFFFEBEE);
        text = const Color(0xFFD32F2F);
        label = 'Rejected';
        icon = Icons.cancel_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: text),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.bold, color: text),
          ),
        ],
      ),
    );
  }

  // ── 2. Destinations Card ──────────────────────────────────────────────────
  Widget _buildDestinationsCard(List<DestinationPlace> destinations, int remainingCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              _buildSectionIcon(Icons.location_on_rounded),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destinations',
                      style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                    ),
                    Text(
                      'Select the places you want to visit.',
                      style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                    ),
                  ],
                ),
              ),
              if (remainingCount > 0)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAllDestinations = !_showAllDestinations;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _showAllDestinations ? 'Show less' : '+$remainingCount more',
                          style: AppTheme.sans(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkNavy,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          _showAllDestinations ? Icons.expand_less_rounded : Icons.chevron_right_rounded,
                          size: 14,
                          color: AppTheme.darkNavy,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Destination Thumbnails Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: destinations.map((dest) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _showDestinationPreview(dest),
                    child: Container(
                      width: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFEAE2D8)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                            child: SizedBox(
                              width: 68,
                              height: 46,
                              child: Image.asset(
                                dest.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: const Color(0xFFFAF7F3),
                                  child: const Center(
                                    child: Icon(Icons.landscape_rounded, size: 20, color: AppTheme.lightSlate),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                            child: Text(
                              dest.name,
                              style: AppTheme.sans(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkNavy,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── 3. Number of Travellers Card ──────────────────────────────────────────
  Widget _buildTravellersCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionIcon(Icons.people_rounded),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number of Travellers',
                    style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  Text(
                    'Total people for this booking',
                    style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: _showTravellersDialog,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F4EF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEDE5DC)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_outline_rounded, size: 17, color: Color(0xFF1976D2)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedTravellers == 1
                          ? '1 (You + 1 Buddy)'
                          : '$_selectedTravellers (${_selectedTravellers} Travellers)',
                      style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.darkNavy),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppTheme.darkNavy),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 4. Travelling Time Card ───────────────────────────────────────────────
  Widget _buildTravellingTimeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionIcon(Icons.access_time_rounded),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travelling Time',
                    style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  Text(
                    'Select how long you need a guide',
                    style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: _showDurationDialog,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F4EF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEDE5DC)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_rounded, size: 17, color: Color(0xFF1976D2)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedDuration,
                      style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.darkNavy),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppTheme.darkNavy),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 5. Booking Amount Card ────────────────────────────────────────────────
  Widget _buildBookingAmountCard(BookingRecord b) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionIcon(Icons.currency_rupee_rounded),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Amount',
                    style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  Text(
                    'Charges per hour for this travel buddy',
                    style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6EE),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF2E6DA)),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFECE0),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹ ${b.hourlyRate} / hour',
                      style: AppTheme.serif(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '(Charged by your travel buddy)',
                      style: AppTheme.sans(fontSize: 10, color: AppTheme.slateText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 6. Buddy Note Card ────────────────────────────────────────────────────
  Widget _buildBuddyNoteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSectionIcon(Icons.chat_bubble_outline_rounded),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buddy Note',
                    style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                  ),
                  Text(
                    'Add any special requests or preferences',
                    style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F4EF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEDE5DC)),
            ),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Color(0xFF1976D2)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    style: AppTheme.sans(fontSize: 11.5, color: AppTheme.darkNavy),
                    decoration: InputDecoration(
                      hintText: 'Add any special requests or preferences...',
                      hintStyle: AppTheme.sans(fontSize: 11, color: AppTheme.lightSlate),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (val) {
                      widget.booking.buddyNote = val;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 7. Booking Status Card ────────────────────────────────────────────────
  Widget _buildBookingStatusCard(BookingRecord b) {
    final Color iconColor;
    final IconData iconData;
    final String subtitle;
    final Color bannerBg;
    final Color bannerText;
    final String bannerMsg;

    switch (_currentStatus) {
      case BookingStatus.accepted:
        iconColor = const Color(0xFF2E7D32);
        iconData = Icons.check_circle_rounded;
        subtitle = 'Your booking has been accepted by ${b.traveller}.';
        bannerBg = const Color(0xFFE8F5E9);
        bannerText = const Color(0xFF2E7D32);
        bannerMsg = 'Confirmed for $_selectedDate';
        break;
      case BookingStatus.pending:
        iconColor = const Color(0xFFE65100);
        iconData = Icons.access_time_rounded;
        subtitle = 'Your booking request is awaiting confirmation.';
        bannerBg = const Color(0xFFFFF3E0);
        bannerText = const Color(0xFFE65100);
        bannerMsg = 'Pending confirmation for $_selectedDate';
        break;
      case BookingStatus.rejected:
        iconColor = const Color(0xFFD32F2F);
        iconData = Icons.cancel_rounded;
        subtitle = 'This booking request was declined.';
        bannerBg = const Color(0xFFFFEBEE);
        bannerText = const Color(0xFFD32F2F);
        bannerMsg = 'Declined for $_selectedDate';
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 17, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Status',
                      style: AppTheme.serif(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppTheme.darkNavy),
                    ),
                    Text(
                      subtitle,
                      style: AppTheme.sans(fontSize: 10.5, color: AppTheme.slateText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bannerBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Icon(iconData, size: 16, color: bannerText),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bannerMsg,
                    style: AppTheme.sans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: bannerText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // For Pending, also provide quick Accept/Reject actions
          if (_currentStatus == BookingStatus.pending) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: const BorderSide(color: Color(0xFFE53935)),
                    ),
                    onPressed: () => _updateStatus(BookingStatus.rejected),
                    child: Text(
                      'Decline',
                      style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFE53935)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _updateStatus(BookingStatus.accepted),
                    child: const Text(
                      'Accept',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppTheme.iconBoxBg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: AppTheme.primaryOrange),
    );
  }
}


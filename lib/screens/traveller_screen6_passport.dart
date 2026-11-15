import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'traveller_screen7_home.dart';

class TravellerPassportScreen extends StatefulWidget {
  final TravellerRegistrationData data;
  const TravellerPassportScreen({super.key, required this.data});

  @override
  State<TravellerPassportScreen> createState() => _TravellerPassportScreenState();
}

class _TravellerPassportScreenState extends State<TravellerPassportScreen> {
  late TextEditingController _passportCtrl;
  String _issuingCountry = 'India';
  DateTime _expiryDate = DateTime(2030, 12, 31);

  final List<Map<String, String>> _countries = [
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Singapore', 'flag': '🇸🇬'},
    {'name': 'UAE', 'flag': '🇦🇪'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Japan', 'flag': '🇯🇵'},
  ];

  @override
  void initState() {
    super.initState();
    _passportCtrl = TextEditingController(
      text: widget.data.passportNumber.isNotEmpty
          ? widget.data.passportNumber
          : 'ESP-9844210-A',
    );
    if (widget.data.issuingCountry.isNotEmpty) {
      _issuingCountry = widget.data.issuingCountry;
    }
    if (widget.data.passportExpiryDate != null) {
      _expiryDate = widget.data.passportExpiryDate!;
    }
  }

  @override
  void dispose() {
    _passportCtrl.dispose();
    super.dispose();
  }

  void _saveData() {
    widget.data.passportNumber = _passportCtrl.text.trim();
    widget.data.issuingCountry = _issuingCountry;
    widget.data.passportExpiryDate = _expiryDate;
    widget.data.isPassportVerified = true;
  }

  void _onComplete() {
    _saveData();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => TravellerHomeScreen(data: widget.data),
      ),
      (route) => false,
    );
  }

  void _onSkip() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => TravellerHomeScreen(data: widget.data),
      ),
      (route) => false,
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2045),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppTheme.primaryOrange,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _expiryDate = picked);
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5DDD5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Select Issuing Country', style: AppTheme.serif(fontSize: 18)),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _countries.length,
                itemBuilder: (_, i) {
                  final c = _countries[i];
                  final isSelected = c['name'] == _issuingCountry;
                  return ListTile(
                    leading: Text(c['flag']!, style: const TextStyle(fontSize: 22)),
                    title: Text(c['name']!, style: AppTheme.sans(fontSize: 14)),
                    trailing: isSelected
                        ? const Icon(Icons.check_rounded, color: AppTheme.primaryOrange)
                        : null,
                    onTap: () {
                      setState(() => _issuingCountry = c['name']!);
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final year = d.year.toString();
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _getCountryFlag(String country) {
    final found = _countries.firstWhere(
      (c) => c['name'] == country,
      orElse: () => {'name': country, 'flag': '🇮🇳'},
    );
    return found['flag'] ?? '🇮🇳';
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.data.fullName.isNotEmpty
        ? widget.data.fullName
        : 'Elena Rostova';

    return Scaffold(
      backgroundColor: AppTheme.creamBg,
      body: Column(
        children: [
          // ── 1. FULL-WIDTH PASSPORT HEADER ──────────────────────────────
          _buildPassportHeader(context),

          // 2. SCROLLABLE FORM SECTION
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF2EA),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFEEDCCA)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDC9566).withValues(alpha: 0.10),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0CDBE),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // STEP 2 OF 2 & Optional Security Scan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'STEP 2 OF 2',
                          style: AppTheme.sans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryOrange,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.shield_outlined,
                              size: 13,
                              color: AppTheme.primaryOrange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Optional Security Scan',
                              style: AppTheme.sans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.slateText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Passport Number (Optional)
                    Text(
                      'Passport Number (Optional)',
                      style: AppTheme.sans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9F3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEADBCE)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFDC9566).withValues(alpha: 0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppTheme.iconBoxBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.badge_outlined,
                              color: AppTheme.primaryOrange,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _passportCtrl,
                              style: AppTheme.sans(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkNavy,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ESP-9844210-A',
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Issuing Country & Expiry Date row
                    Row(
                      children: [
                        // Issuing Country
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Issuing Country',
                                style: AppTheme.sans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _showCountryPicker,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF9F3),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: const Color(0xFFEADBCE)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFDC9566).withValues(alpha: 0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _getCountryFlag(_issuingCountry),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _issuingCountry,
                                          style: AppTheme.sans(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkNavy,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18,
                                        color: AppTheme.slateText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Expiry Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry Date',
                                style: AppTheme.sans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _pickDate,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF9F3),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: const Color(0xFFEADBCE)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFDC9566).withValues(alpha: 0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppTheme.iconBoxBg,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.calendar_today_rounded,
                                          color: AppTheme.primaryOrange,
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _formatDate(_expiryDate),
                                          style: AppTheme.sans(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkNavy,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 18,
                                        color: AppTheme.slateText,
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
                    const SizedBox(height: 20),

                    // Security Information Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8F1),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFEEDCCA)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFDC9566).withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE8D6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.shield_rounded,
                                  color: Color(0xFFF59E0B),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  displayName,
                                  style: AppTheme.serif(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkNavy,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFA7F3D0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      size: 12,
                                      color: Color(0xFF10B981),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'KYC READY',
                                      style: AppTheme.sans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF047857),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Your passport details are encrypted and stored securely. You can update or skip passport verification anytime.',
                            style: AppTheme.sans(
                              fontSize: 11,
                              color: AppTheme.slateText,
                              height: 1.35,
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

          // 3. BOTTOM BUTTON: REFINED TO EXACT LABEL "SUBMIT"
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Container(
                height: 54,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryRed.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: _onComplete,
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: AppTheme.sans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Full-width passport header: photo fills the entire width, text sits on top
  /// with a carefully tuned gradient that keeps the photo visible.
  Widget _buildPassportHeader(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return SizedBox(
      width: double.infinity,
      // Height = safe-area top + fixed content height so it never clips
      height: topPad + 230,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Layer 1: Full-width background photograph ──
          Image.asset(
            'assets/images/passport_header_clean.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFF8B6914)),
          ),

          // ── Layer 2: Bottom-to-mid cream fade so form card blends in ──
          Positioned(
            left: 0, right: 0, bottom: 0,
            height: 90,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppTheme.creamBg.withValues(alpha: 0.85),
                      AppTheme.creamBg,
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // ── Layer 3: Left text-panel gradient — only 55% wide, stays
          //              semi-transparent so the photo shows through ──
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.0, 0.50, 0.75],
                    colors: [
                      const Color(0xFF1A1A1A).withValues(alpha: 0.55),
                      const Color(0xFF1A1A1A).withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Layer 4: Foreground content ──
          Positioned(
            left: 0, right: 0,
            top: topPad + 10,
            bottom: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + Skip row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.90),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: AppTheme.darkNavy,
                            size: 24,
                          ),
                        ),
                      ),
                      // Skip pill
                      GestureDetector(
                        onTap: _onSkip,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.90),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Skip',
                                style: AppTheme.sans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkNavy,
                                )),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward_rounded,
                                size: 14, color: AppTheme.primaryOrange),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // TRAVEL BUDDY tag
                  Row(
                    children: [
                      Container(
                        width: 3, height: 13,
                        color: AppTheme.primaryOrange,
                        margin: const EdgeInsets.only(right: 6),
                      ),
                      Text(
                        'TRAVEL BUDDY',
                        style: AppTheme.sans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Heading: Passport & Safety Verification
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Passport & \n',
                        style: AppTheme.serif(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                      TextSpan(
                        text: 'Safety ',
                        style: AppTheme.serif(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                      TextSpan(
                        text: 'Verification',
                        style: AppTheme.serif(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                          height: 1.15,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 8),

                  // Supporting description
                  Text(
                    'Passport verification is optional. Adding it earns a Verified Explorer Badge on your profile.',
                    style: AppTheme.sans(
                      fontSize: 11.5,
                      color: Colors.white.withValues(alpha: 0.90),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'traveller_screen5_duration.dart';

class TravellerPurposeScreen extends StatefulWidget {
  final TravellerRegistrationData data;
  const TravellerPurposeScreen({super.key, required this.data});

  @override
  State<TravellerPurposeScreen> createState() => _TravellerPurposeScreenState();
}

class _TravellerPurposeScreenState extends State<TravellerPurposeScreen> {
  String _selected = 'Leisure / Tourism';

  final List<_PurposeOption> _options = [
    _PurposeOption(
      label: 'Leisure / Tourism',
      icon: Icons.beach_access_rounded,
      iconColor: Color(0xFFFF5E36),
    ),
    _PurposeOption(
      label: 'Business / Corporate',
      icon: Icons.business_center_rounded,
      iconColor: Color(0xFF6366F1),
    ),
    _PurposeOption(
      label: 'Friends & Family',
      icon: Icons.people_outline_rounded,
      iconColor: Color(0xFF10B981),
    ),
    _PurposeOption(
      label: 'Medical Tourism',
      icon: Icons.local_hospital_outlined,
      iconColor: Color(0xFFEF4444),
    ),
    _PurposeOption(
      label: 'Education',
      icon: Icons.school_outlined,
      iconColor: Color(0xFFF59E0B),
    ),
    _PurposeOption(
      label: 'Other Purposes',
      icon: Icons.more_horiz_rounded,
      iconColor: Color(0xFF8B5CF6),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.data.travelPurpose.isNotEmpty
        ? widget.data.travelPurpose
        : 'Leisure / Tourism';
  }

  void _onContinue() {
    widget.data.travelPurpose = _selected;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerDurationScreen(data: widget.data),
      ),
    );
  }

  void _onSkip() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerDurationScreen(data: widget.data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFFAEEE2),
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          SizedBox(
            height: 260 + topPad,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 1. Full-width scenic background photograph
                Image.asset(
                  'assets/images/duration_header_clean.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) =>
                      Container(color: const Color(0xFF1A3557)),
                ),
                // 2. Bottom warm orange fade
                Positioned(
                  left: 0, right: 0, bottom: 0,
                  height: 110,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.5, 1.0],
                        colors: [
                          Colors.transparent,
                          Color(0xBBFFD4A8),
                          Color(0xFFFAEEE2),
                        ],
                      ),
                    ),
                  ),
                ),
                // 3. Left dark veil for text contrast
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        stops: const [0.0, 0.7],
                        colors: [
                          Colors.black.withValues(alpha: 0.28),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                // 4. Navigation row
                Positioned(
                  top: topPad + 12,
                  left: 16, right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.chevron_left_rounded,
                              color: AppTheme.darkNavy, size: 24),
                        ),
                      ),
                      GestureDetector(
                        onTap: _onSkip,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
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
                              const Icon(Icons.arrow_forward_rounded,
                                  size: 15, color: AppTheme.darkNavy),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 5. TRAVEL BUDDY branding
                Positioned(
                  top: topPad + 68,
                  left: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 3, height: 14,
                        margin: const EdgeInsets.only(right: 6),
                        color: AppTheme.primaryOrange,
                      ),
                      Text('TRAVEL BUDDY',
                          style: AppTheme.sans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          )),
                    ],
                  ),
                ),
                // 6. Heading
                Positioned(
                  top: topPad + 90,
                  left: 20, right: 90,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Hey! What brings\n',
                        style: AppTheme.serif(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'you here?',
                        style: AppTheme.serif(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                          height: 1.2,
                        ),
                      ),
                    ]),
                  ),
                ),
                // 7. Supporting description
                Positioned(
                  top: topPad + 162,
                  left: 20, right: 90,
                  child: Text(
                    'Help us understand your travel purpose\nso we can personalize your experience.',
                    style: AppTheme.sans(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.88),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Purpose Options
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                children: _options.map((opt) {
                  final isSelected = _selected == opt.label;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = opt.label),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFECE0)
                            : AppTheme.offWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryOrange
                              : AppTheme.softBorder,
                          width: isSelected ? 1.5 : 1,
                        ),
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
                          Container(
                            width: 42, height: 42,
                            decoration: BoxDecoration(
                              color: opt.iconColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(opt.icon, color: opt.iconColor, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(opt.label,
                              style: AppTheme.sans(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                              )),
                          ),
                          Container(
                            width: 22, height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppTheme.primaryOrange : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AppTheme.primaryOrange : AppTheme.softBorder,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, MediaQuery.of(context).padding.bottom + 14),
        decoration: const BoxDecoration(
          color: Color(0xFFFAEEE2),
          border: Border(top: BorderSide(color: Color(0xFFEDD5B8))),
        ),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryRed.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: _onContinue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue',
                    style: AppTheme.sans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PurposeOption {
  final String label;
  final IconData icon;
  final Color iconColor;
  const _PurposeOption({
    required this.label,
    required this.icon,
    required this.iconColor,
  });
}


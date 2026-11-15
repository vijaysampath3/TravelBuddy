import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'traveller_screen4_purpose.dart';

class TravellerPreferencesScreen extends StatefulWidget {
  final TravellerRegistrationData data;
  const TravellerPreferencesScreen({super.key, required this.data});

  @override
  State<TravellerPreferencesScreen> createState() => _TravellerPreferencesScreenState();
}

class _TravellerPreferencesScreenState extends State<TravellerPreferencesScreen> {
  List<String> _languagesKnown = [];
  int _ageMin = 18;
  int _ageMax = 45;
  String _preferredGender = '';
  String _buddyBackground = '';
  List<String> _interests = [];

  final List<String> _allLanguages = [
    'English', 'Hindi', 'Telugu', 'Tamil', 'Kannada', 'Malayalam',
    'Marathi', 'Bengali', 'Gujarati', 'Punjabi', 'Spanish', 'French',
    'German', 'Japanese', 'Mandarin', 'Arabic', 'Korean',
  ];

  final List<String> _allBackgrounds = [
    'Student', 'Professional', 'Local Expert', 'Retired', 'Artist', 'Entrepreneur',
  ];

  final List<String> _allInterests = [
    'History & Culture', 'Food & Cuisine', 'Adventure', 'Photography',
    'Shopping', 'Nature & Trekking', 'Nightlife', 'Art & Museums',
    'Street Food', 'Yoga & Wellness',
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    _languagesKnown = List.from(d.languagesKnown);
    _ageMin = d.preferredAgeMin;
    _ageMax = d.preferredAgeMax;
    _preferredGender = d.preferredGender;
    _buddyBackground = d.buddyBackground;
    _interests = List.from(d.interests);
  }

  void _saveToData() {
    widget.data.languagesKnown = _languagesKnown;
    widget.data.preferredAgeMin = _ageMin;
    widget.data.preferredAgeMax = _ageMax;
    widget.data.preferredGender = _preferredGender;
    widget.data.buddyBackground = _buddyBackground;
    widget.data.interests = _interests;
  }

  void _onContinue() {
    _saveToData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerPurposeScreen(data: widget.data),
      ),
    );
  }

  void _onSkip() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerPurposeScreen(data: widget.data),
      ),
    );
  }

  void _showLanguagesPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.85,
          builder: (_, controller) => Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5DDD5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Languages Known', style: AppTheme.serif(fontSize: 18)),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: _allLanguages.length,
                  itemBuilder: (_, i) {
                    final lang = _allLanguages[i];
                    final selected = _languagesKnown.contains(lang);
                    return CheckboxListTile(
                      value: selected,
                      activeColor: AppTheme.primaryOrange,
                      title: Text(lang, style: AppTheme.sans(fontSize: 14)),
                      onChanged: (v) {
                        setS(() {
                          if (v == true) {
                            _languagesKnown.add(lang);
                          } else {
                            _languagesKnown.remove(lang);
                          }
                        });
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSmallButton('Done', () => Navigator.pop(ctx)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAgePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5DDD5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text('Preferred Age Range', style: AppTheme.serif(fontSize: 18)),
              const SizedBox(height: 20),
              Text(
                '$_ageMin – $_ageMax years',
                style: AppTheme.sans(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryOrange),
              ),
              const SizedBox(height: 12),
              RangeSlider(
                values: RangeValues(_ageMin.toDouble(), _ageMax.toDouble()),
                min: 18,
                max: 70,
                divisions: 52,
                activeColor: AppTheme.primaryOrange,
                inactiveColor: const Color(0xFFEDE6DD),
                labels: RangeLabels('$_ageMin', '$_ageMax'),
                onChanged: (v) {
                  setS(() {
                    _ageMin = v.start.round();
                    _ageMax = v.end.round();
                  });
                  setState(() {
                    _ageMin = v.start.round();
                    _ageMax = v.end.round();
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildSmallButton('Done', () => Navigator.pop(ctx)),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenderPicker() {
    final options = ['Male', 'Female', 'No Preference'];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preferred Gender', style: AppTheme.serif(fontSize: 18)),
            const SizedBox(height: 16),
            ...options.map((opt) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(opt, style: AppTheme.sans(fontSize: 14)),
              trailing: _preferredGender == opt
                  ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryOrange)
                  : const Icon(Icons.radio_button_unchecked_rounded, color: Color(0xFFD1D5DB)),
              onTap: () {
                setState(() => _preferredGender = opt);
                Navigator.pop(ctx);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showBackgroundPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).padding.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buddy Background', style: AppTheme.serif(fontSize: 18)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _allBackgrounds.map((bg) {
                final selected = _buddyBackground == bg;
                return GestureDetector(
                  onTap: () {
                    setState(() => _buddyBackground = bg);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.iconBoxBg : AppTheme.inputBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected ? AppTheme.primaryOrange : AppTheme.softBorder,
                      ),
                    ),
                    child: Text(bg, style: AppTheme.sans(
                      fontSize: 13,
                      color: selected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                    )),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showInterestsPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).padding.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Interests', style: AppTheme.serif(fontSize: 18)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _allInterests.map((interest) {
                  final selected = _interests.contains(interest);
                  return GestureDetector(
                    onTap: () {
                      setS(() {
                        if (selected) {
                          _interests.remove(interest);
                        } else {
                          _interests.add(interest);
                        }
                      });
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: selected ? AppTheme.iconBoxBg : AppTheme.inputBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? AppTheme.primaryOrange : AppTheme.softBorder,
                        ),
                      ),
                      child: Text(interest, style: AppTheme.sans(
                        fontSize: 13,
                        color: selected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      )),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildSmallButton('Done', () => Navigator.pop(ctx)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: AppTheme.sans(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  String get _languageDisplay => _languagesKnown.isEmpty
      ? 'Choose the languages you\'re comfortable with'
      : _languagesKnown.join(', ');

  String get _ageDisplay => '$_ageMin – $_ageMax years';

  String get _genderDisplay =>
      _preferredGender.isEmpty ? 'Choose your preferred gender' : _preferredGender;

  String get _backgroundDisplay =>
      _buddyBackground.isEmpty ? 'Pick your buddy\'s background' : _buddyBackground;

  String get _interestsDisplay =>
      _interests.isEmpty ? 'Select common interests to match better' : _interests.join(', ');

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
                        text: 'Local Buddy\n',
                        style: AppTheme.serif(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'Preferences',
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
                    'Help us find the right buddy for you\nso we can personalize your experience.',
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

          // Preference Cards
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                children: [
                  _buildPreferenceCard(
                    icon: Icons.beach_access_rounded,
                    title: 'Languages Known',
                    subtitle: _languageDisplay,
                    onTap: _showLanguagesPicker,
                  ),
                  _buildPreferenceCard(
                    icon: Icons.person_outline_rounded,
                    title: 'Age',
                    subtitle: _ageDisplay,
                    onTap: _showAgePicker,
                  ),
                  _buildPreferenceCard(
                    icon: Icons.wc_rounded,
                    title: 'Gender',
                    subtitle: _genderDisplay,
                    onTap: _showGenderPicker,
                  ),
                  _buildPreferenceCard(
                    icon: Icons.work_outline_rounded,
                    title: 'Background',
                    subtitle: _backgroundDisplay,
                    onTap: _showBackgroundPicker,
                  ),
                  _buildPreferenceCard(
                    icon: Icons.favorite_outline_rounded,
                    title: 'Interests',
                    subtitle: _interestsDisplay,
                    onTap: _showInterestsPicker,
                    isLast: true,
                  ),
                ],
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

  Widget _buildPreferenceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.offWhite,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: AppTheme.iconBoxBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primaryOrange, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: AppTheme.sans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    )),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppTheme.slateText, size: 22),
          ],
        ),
      ),
    );
  }
}


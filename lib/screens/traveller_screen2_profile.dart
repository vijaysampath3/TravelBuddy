import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'traveller_screen3_preferences.dart';

class TravellerProfileScreen extends StatefulWidget {
  final TravellerRegistrationData data;
  const TravellerProfileScreen({super.key, required this.data});

  @override
  State<TravellerProfileScreen> createState() => _TravellerProfileScreenState();
}

class _TravellerProfileScreenState extends State<TravellerProfileScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _phoneCtrl;
  bool _obscurePassword = true;
  String _gender = '';
  bool _acceptedTerms = false;
  String _nationality = '';
  DateTime? _dob;
  String _countryCode = '+91';

  final List<String> _countries = [
    'India', 'United States', 'United Kingdom', 'Germany', 'France',
    'Australia', 'Canada', 'Japan', 'Singapore', 'UAE', 'Italy',
    'Spain', 'Brazil', 'China', 'South Korea', 'Netherlands', 'Sweden',
  ];

  final List<String> _countryCodes = [
    '+91', '+1', '+44', '+49', '+33', '+61', '+81', '+65', '+971', '+39',
    '+34', '+55', '+86', '+82', '+31', '+46', '+1-CA',
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    _nameCtrl = TextEditingController(text: d.fullName);
    _emailCtrl = TextEditingController(text: d.email);
    _passwordCtrl = TextEditingController(text: d.password);
    _phoneCtrl = TextEditingController(text: d.phoneNumber);
    _gender = d.gender;
    _acceptedTerms = d.acceptedTerms;
    _nationality = d.nationality;
    _dob = d.dateOfBirth;
    _countryCode = d.countryCode;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveToData() {
    widget.data.fullName = _nameCtrl.text;
    widget.data.email = _emailCtrl.text;
    widget.data.password = _passwordCtrl.text;
    widget.data.phoneNumber = _phoneCtrl.text;
    widget.data.gender = _gender;
    widget.data.acceptedTerms = _acceptedTerms;
    widget.data.nationality = _nationality;
    widget.data.dateOfBirth = _dob;
    widget.data.countryCode = _countryCode;
  }

  void _onContinue() {
    _saveToData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TravellerPreferencesScreen(data: widget.data),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 25),
      firstDate: DateTime(1940),
      lastDate: DateTime(now.year - 12),
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
    if (picked != null) setState(() => _dob = picked);
  }

  void _showNationalityPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.8,
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
              child: Text('Select Nationality', style: AppTheme.serif(fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: _countries.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(_countries[i], style: AppTheme.sans(fontSize: 14)),
                  trailing: _nationality == _countries[i]
                      ? const Icon(Icons.check_rounded, color: AppTheme.primaryOrange)
                      : null,
                  onTap: () {
                    setState(() => _nationality = _countries[i]);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    bool readOnly = false,
    VoidCallback? onTap,
    String? hint,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: label,
              style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: ' *',
              style: AppTheme.sans(fontSize: 13, color: AppTheme.primaryOrange),
            ),
          ]),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.inputBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.softBorder),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFDC9566).withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? _obscurePassword : false,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            style: AppTheme.sans(fontSize: 13.5),
            decoration: InputDecoration(
              hintText: hint ?? 'Enter ${label.toLowerCase()}',
              hintStyle: AppTheme.sans(fontSize: 13, color: AppTheme.lightSlate),
              prefixIcon: Icon(icon, color: AppTheme.primaryOrange, size: 20),
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
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
            height: 220 + topPad,
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
                // 4. Back button
                Positioned(
                  top: topPad + 12,
                  left: 16,
                  child: GestureDetector(
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
                  left: 20, right: 60,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Create Your\n',
                        style: AppTheme.serif(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: 'Traveller Profile',
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
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info Section Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.iconBoxBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.person_outline_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Basic Information',
                              style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text('Help us know you better',
                              style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Full Name
                  _buildField(
                    label: 'Full Name',
                    controller: _nameCtrl,
                    icon: Icons.person_outline_rounded,
                    hint: 'Enter your full name',
                  ),

                  // Email
                  _buildField(
                    label: 'Email Address',
                    controller: _emailCtrl,
                    icon: Icons.mail_outline_rounded,
                    hint: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // Password
                  _buildField(
                    label: 'Create Password',
                    controller: _passwordCtrl,
                    icon: Icons.lock_outline_rounded,
                    hint: 'Create a password',
                    isPassword: true,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppTheme.slateText,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),

                  // Nationality
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Nationality / Country',
                            style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' *',
                            style: AppTheme.sans(fontSize: 13, color: AppTheme.primaryOrange),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: _showNationalityPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppTheme.inputBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.softBorder),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.language_rounded, color: AppTheme.primaryOrange, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _nationality.isEmpty ? 'Select your country' : _nationality,
                                  style: AppTheme.sans(
                                    fontSize: 13.5,
                                    color: _nationality.isEmpty ? AppTheme.lightSlate : AppTheme.darkNavy,
                                  ),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.slateText),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),

                  // Date of Birth & Phone Number (side by side)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date of Birth
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Date of Birth',
                                  style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: AppTheme.sans(fontSize: 13, color: AppTheme.primaryOrange),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: _pickDate,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                decoration: BoxDecoration(
                                  color: AppTheme.inputBg,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppTheme.softBorder),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined, color: AppTheme.primaryOrange, size: 18),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        _dob == null
                                            ? 'Select date'
                                            : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                                        style: AppTheme.sans(
                                          fontSize: 12.5,
                                          color: _dob == null ? AppTheme.lightSlate : AppTheme.darkNavy,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Phone Number
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Phone Number',
                                  style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: AppTheme.sans(fontSize: 13, color: AppTheme.primaryOrange),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.inputBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppTheme.softBorder),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Country Code
                                  GestureDetector(
                                    onTap: () => _showCodePicker(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                      decoration: const BoxDecoration(
                                        border: Border(right: BorderSide(color: AppTheme.softBorder)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone_outlined, color: AppTheme.primaryOrange, size: 16),
                                          const SizedBox(width: 3),
                                          Text(_countryCode,
                                            style: AppTheme.sans(fontSize: 12, fontWeight: FontWeight.w600)),
                                          const Icon(Icons.arrow_drop_down, color: AppTheme.slateText, size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneCtrl,
                                      keyboardType: TextInputType.phone,
                                      style: AppTheme.sans(fontSize: 13),
                                      decoration: InputDecoration(
                                        hintText: 'Enter number',
                                        hintStyle: AppTheme.sans(fontSize: 12.5, color: AppTheme.lightSlate),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Gender
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Gender',
                            style: AppTheme.sans(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: ' *',
                            style: AppTheme.sans(fontSize: 13, color: AppTheme.primaryOrange),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildGenderChip('Male', Icons.male_rounded),
                          const SizedBox(width: 12),
                          _buildGenderChip('Female', Icons.female_rounded),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),

                  // Terms & Conditions
                  GestureDetector(
                    onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            color: _acceptedTerms ? AppTheme.primaryOrange : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: _acceptedTerms ? AppTheme.primaryOrange : const Color(0xFFD1D5DB),
                              width: 1.5,
                            ),
                          ),
                          child: _acceptedTerms
                              ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'I agree to the ',
                                style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: AppTheme.sans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryOrange,
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: AppTheme.sans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryOrange,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Continue Button
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

  Widget _buildGenderChip(String label, IconData icon) {
    final selected = _gender == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppTheme.iconBoxBg : AppTheme.inputBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppTheme.primaryOrange : AppTheme.softBorder,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                color: selected ? AppTheme.primaryOrange : AppTheme.slateText,
                size: 20),
              const SizedBox(width: 6),
              Text(label,
                style: AppTheme.sans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? AppTheme.primaryOrange : AppTheme.slateText,
                )),
            ],
          ),
        ),
      ),
    );
  }

  void _showCodePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: _countryCodes.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(_countryCodes[i], style: AppTheme.sans(fontSize: 14)),
            trailing: _countryCode == _countryCodes[i]
                ? const Icon(Icons.check_rounded, color: AppTheme.primaryOrange)
                : null,
            onTap: () {
              setState(() => _countryCode = _countryCodes[i]);
              Navigator.pop(ctx);
            },
          ),
        ),
      ),
    );
  }
}


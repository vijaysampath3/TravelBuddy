import 'package:flutter/material.dart';
import '../models/buddy_registration_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_indicator_widget.dart';
import 'screen5_dashboard.dart';

class Screen4ProfessionalDetails extends StatefulWidget {
  const Screen4ProfessionalDetails({super.key});

  @override
  State<Screen4ProfessionalDetails> createState() =>
      _Screen4ProfessionalDetailsState();
}

class _Screen4ProfessionalDetailsState
    extends State<Screen4ProfessionalDetails> {
  late TextEditingController _aboutMeController;

  final List<String> _cities = [
    'Visakhapatnam',
    'Hyderabad',
    'Vijayawada',
    'Tirupati',
    'Bengaluru',
    'Chennai',
    'Kochi',
    'Goa',
    'Mumbai',
  ];

  final List<String> _suggestedAreas = [
    'Rushikonda Beach',
    'Kailasagiri',
    'Bheemili Beach',
    'Dolphin\'s Nose',
    'Submarine Museum',
    'Tenneti Park',
  ];

  final List<String> _experienceOptions = [
    'Less than 1 Year',
    '1 – 3 Years',
    '3 – 5 Years',
    '5+ Years',
  ];

  final List<Map<String, dynamic>> _interestItems = [
    {'name': 'Beaches', 'icon': Icons.beach_access_rounded, 'color': Color(0xFFE65100)},
    {'name': 'Food', 'icon': Icons.restaurant_rounded, 'color': Color(0xFFD84315)},
    {'name': 'Heritage', 'icon': Icons.account_balance_outlined, 'color': Color(0xFF00897B)},
    {'name': 'Adventure', 'icon': Icons.terrain_rounded, 'color': Color(0xFF0288D1)},
    {'name': 'Nature', 'icon': Icons.eco_outlined, 'color': Color(0xFF43A047)},
    {'name': 'Photography', 'icon': Icons.photo_camera_outlined, 'color': Color(0xFFE64A19)},
    {'name': 'Culture', 'icon': Icons.theater_comedy_outlined, 'color': Color(0xFF8E24AA)},
    {'name': 'Night Life', 'icon': Icons.nightlight_round_outlined, 'color': Color(0xFF283593)},
  ];

  final List<String> _timeSlotOptions = [
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _aboutMeController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = RegistrationScope.of(context);
    if (_aboutMeController.text.isEmpty && data.aboutMe.isNotEmpty) {
      _aboutMeController.text = data.aboutMe;
    }
  }

  @override
  void dispose() {
    _aboutMeController.dispose();
    super.dispose();
  }

  void _showAddAreaDialog(BuddyRegistrationData data) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Add Covered Area',
          style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                style: AppTheme.sans(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Enter area name',
                  hintStyle: AppTheme.sans(color: AppTheme.lightSlate),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Suggestions:',
                style: AppTheme.sans(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.slateText),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _suggestedAreas
                    .where((a) => !data.areasCovered.contains(a))
                    .take(4)
                    .map((sug) => ActionChip(
                          label: Text(sug, style: AppTheme.sans(fontSize: 11)),
                          backgroundColor: const Color(0xFFFAF7F3),
                          onPressed: () {
                            data.addArea(sug);
                            Navigator.pop(ctx);
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTheme.sans(color: AppTheme.slateText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                data.addArea(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Add Area', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Scrollable Zero-Overflow City Picker
  void _showCityPicker(BuddyRegistrationData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select City',
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
            ),
            const Divider(height: 1, color: Color(0xFFEFE8DF)),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: _cities.map((city) {
                  final isSelected = data.city == city;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? AppTheme.primaryOrange : AppTheme.lightSlate,
                    ),
                    title: Text(
                      city,
                      style: AppTheme.sans(
                        fontSize: 14.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        data.city = city;
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Scrollable Zero-Overflow Experience Picker
  void _showExperiencePicker(BuddyRegistrationData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Guide Experience',
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
            ),
            const Divider(height: 1, color: Color(0xFFEFE8DF)),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: _experienceOptions.map((exp) {
                  final isSelected = data.guideExperience == exp;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? AppTheme.primaryOrange : AppTheme.lightSlate,
                    ),
                    title: Text(
                      exp,
                      style: AppTheme.sans(
                        fontSize: 14.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        data.guideExperience = exp;
                      });
                      Navigator.pop(ctx);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Scrollable Zero-Overflow Time Slot Picker
  void _showTimeSlotPicker(
    BuddyRegistrationData data,
    String day,
    bool isStart,
    String currentTime,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.60,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select ${isStart ? 'Start' : 'End'} Time ($day)',
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
            ),
            const Divider(height: 1, color: Color(0xFFEFE8DF)),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _timeSlotOptions.map((time) {
                    final isSelected = currentTime == time;
                    return ChoiceChip(
                      label: Text(time),
                      selected: isSelected,
                      selectedColor: AppTheme.primaryOrange.withValues(alpha: 0.18),
                      backgroundColor: const Color(0xFFFAF7F3),
                      labelStyle: AppTheme.sans(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? AppTheme.primaryOrange : AppTheme.darkNavy,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          if (isStart) {
                            data.updateDayTime(day, start: time);
                          } else {
                            data.updateDayTime(day, end: time);
                          }
                          Navigator.pop(ctx);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showAddTimeSlotDialog(String day) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Add Time Slot for $day', style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
        content: Text(
          'A secondary guiding slot has been enabled for $day. You can receive morning and evening bookings.',
          style: AppTheme.sans(fontSize: 13, color: AppTheme.slateText),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryOrange),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added extra slot for $day', style: AppTheme.sans(color: Colors.white)),
                  backgroundColor: AppTheme.darkNavy,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _onContinuePressed() {
    final data = RegistrationScope.of(context);
    data.aboutMe = _aboutMeController.text;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Screen5BuddyDashboard(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = RegistrationScope.of(context);

    return Scaffold(
      backgroundColor: AppTheme.creamBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              PartnerRegistrationHeader(
                onBack: () => Navigator.of(context).maybePop(),
              ),

              // Progress Indicator: Step 3 (Active)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RegistrationProgressIndicator(currentStep: 3),
              ),
              const SizedBox(height: 16),

              // Professional Details Content Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFEDE5DC)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title Row
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryOrange
                                    .withValues(alpha: 0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.work_outline_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Professional Details & Interests',
                                style: AppTheme.serif(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Tell us about your guiding experience and interests so travellers can find and connect with you.',
                                style: AppTheme.sans(
                                  fontSize: 11,
                                  color: AppTheme.slateText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // City Dropdown
                    _buildSectionHeader(
                      icon: Icons.location_on_outlined,
                      label: 'City',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () => _showCityPicker(data),
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF7F3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8E0D6)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.city,
                                style: AppTheme.sans(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppTheme.darkNavy,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Areas You Cover
                    _buildSectionHeader(
                      icon: Icons.menu_book_outlined,
                      label: 'Areas You Cover',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...data.areasCovered.map((area) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF7F3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFE8E0D6)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  area,
                                  style: AppTheme.sans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkNavy,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () => data.removeArea(area),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: AppTheme.slateText,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: () => _showAddAreaDialog(data),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.primaryOrange.withValues(alpha: 0.6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add_rounded,
                                  size: 15,
                                  color: AppTheme.primaryOrange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Add Area',
                                  style: AppTheme.sans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Interests & Activities
                    _buildSectionHeader(
                      icon: Icons.directions_walk_rounded,
                      label: 'Interests & Activities',
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _interestItems.map((item) {
                        final String name = item['name'];
                        final IconData icon = item['icon'];
                        final Color originalColor = item['color'];
                        final isSelected = data.selectedInterests.contains(name);

                        return GestureDetector(
                          onTap: () {
                          setState(() {});
                          data.toggleInterest(name);
                        },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFF4EE)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryOrange
                                    : const Color(0xFFE5DDD5),
                                width: isSelected ? 1.4 : 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  icon,
                                  size: 15,
                                  color: isSelected
                                      ? AppTheme.primaryOrange
                                      : originalColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  name,
                                  style: AppTheme.sans(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    color: isSelected
                                        ? AppTheme.primaryOrange
                                        : AppTheme.darkNavy,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),

                    // Guide Experience
                    _buildSectionHeader(
                      icon: Icons.workspace_premium_outlined,
                      label: 'Guide Experience',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () => _showExperiencePicker(data),
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF7F3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE8E0D6)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.guideExperience,
                                style: AppTheme.sans(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppTheme.darkNavy,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Availability
                    _buildSectionHeader(
                      icon: Icons.calendar_month_outlined,
                      label: 'Availability',
                      isRequired: true,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select the days and time slots when you are available to guide travellers.',
                      style: AppTheme.sans(
                        fontSize: 11,
                        color: AppTheme.slateText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Weekly Availability Schedule List (Zero-Overflow responsive design)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE8E0D6)),
                      ),
                      child: Column(
                        children: [
                          ...data.weeklyAvailability.keys.map((day) {
                            final avail = data.weeklyAvailability[day]!;
                            return _buildDayRow(data, day, avail);
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // About Me
                    _buildSectionHeader(
                      icon: Icons.description_outlined,
                      label: 'About Me',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE8E0D6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: _aboutMeController,
                            maxLines: 4,
                            maxLength: 500,
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              color: AppTheme.darkNavy,
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText:
                                  'Tell travellers about yourself, your guiding style, favourite places and what makes you a great local buddy.',
                              hintStyle: AppTheme.sans(
                                fontSize: 11.5,
                                color: AppTheme.lightSlate,
                                height: 1.35,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_aboutMeController.text.length}/500',
                            style: AppTheme.sans(
                              fontSize: 10,
                              color: AppTheme.lightSlate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Continue Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GradientButton(
                  text: 'Continue',
                  onPressed: _onContinuePressed,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String label,
    required bool isRequired,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppTheme.iconBoxBg,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(
            icon,
            color: AppTheme.iconOrange,
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppTheme.sans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkNavy,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: AppTheme.sans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryRed,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayRow(
    BuddyRegistrationData data,
    String day,
    DayAvailability avail,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Day Name
          SizedBox(
            width: 30,
            child: Text(
              day,
              style: AppTheme.sans(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkNavy,
              ),
            ),
          ),

          // Custom Orange Toggle Switch
          GestureDetector(
            onTap: () {
              data.updateDayAvailability(day, !avail.isEnabled);
            },
            child: Container(
              width: 34,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: avail.isEnabled
                    ? AppTheme.primaryOrange
                    : const Color(0xFFD1D5DB),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 150),
                alignment: avail.isEnabled
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Time Slots or Not Available
          if (avail.isEnabled) ...[
            Expanded(
              child: Row(
                children: [
                  // Start Time Pill
                  Expanded(
                    child: _buildTimePill(
                      time: avail.startTime,
                      onTap: () => _showTimeSlotPicker(data, day, true, avail.startTime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'to',
                      style: AppTheme.sans(
                        fontSize: 10,
                        color: AppTheme.slateText,
                      ),
                    ),
                  ),
                  // End Time Pill
                  Expanded(
                    child: _buildTimePill(
                      time: avail.endTime,
                      onTap: () => _showTimeSlotPicker(data, day, false, avail.endTime),
                    ),
                  ),
                  const SizedBox(width: 5),
                  // + button
                  GestureDetector(
                    onTap: () => _showAddTimeSlotDialog(day),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFDDD5CA)),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 14,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  'Not available',
                  style: AppTheme.sans(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.lightSlate,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimePill({
    required String time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2D7CC)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 11,
                color: AppTheme.slateText,
              ),
              const SizedBox(width: 3),
              Text(
                time,
                style: AppTheme.sans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkNavy,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 13,
                color: AppTheme.darkNavy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

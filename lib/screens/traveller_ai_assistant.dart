import 'dart:async';
import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';

class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  _ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class TravellerAiAssistantScreen extends StatefulWidget {
  final TravellerRegistrationData data;

  const TravellerAiAssistantScreen({
    super.key,
    required this.data,
  });

  @override
  State<TravellerAiAssistantScreen> createState() => _TravellerAiAssistantScreenState();
}

class _TravellerAiAssistantScreenState extends State<TravellerAiAssistantScreen> {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<_ChatMessage> _messages = [];
  final Set<String> _addedTripItems = {};
  final Set<String> _wishlistItems = {};
  bool _isTyping = false;
  String _selectedLocation = 'Visakhapatnam';
  int _selectedNavIndex = 0;

  // Predefined prompt responses for Visakhapatnam travel
  final Map<String, String> _quickActionResponses = {
    'Best beaches':
        'Here are the top beaches in Visakhapatnam:\n\n'
        '🏖️ Rushikonda Beach — Golden sands, water surfing, kayaking & Blue Flag certified.\n\n'
        '🌊 Ramakrishna (RK) Beach — Scenic promenade, INS Kursura Submarine Museum & bustling evening street food.\n\n'
        '🌴 Yarada Beach — Serene paradise framed by majestic green hills & tranquil turquoise waves.\n\n'
        'Would you like cab fares or directions to any of these?',
    'Must visit places':
        'Top must-visit landmarks in Visakhapatnam:\n\n'
        '1. ⚓ INS Kursura Submarine Museum — World-famous decommissioned submarine on RK Beach.\n\n'
        '2. 🚠 Kailasagiri Hilltop — Ropeway ride offering 360° panoramic coastline views.\n\n'
        '3. 🛕 Sri Varaha Lakshmi Narasimha Temple (Simhachalam) — Sacred 11th-century architectural wonder.\n\n'
        '4. 🐬 Dolphin\'s Nose & Lighthouse — Dramatic rocky headland 358m above sea level.\n\n'
        'Tap "+ Add to Trip" on any destination to bookmark it!',
    'Plan itinerary':
        'Here is a curated 1-Day Best of Visakhapatnam Itinerary:\n\n'
        '🌅 08:30 AM — Morning ropeway up to Kailasagiri Hilltop\n'
        '🏖️ 11:00 AM — Water sports & beach walk at Rushikonda\n'
        '🍛 01:30 PM — Authentic coastal Andhra seafood lunch at Sea Inn\n'
        '⚓ 03:30 PM — Guided tour of INS Kursura & TU 142 Aircraft Museum\n'
        '🌇 05:30 PM — Sunset stroll along RK Beach promenade\n\n'
        'Would you like me to connect you with a verified local buddy for this route?',
    'Show cab fare':
        'Estimated transport fares from Visakhapatnam City Center:\n\n'
        '🚕 Rushikonda Beach (12 km) — ₹280 - ₹340 (Cab) | ₹160 (Auto)\n'
        '🚕 Kailasagiri (9 km) — ₹220 - ₹260 (Cab) | ₹120 (Auto)\n'
        '🚕 INS Kursura (16 km) — ₹300 - ₹360 (Cab) | ₹180 (Auto)\n'
        '🚕 Yarada Beach (18 km) — ₹420 - ₹480 (Cab)\n'
        '🚕 Araku Valley Day Rental (115 km) — ₹2,800 - ₹3,500\n\n'
        'All fares are approximate standard city rates.',
    'Food recommendations':
        'Must-try culinary delights in Visakhapatnam:\n\n'
        '🍛 Raju Gari Dhaba (Rushikonda) — Famous Andhra spicy prawn roast & chicken fry\n\n'
        '🐟 Sea Inn — Authentic home-style coastal seafood curry\n\n'
        '🥞 Sai Ram Parlour (Diamond Park) — Legendary Ghee Podi Dosa & filter coffee\n\n'
        '🌊 Bamboo Bay (The Park) — Oceanfront fine dining with live coastal barbecue\n\n'
        'Are you craving vegetarian, spicy Andhra, or coastal seafood?',
    'Find travel buddies':
        'Here are verified Travel Buddies currently in Visakhapatnam:\n\n'
        '👋 Sneha R. (Solo Explorer) — Visiting Rushikonda & Kailasagiri today\n'
        '📸 Rahul K. (Photography Lover) — Exploring beach road & heritage harbor\n'
        '🧭 Vikram M. (Local Guide) — Organizing coastal walking tour\n\n'
        'You can visit the Buddies tab below to send a connect request!',
  };

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage(String query) {
    final text = query.trim();
    if (text.isEmpty) return;

    _textCtrl.clear();
    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });

    _scrollToBottom();

    Timer(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      final reply = _generateReply(text);
      setState(() {
        _isTyping = false;
        _messages.add(_ChatMessage(text: reply, isUser: false));
      });
      _scrollToBottom();
    });
  }

  String _generateReply(String prompt) {
    if (_quickActionResponses.containsKey(prompt)) {
      return _quickActionResponses[prompt]!;
    }

    final lower = prompt.toLowerCase();
    if (lower.contains('beach') || lower.contains('sea') || lower.contains('ocean')) {
      return _quickActionResponses['Best beaches']!;
    } else if (lower.contains('itinerary') || lower.contains('plan') || lower.contains('schedule') || lower.contains('day')) {
      return _quickActionResponses['Plan itinerary']!;
    } else if (lower.contains('cab') || lower.contains('taxi') || lower.contains('fare') || lower.contains('cost') || lower.contains('auto') || lower.contains('price')) {
      return _quickActionResponses['Show cab fare']!;
    } else if (lower.contains('food') || lower.contains('restaurant') || lower.contains('eat') || lower.contains('dinner') || lower.contains('lunch') || lower.contains('cafe')) {
      return _quickActionResponses['Food recommendations']!;
    } else if (lower.contains('buddy') || lower.contains('friend') || lower.contains('companion') || lower.contains('guide')) {
      return _quickActionResponses['Find travel buddies']!;
    } else if (lower.contains('rushikonda')) {
      return 'Rushikonda Beach is located about 12 km from city center. It is ideal for water sports, surfing, and speed boating. Entry is free. Would you like to add it to your trip?';
    } else if (lower.contains('kursura') || lower.contains('submarine')) {
      return 'INS Kursura Submarine Museum is on RK Beach road. Visiting hours: 2:00 PM – 8:30 PM (closed on Mondays). Ticket: ₹40 adults, ₹20 children.';
    }

    return 'I\'d be happy to help with that in Visakhapatnam! You can explore top beaches like Rushikonda, visit INS Kursura Submarine, check cab fares, or connect with verified travel buddies.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent + 140,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleTripItem(String placeName) {
    setState(() {
      if (_addedTripItems.contains(placeName)) {
        _addedTripItems.remove(placeName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed $placeName from your trip', style: AppTheme.sans(color: Colors.white)),
            backgroundColor: AppTheme.darkNavy,
            duration: const Duration(milliseconds: 1200),
          ),
        );
      } else {
        _addedTripItems.add(placeName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added $placeName to your trip! 🎉', style: AppTheme.sans(color: Colors.white)),
            backgroundColor: AppTheme.primaryOrange,
            duration: const Duration(milliseconds: 1400),
          ),
        );
      }
    });
  }

  void _toggleWishlist(String placeName) {
    setState(() {
      if (_wishlistItems.contains(placeName)) {
        _wishlistItems.remove(placeName);
      } else {
        _wishlistItems.add(placeName);
      }
    });
  }

  void _openLocationSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF2EA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.softBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Select Destination Area',
              style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            ...['Visakhapatnam', 'Araku Valley', 'Bheemili Beach', 'Simhachalam'].map(
              (city) => ListTile(
                leading: Icon(
                  Icons.location_on_rounded,
                  color: _selectedLocation == city ? AppTheme.primaryOrange : AppTheme.slateText,
                ),
                title: Text(
                  city,
                  style: AppTheme.sans(
                    fontSize: 14,
                    fontWeight: _selectedLocation == city ? FontWeight.bold : FontWeight.w500,
                    color: _selectedLocation == city ? AppTheme.primaryOrange : AppTheme.darkNavy,
                  ),
                ),
                trailing: _selectedLocation == city
                    ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryOrange)
                    : null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  setState(() => _selectedLocation = city);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSafetySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF2EA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.softBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFECEB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shield_rounded, color: Color(0xFFE53935), size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Emergency & Safety Hub', style: AppTheme.serif(fontSize: 17, fontWeight: FontWeight.bold)),
                      Text('Vizag Tourist Police & 24/7 Helpline', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(backgroundColor: Color(0xFFFFEAE6), child: Icon(Icons.sos_rounded, color: Color(0xFFE53935))),
              title: Text('Tourist Police Patrol (RK Beach)', style: AppTheme.sans(fontSize: 13.5, fontWeight: FontWeight.bold)),
              subtitle: Text('Toll Free: 112 / 100', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935), elevation: 0),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Call Now', style: AppTheme.sans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAEEE2),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          controller: _scrollCtrl,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TOP HEADER & MASCOT HERO BANNER
              _buildHeroHeader(),

              const SizedBox(height: 12),

              // 2. AI ASSISTANT INTRODUCTION CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildIntroCard(),
              ),

              const SizedBox(height: 14),

              // 3. 6 QUICK ACTION BUTTONS (2-Column Grid)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildQuickActionsGrid(),
              ),

              const SizedBox(height: 18),

              // 4. POPULAR PLACES IN VISAKHAPATNAM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildPopularPlacesSection(),
              ),

              const SizedBox(height: 16),

              // 5. CHAT INPUT SECTION (Naturally positioned with proper margins, not fixed!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildChatInputBar(),
              ),

              // 6. CHAT CONVERSATION STREAM (if user starts chatting)
              if (_messages.isNotEmpty || _isTyping) ...[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Conversation',
                        style: AppTheme.serif(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkNavy,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildChatStream(),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // 1. TOP HERO HEADER
  Widget _buildHeroHeader() {
    return Stack(
      children: [
        // Background Scenic Photograph with gradient
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/duration_header_clean.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (ctx, err, stack) => Image.asset(
                    'assets/images/beach_card.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.black.withValues(alpha: 0.22),
                        const Color(0xFFFAEEE2).withValues(alpha: 0.85),
                        const Color(0xFFFAEEE2),
                      ],
                      stops: const [0.0, 0.48, 0.86, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Header Controls & Title overlay
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top navigation row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppTheme.darkNavy,
                        size: 20,
                      ),
                    ),
                  ),

                  // Travel Buddy Branding
                  Text(
                    'Travel Buddy',
                    style: AppTheme.serif(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // Menu 3 dots button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Travel Buddy AI Assistant v2.0 (Vizag Guide)', style: AppTheme.sans(color: Colors.white)),
                          backgroundColor: AppTheme.darkNavy,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: AppTheme.darkNavy,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // Title, Subtitle, Location Selector & Mascot DP Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Left: Titles and location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Travel Buddy AI',
                          style: AppTheme.serif(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ).copyWith(
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.60),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your Personal Travel Assistant',
                          style: AppTheme.sans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFF1E4),
                          ).copyWith(
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.55),
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),

                        // Location chip pill
                        GestureDetector(
                          onTap: _openLocationSelector,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.94),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppTheme.softBorder),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFDC9566).withValues(alpha: 0.12),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: AppTheme.primaryOrange,
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    _selectedLocation,
                                    style: AppTheme.sans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.darkNavy,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppTheme.darkNavy,
                                  size: 17,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Right: Mascot DP
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC9566).withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/ai_avatar.png',
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Image.asset(
                          'assets/images/travel_buddy_mascot.png',
                          fit: BoxFit.cover,
                        ),
                      ),
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

  // 2. AI ASSISTANT INTRODUCTION CARD
  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.softBorder.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC9566).withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mascot Avatar Circle (AI DP)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFD4BE), width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryOrange.withValues(alpha: 0.18),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/ai_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Image.asset(
                  'assets/images/travel_buddy_mascot.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Greeting & Intro text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi! 👋',
                  style: AppTheme.serif(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkNavy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Tell me what you want to explore in Visakhapatnam. I can suggest places, itineraries, transport options and even find local travel buddies for you.',
                  style: AppTheme.sans(
                    fontSize: 11.5,
                    height: 1.45,
                    color: const Color(0xFF55524E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. QUICK ACTION BUTTONS (6 Cards in 2 columns)
  Widget _buildQuickActionsGrid() {
    final quickActions = [
      _QuickActionData(
        title: 'Best beaches',
        icon: Icons.beach_access_rounded,
      ),
      _QuickActionData(
        title: 'Must visit places',
        icon: Icons.map_outlined,
      ),
      _QuickActionData(
        title: 'Plan itinerary',
        icon: Icons.calendar_month_rounded,
      ),
      _QuickActionData(
        title: 'Show cab fare',
        icon: Icons.directions_car_rounded,
      ),
      _QuickActionData(
        title: 'Food recommendations',
        icon: Icons.restaurant_rounded,
      ),
      _QuickActionData(
        title: 'Find travel buddies',
        icon: Icons.people_alt_rounded,
      ),
    ];

    return Column(
      children: [
        for (int row = 0; row < quickActions.length; row += 2) ...[
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(quickActions[row]),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionCard(quickActions[row + 1]),
              ),
            ],
          ),
          if (row + 2 < quickActions.length) const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildQuickActionCard(_QuickActionData action) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _sendMessage(action.title),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9F3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppTheme.softBorder.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECE0),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  action.icon,
                  color: const Color(0xFFE65100),
                  size: 17,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  action.title,
                  style: AppTheme.sans(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkNavy,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. POPULAR PLACES SECTION
  Widget _buildPopularPlacesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading & View All link (Overflow Safe)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Popular Places in Visakhapatnam',
                style: AppTheme.serif(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkNavy,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _sendMessage('Must visit places'),
              child: Text(
                'View All →',
                style: AppTheme.sans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryOrange,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Two Cards Side-by-Side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARD 1: Rushikonda Beach
            Expanded(
              child: _buildPlaceCard(
                name: 'Rushikonda Beach',
                imagePath: 'assets/images/booking_rushikonda.png',
                rating: '4.6 (2.1K reviews)',
                distance: '20 min • 12 km',
              ),
            ),

            const SizedBox(width: 10),

            // CARD 2: INS Kursura Museum
            Expanded(
              child: _buildPlaceCard(
                name: 'INS Kursura Museum',
                imagePath: 'assets/images/booking_submarine.png',
                rating: '4.5 (1.8K reviews)',
                distance: '25 min • 16 km',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceCard({
    required String name,
    required String imagePath,
    required String rating,
    required String distance,
  }) {
    final isAdded = _addedTripItems.contains(name);
    final isWishlisted = _wishlistItems.contains(name);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.softBorder.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC9566).withValues(alpha: 0.10),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Wishlist Heart button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    height: 100,
                    color: AppTheme.iconBoxBg,
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: AppTheme.slateText),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: GestureDetector(
                  onTap: () => _toggleWishlist(name),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.90),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isWishlisted ? AppTheme.primaryRed : const Color(0xFF757575),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  name,
                  style: AppTheme.serif(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkNavy,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Rating
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 14),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        rating,
                        style: AppTheme.sans(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkNavy,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3),

                // Distance
                Row(
                  children: [
                    const Icon(Icons.directions_car_rounded, color: AppTheme.slateText, size: 12),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        distance,
                        style: AppTheme.sans(
                          fontSize: 10,
                          color: AppTheme.slateText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // "+ Add to Trip" Button
                GestureDetector(
                  onTap: () => _toggleTripItem(name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    decoration: BoxDecoration(
                      gradient: isAdded
                          ? const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF388E3C)])
                          : const LinearGradient(colors: [Color(0xFFFF5E36), Color(0xFFE53935)]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: (isAdded ? Colors.green : AppTheme.primaryRed).withValues(alpha: 0.28),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        isAdded ? '✓ Added' : '+ Add to Trip',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.sans(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. CHAT CONVERSATION STREAM
  Widget _buildChatStream() {
    return Column(
      children: [
        for (final msg in _messages) ...[
          if (msg.isUser)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12, left: 40),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5E36), Color(0xFFE53935)],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryRed.withValues(alpha: 0.22),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  msg.text,
                  style: AppTheme.sans(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(top: 2, right: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFFFD4BE), width: 1.2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/ai_avatar.png',
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Image.asset(
                            'assets/images/travel_buddy_mascot.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9F3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                          border: Border.all(color: AppTheme.softBorder),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          msg.text,
                          style: AppTheme.sans(
                            fontSize: 12,
                            height: 1.45,
                            color: AppTheme.darkNavy,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],

        // Typing indicator
        if (_isTyping)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12, left: 40),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9F3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.softBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Travel Buddy AI is thinking...',
                    style: AppTheme.sans(fontSize: 11.5, color: AppTheme.slateText),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // 6. CHAT INPUT BAR
  Widget _buildChatInputBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppTheme.softBorder),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC9566).withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Magic Wand / Spark Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECE0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppTheme.primaryOrange,
              size: 16,
            ),
          ),

          const SizedBox(width: 8),

          // Text Field with clean placeholder
          Expanded(
            child: TextField(
              controller: _textCtrl,
              focusNode: _focusNode,
              onSubmitted: _sendMessage,
              style: AppTheme.sans(
                fontSize: 12.5,
                color: AppTheme.darkNavy,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Ask me anything about Visakhapatnam...',
                hintStyle: AppTheme.sans(
                  fontSize: 11.5,
                  color: const Color(0xFF9E9E9E),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),

          // Microphone Icon (UI Only)
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Listening... (Speech input simulated)', style: AppTheme.sans(color: Colors.white)),
                  backgroundColor: AppTheme.primaryOrange,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: const Icon(
                Icons.mic_rounded,
                color: Color(0xFF1E3A8A),
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 4),

          // Send Button
          GestureDetector(
            onTap: () => _sendMessage(_textCtrl.text),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF5E36), Color(0xFFE53935)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryRed.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. BOTTOM NAVIGATION BAR
  Widget _buildBottomBar() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Custom Curved Notched Pill Container
              CustomPaint(
                size: const Size(double.infinity, 64),
                painter: const _CurvedNotchedPillPainter(
                  backgroundColor: Color(0xFFF7ECE1),
                  borderColor: Color(0xFFEEDCCA),
                ),
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
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

                      // Center gap for SOS shield button
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
              ),

              // Central Emergency / Safety Button with Shield
              Positioned(
                top: -14,
                child: GestureDetector(
                  onTap: _showSafetySheet,
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
      onTap: () {
        if (index == 0) {
          Navigator.pop(context);
        } else {
          setState(() => _selectedNavIndex = index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Switched to $label tab', style: AppTheme.sans(color: Colors.white)),
              backgroundColor: AppTheme.darkNavy,
              duration: const Duration(milliseconds: 800),
            ),
          );
        }
      },
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
}

class _QuickActionData {
  final String title;
  final IconData icon;

  const _QuickActionData({
    required this.title,
    required this.icon,
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
    final r = h / 2;
    final cx = w / 2;

    const double notchRadius = 32.0;
    const double s = 14.0;

    final path = Path();
    path.moveTo(r, 0);

    path.lineTo(cx - notchRadius - s, 0);

    path.cubicTo(
      cx - notchRadius - 4, 0,
      cx - notchRadius + 2, 25,
      cx, 25,
    );

    path.cubicTo(
      cx + notchRadius - 2, 25,
      cx + notchRadius + 4, 0,
      cx + notchRadius + s, 0,
    );

    path.lineTo(w - r, 0);

    path.arcToPoint(
      Offset(w - r, h),
      radius: Radius.circular(r),
      clockwise: true,
    );

    path.lineTo(r, h);

    path.arcToPoint(
      Offset(r, 0),
      radius: Radius.circular(r),
      clockwise: true,
    );

    path.close();

    canvas.drawShadow(
      path,
      const Color(0xFFDC9566).withValues(alpha: 0.18),
      12,
      false,
    );

    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

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

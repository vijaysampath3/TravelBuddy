import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'screen1_login.dart';

class OnboardingSlide {
  final String prefixWord;
  final String highlightWord;
  final String cardTitle;
  final String cardDescription;
  final IconData icon;
  final String imagePath;
  final String fallbackImagePath;

  const OnboardingSlide({
    required this.prefixWord,
    required this.highlightWord,
    required this.cardTitle,
    required this.cardDescription,
    required this.icon,
    required this.imagePath,
    required this.fallbackImagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<OnboardingSlide> _slides = [
    OnboardingSlide(
      prefixWord: 'Discover',
      highlightWord: 'Places',
      cardTitle: 'Discover Places',
      cardDescription: 'Find beautiful beaches, viewpoints and local favourites.',
      icon: Icons.location_on_rounded,
      imagePath: 'assets/images/onboarding_discover.png',
      fallbackImagePath: 'assets/images/onboarding_clean_1.png',
    ),
    OnboardingSlide(
      prefixWord: 'Connect',
      highlightWord: 'Locals',
      cardTitle: 'Connect Locals',
      cardDescription: 'Meet trusted locals and discover real stories.',
      icon: Icons.people_alt_rounded,
      imagePath: 'assets/images/onboarding_connect.png',
      fallbackImagePath: 'assets/images/onboarding_clean_2.png',
    ),
    OnboardingSlide(
      prefixWord: 'Plan',
      highlightWord: 'Trips',
      cardTitle: 'Plan Trips',
      cardDescription: 'Build your itinerary with places, stays, transport and more.',
      icon: Icons.calendar_month_rounded,
      imagePath: 'assets/images/onboarding_plan.png',
      fallbackImagePath: 'assets/images/onboarding_clean_3.png',
    ),
    OnboardingSlide(
      prefixWord: 'Travel',
      highlightWord: 'Safe',
      cardTitle: 'Travel Safe',
      cardDescription: 'Get helpful guidance and travel with confidence.',
      icon: Icons.gpp_good_rounded,
      imagePath: 'assets/images/onboarding_safe.png',
      fallbackImagePath: 'assets/images/onboarding_clean_4.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const Screen1Login()),
    );
  }

  void _onNextPressed() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      body: Stack(
        children: [
          // ── Horizontal Slides ─────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return _buildSlidePage(slide);
            },
          ),

          // ── Bottom Navigation Controls ────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Skip Button
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        color: Colors.transparent,
                        child: Text(
                          'Skip',
                          style: AppTheme.sans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.slateText,
                          ),
                        ),
                      ),
                    ),

                    // 4 Pagination Indicators
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(_slides.length, (i) {
                        final isActive = _currentPage == i;
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 7.5,
                            height: 7.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? AppTheme.primaryOrange
                                  : const Color(0xFFE2D6CB),
                            ),
                          ),
                        );
                      }),
                    ),

                    // Circular Next Arrow Button
                    GestureDetector(
                      onTap: _onNextPressed,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryRed.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidePage(OnboardingSlide slide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // ── Background Photograph ───────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: constraints.maxHeight * 0.88,
              child: Image.asset(
                slide.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Image.asset(
                  slide.fallbackImagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // ── Subtle Cream Blend only at bottom bar ───────────────
            Positioned(
              top: constraints.maxHeight * 0.82,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.45, 1.0],
                    colors: [
                      const Color(0xFFFBF8F4).withValues(alpha: 0.0),
                      const Color(0xFFFBF8F4).withValues(alpha: 0.85),
                      const Color(0xFFFBF8F4),
                    ],
                  ),
                ),
              ),
            ),

            // ── Top Header Text & Content ───────────────────────────
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),

                    // Travel Buddy Tag
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 22,
                          height: 2.5,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TRAVEL BUDDY',
                          style: AppTheme.sans(
                            fontSize: 10,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF5A4D42),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Large Serif Heading
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${slide.prefixWord}\n',
                            style: AppTheme.serif(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkNavy,
                              height: 1.08,
                            ),
                          ),
                          TextSpan(
                            text: slide.highlightWord,
                            style: AppTheme.serif(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryOrange,
                              height: 1.08,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── Floating Information Card ───────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFEFE8DF)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Rounded Square Icon Container
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECE0),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Icon(
                                slide.icon,
                                color: AppTheme.primaryOrange,
                                size: 26,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Card Title and Description
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  slide.cardTitle,
                                  style: AppTheme.serif(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkNavy,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  slide.cardDescription,
                                  style: AppTheme.sans(
                                    fontSize: 11.5,
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

                    // Space above bottom controls
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


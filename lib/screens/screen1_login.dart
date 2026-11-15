import 'package:flutter/material.dart';
import '../models/buddy_registration_data.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_button.dart';
import 'screen0_onboarding.dart';
import 'screen2_identity.dart';
import 'screen5_dashboard.dart';
import 'traveller_screen2_profile.dart';
import 'traveller_screen7_home.dart';

class Screen1Login extends StatefulWidget {
  final bool? isBuddyPortal;
  const Screen1Login({super.key, this.isBuddyPortal});

  @override
  State<Screen1Login> createState() => _Screen1LoginState();
}

class _Screen1LoginState extends State<Screen1Login> {
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isBuddyPortal = false;

  @override
  void initState() {
    super.initState();
    _isBuddyPortal = widget.isBuddyPortal ?? false;
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = RegistrationScope.of(context);
    _emailController.text = data.loginEmail;
    _phoneController.text = data.loginPhone;
    _rememberMe = data.rememberMe;
    if (widget.isBuddyPortal != null) {
      _isBuddyPortal = widget.isBuddyPortal!;
    } else {
      _isBuddyPortal = data.isBuddyPortalActive;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Clicking "Login as Buddy" goes directly to Dashboard (Screen 5)
  void _onLoginPressed() {
    final data = RegistrationScope.of(context);
    data.loginEmail = _emailController.text;
    data.loginPhone = _phoneController.text;
    data.rememberMe = _rememberMe;
    data.isBuddyPortalActive = _isBuddyPortal;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Screen5BuddyDashboard(),
      ),
      (route) => false,
    );
  }

  // Clicking "Login as Traveller" goes directly to Traveller Home Page
  void _onTravellerLoginPressed() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => TravellerHomeScreen(
          data: TravellerRegistrationData(
            email: _emailController.text,
          ),
        ),
      ),
      (route) => false,
    );
  }

  // Clicking "New Traveller?" navigates to Registration / Verification Flow (Screen 2)
  void _onNewTravellerPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TravellerProfileScreen(
          data: TravellerRegistrationData(
            email: _emailController.text,
          ),
        ),
      ),
    );
  }

  // Clicking "New to Travel Buddy?" navigates to Registration / Verification Flow (Screen 2)
  void _onNewToTravelBuddyPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Screen2IdentityVerification(),
      ),
    );
  }

  // Forgot Password Dialog
  void _showForgotPasswordDialog() {
    final resetController = TextEditingController(text: _emailController.text);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Password',
          style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your email address to receive password reset link:',
                style: AppTheme.sans(fontSize: 12.5, color: AppTheme.slateText),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: resetController,
                style: AppTheme.sans(fontSize: 13.5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppTheme.primaryOrange, size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
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
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password reset instructions sent to ${resetController.text}', style: AppTheme.sans(color: Colors.white)),
                  backgroundColor: AppTheme.darkNavy,
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Send Link', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Google Sign-In Simulation
  void _showGoogleSignInModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/google_icon.png', width: 24, height: 24),
                const SizedBox(width: 12),
                Text(
                  'Sign in with Google',
                  style: AppTheme.sans(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Choose an account to continue to Travel Buddy',
              style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFF5E36),
                child: Text('P', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text('Priya Sharma', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text('priya.sharma.guide@travelbuddy.com', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
              onTap: () {
                Navigator.pop(ctx);
                _onLoginPressed();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF64748B),
                child: Icon(Icons.add, color: Colors.white),
              ),
              title: Text('Use another account', style: AppTheme.sans(fontSize: 14)),
              onTap: () {
                Navigator.pop(ctx);
                _onLoginPressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Contact Support Modal
  void _showContactSupportModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Travel Buddy Support',
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
            const SizedBox(height: 6),
            Text(
              'Our local partner support team is available 24/7.',
              style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
            ),
            const SizedBox(height: 18),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.phone_in_talk_rounded, color: AppTheme.primaryOrange),
              ),
              title: Text('Partner Helpline', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text('+91 1800-BUDDY-HELP (Toll Free)', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calling +91 1800-BUDDY-HELP...', style: AppTheme.sans(color: Colors.white)),
                    backgroundColor: AppTheme.darkNavy,
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.mail_outline_rounded, color: AppTheme.primaryOrange),
              ),
              title: Text('Email Support', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text('support@travelbuddy.com', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening mail client to support@travelbuddy.com', style: AppTheme.sans(color: Colors.white)),
                    backgroundColor: AppTheme.darkNavy,
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primaryOrange),
              ),
              title: Text('Live Buddy Chat', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text('Instant replies within 2 mins', style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Connecting to Travel Buddy Live Agent...', style: AppTheme.sans(color: Colors.white)),
                    backgroundColor: AppTheme.darkNavy,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Beach Sunset Header with clean crisp photo on right (no blur, no smears, no ghost text)
            Stack(
              children: [
                // Clean Beach Photograph on Top Right
                Positioned(
                  top: 0,
                  right: 0,
                  width: 235,
                  height: 290,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.55, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                          stops: [0.70, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/beach_login_clean.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ),
                ),

                // Foreground Content inside SafeArea
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => const OnboardingScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: AppTheme.darkNavy,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Heading (dynamic based on portal mode)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _isBuddyPortal ? 'Buddy\n' : 'Explore\n',
                                style: AppTheme.serif(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkNavy,
                                  height: 1.1,
                                ),
                              ),
                              TextSpan(
                                text: _isBuddyPortal ? 'Portal' : 'More Together',
                                style: AppTheme.serif(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryOrange,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subtitle
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: _isBuddyPortal ? 200 : 260),
                          child: Text(
                            _isBuddyPortal
                                ? 'Manage trips, connect with travellers and create memorable experiences together.'
                                : 'Discover places, meet local buddies and create unforgettable journeys across amazing destinations.',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              color: AppTheme.slateText,
                              height: 1.35,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Form Content Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Dual Pill Selector: Traveller Login / Buddy Portal
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.softBorder.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        // Traveller Login
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBuddyPortal = false;
                              });
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: !_isBuddyPortal
                                    ? AppTheme.primaryGradient
                                    : null,
                                color: !_isBuddyPortal ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: !_isBuddyPortal
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryRed.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_outline_rounded,
                                    size: 18,
                                    color: !_isBuddyPortal
                                        ? Colors.white
                                        : AppTheme.slateText,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Traveller Login',
                                    style: AppTheme.sans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: !_isBuddyPortal
                                          ? Colors.white
                                          : AppTheme.slateText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Buddy Portal
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBuddyPortal = true;
                              });
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: _isBuddyPortal
                                    ? AppTheme.primaryGradient
                                    : null,
                                color: _isBuddyPortal ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: _isBuddyPortal
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryRed.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.groups_rounded,
                                    size: 19,
                                    color: _isBuddyPortal
                                        ? Colors.white
                                        : AppTheme.slateText,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Buddy Portal',
                                    style: AppTheme.sans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _isBuddyPortal
                                          ? Colors.white
                                          : AppTheme.slateText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Input Fields
                  _buildInputField(
                    label: 'Email Address',
                    controller: _emailController,
                    icon: Icons.mail_outline_rounded,
                  ),
                  if (_isBuddyPortal) ...[
                    const SizedBox(height: 12),
                    _buildInputField(
                      label: 'Mobile Number',
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                    ),
                  ],
                  const SizedBox(height: 12),

                  _buildInputField(
                    label: 'Password',
                    controller: _passwordController,
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 14),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberMe = !_rememberMe;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _rememberMe
                                    ? AppTheme.primaryOrange
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: _rememberMe
                                      ? AppTheme.primaryOrange
                                      : const Color(0xFFD1D5DB),
                                  width: 1.5,
                                ),
                              ),
                              child: _rememberMe
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Remember Me',
                              style: AppTheme.sans(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkNavy,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _showForgotPasswordDialog,
                        child: Row(
                          children: [
                            Text(
                              'Forgot Password?',
                              style: AppTheme.sans(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 13,
                              color: AppTheme.primaryOrange,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Login CTA Button (Dynamic: Buddy Dashboard or Traveller Setup)
                  GradientButton(
                    text: _isBuddyPortal ? 'Login as Buddy' : 'Login as Traveller',
                    onPressed: _isBuddyPortal ? _onLoginPressed : _onTravellerLoginPressed,
                  ),
                  const SizedBox(height: 20),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE5DDD5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'OR',
                          style: AppTheme.sans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightSlate,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE5DDD5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Continue with Google Button
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppTheme.inputBg,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppTheme.softBorder),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC9566).withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: _showGoogleSignInModal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google_icon.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Continue with Google',
                              style: AppTheme.sans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkNavy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Footer: If Traveller mode, show "New Traveller?" & "Contact Support" links + badges
                  // If Buddy mode, show New to Travel Buddy? / Contact Support
                  if (!_isBuddyPortal) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _onNewTravellerPressed,
                          child: Text(
                            'New Traveller?',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryOrange,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: _showContactSupportModal,
                          child: Row(
                            children: [
                              Text(
                                'Contact Support',
                                style: AppTheme.sans(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryOrange,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 13,
                                color: AppTheme.primaryOrange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.offWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.softBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFeatureBadge(
                            icon: Icons.shield_outlined,
                            title: 'Safe\nTravel',
                          ),
                          Container(width: 1, height: 28, color: AppTheme.softBorder),
                          _buildFeatureBadge(
                            icon: Icons.people_outline_rounded,
                            title: 'Verified\nBuddies',
                          ),
                          Container(width: 1, height: 28, color: AppTheme.softBorder),
                          _buildFeatureBadge(
                            icon: Icons.explore_outlined,
                            title: 'Better\nJourneys',
                          ),
                        ],
                      ),
                    ),
                  ] else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _onNewToTravelBuddyPressed,
                          child: Text(
                            'New to Travel Buddy?',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryOrange,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: _showContactSupportModal,
                          child: Row(
                            children: [
                              Text(
                                'Contact Support',
                                style: AppTheme.sans(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryOrange,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 13,
                                color: AppTheme.primaryOrange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.inputBg,
        borderRadius: BorderRadius.circular(20),
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.iconBoxBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppTheme.iconOrange,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTheme.sans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.lightSlate,
                  ),
                ),
                TextField(
                  controller: controller,
                  obscureText: isPassword && obscureText,
                  style: AppTheme.sans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkNavy,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 2, bottom: 2),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppTheme.lightSlate,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppTheme.iconBoxBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryOrange, size: 16),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTheme.sans(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkNavy,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}

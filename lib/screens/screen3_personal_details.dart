import 'dart:async';
import 'package:flutter/material.dart';
import '../models/buddy_registration_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_indicator_widget.dart';
import 'screen4_professional_details.dart';

class Screen3PersonalDetails extends StatefulWidget {
  const Screen3PersonalDetails({super.key});

  @override
  State<Screen3PersonalDetails> createState() => _Screen3PersonalDetailsState();
}

class _Screen3PersonalDetailsState extends State<Screen3PersonalDetails> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  // OTP controllers
  final List<TextEditingController> _emailOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _emailOtpFocusNodes =
      List.generate(6, (_) => FocusNode());

  final List<TextEditingController> _mobileOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _mobileOtpFocusNodes =
      List.generate(6, (_) => FocusNode());

  // Resend Timer Simulation
  int _timerSeconds = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timerSeconds = 45;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        t.cancel();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = RegistrationScope.of(context);
    if (_nameController.text.isEmpty) _nameController.text = data.fullName;
    if (_phoneController.text.isEmpty) _phoneController.text = data.mobileNumber;
    if (_dobController.text.isEmpty) _dobController.text = data.dateOfBirth;
    if (_emailController.text.isEmpty) _emailController.text = data.emailAddress;
    if (_passwordController.text.isEmpty) _passwordController.text = data.password;

    for (int i = 0; i < 6; i++) {
      if (data.emailOtp[i].isNotEmpty) {
        _emailOtpControllers[i].text = data.emailOtp[i];
      }
      if (data.mobileOtp[i].isNotEmpty) {
        _mobileOtpControllers[i].text = data.mobileOtp[i];
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    for (var c in _emailOtpControllers) {
      c.dispose();
    }
    for (var f in _emailOtpFocusNodes) {
      f.dispose();
    }
    for (var c in _mobileOtpControllers) {
      c.dispose();
    }
    for (var f in _mobileOtpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // Interactive Date Picker
  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 8, 15),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
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
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final formatted = '${picked.day.toString().padLeft(2, '0')} ${months[picked.month - 1]} ${picked.year}';
      setState(() {
        _dobController.text = formatted;
      });
    }
  }

  void _onContinuePressed() {
    final data = RegistrationScope.of(context);
    data.fullName = _nameController.text;
    data.mobileNumber = _phoneController.text;
    data.dateOfBirth = _dobController.text;
    data.emailAddress = _emailController.text;
    data.password = _passwordController.text;

    for (int i = 0; i < 6; i++) {
      data.emailOtp[i] = _emailOtpControllers[i].text;
      data.mobileOtp[i] = _mobileOtpControllers[i].text;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Screen4ProfessionalDetails(),
      ),
    );
  }

  void _showChangeDialog({required String title, required String currentVal, required Function(String) onSave}) {
    final controller = TextEditingController(text: currentVal);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          style: AppTheme.sans(fontSize: 14),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
              onSave(controller.text);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Updated to ${controller.text}', style: AppTheme.sans(color: Colors.white)),
                  backgroundColor: AppTheme.darkNavy,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedTimer =
        '00:${_timerSeconds.toString().padLeft(2, '0')}';

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

              // Progress Indicator: Step 2
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RegistrationProgressIndicator(currentStep: 2),
              ),
              const SizedBox(height: 16),

              // Personal Details Card
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
                            Icons.person_outline_rounded,
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
                                'Personal Details',
                                style: AppTheme.serif(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Your basic information from your verified account.',
                                style: AppTheme.sans(
                                  fontSize: 11.5,
                                  color: AppTheme.slateText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Full Name Field with Label
                    _buildVerifiedField(
                      label: 'Full Name',
                      controller: _nameController,
                      icon: Icons.person_outline_rounded,
                      isLocked: true,
                    ),
                    const SizedBox(height: 14),

                    // Mobile Number Field with Label
                    _buildVerifiedField(
                      label: 'Mobile Number',
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                      isLocked: true,
                    ),
                    const SizedBox(height: 14),

                    // Date of Birth Field with Label & Date Picker
                    _buildVerifiedField(
                      label: 'Date of Birth',
                      controller: _dobController,
                      icon: Icons.calendar_today_outlined,
                      isLocked: false,
                      onTrailingTap: _selectDateOfBirth,
                      trailingIcon: Icons.calendar_month_rounded,
                    ),
                    const SizedBox(height: 14),

                    // Email Address Field with Label
                    _buildVerifiedField(
                      label: 'Email Address',
                      controller: _emailController,
                      icon: Icons.mail_outline_rounded,
                      isLocked: true,
                    ),
                    const SizedBox(height: 14),

                    // Password Field with Label
                    _buildVerifiedField(
                      label: 'Password',
                      controller: _passwordController,
                      icon: Icons.lock_outline_rounded,
                      hint: 'Create a strong password',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Verify Your Account Card
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
                            Icons.verified_user_outlined,
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
                                'Verify Your Account',
                                style: AppTheme.serif(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "We'll send verification codes to confirm your email and mobile number.",
                                style: AppTheme.sans(
                                  fontSize: 11.5,
                                  color: AppTheme.slateText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Email Verification Box
                    _buildVerificationBox(
                      title: 'Email Verification',
                      subtitle:
                          "We've sent a 6-digit code to ${_emailController.text}",
                      icon: Icons.mail_outline_rounded,
                      controllers: _emailOtpControllers,
                      focusNodes: _emailOtpFocusNodes,
                      timerText: formattedTimer,
                      onChangeTap: () {
                        _showChangeDialog(
                          title: 'Change Email Address',
                          currentVal: _emailController.text,
                          onSave: (val) {
                            setState(() {
                              _emailController.text = val;
                            });
                          },
                        );
                      },
                      onResendTap: () {
                        _startTimer();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New 6-digit verification code sent to ${_emailController.text}', style: AppTheme.sans(color: Colors.white)),
                            backgroundColor: AppTheme.darkNavy,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Mobile Verification Box
                    _buildVerificationBox(
                      title: 'Mobile Verification',
                      subtitle:
                          "We've sent a 6-digit code to ${_phoneController.text}",
                      icon: Icons.phone_outlined,
                      controllers: _mobileOtpControllers,
                      focusNodes: _mobileOtpFocusNodes,
                      timerText: formattedTimer,
                      onChangeTap: () {
                        _showChangeDialog(
                          title: 'Change Mobile Number',
                          currentVal: _phoneController.text,
                          onSave: (val) {
                            setState(() {
                              _phoneController.text = val;
                            });
                          },
                        );
                      },
                      onResendTap: () {
                        _startTimer();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New 6-digit verification code sent to ${_phoneController.text}', style: AppTheme.sans(color: Colors.white)),
                            backgroundColor: AppTheme.darkNavy,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Your Information Is Secure
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9F5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFFDE7D9)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppTheme.iconBoxBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.lock_rounded,
                              color: AppTheme.primaryOrange,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your information is secure',
                                  style: AppTheme.sans(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.darkNavy,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'We use industry-standard encryption to keep your information safe and private.',
                                  style: AppTheme.sans(
                                    fontSize: 10,
                                    color: AppTheme.slateText,
                                    height: 1.3,
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

  Widget _buildVerifiedField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    bool isLocked = false,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    VoidCallback? onTrailingTap,
    IconData? trailingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 6),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF7F3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE8E0D6)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.iconOrange,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: onTrailingTap != null,
                  onTap: onTrailingTap,
                  obscureText: isPassword && obscureText,
                  style: AppTheme.sans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkNavy,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: AppTheme.sans(
                      fontSize: 13,
                      color: AppTheme.lightSlate,
                    ),
                  ),
                ),
              ),
              if (isLocked)
                const Icon(
                  Icons.lock_outline_rounded,
                  color: AppTheme.lightSlate,
                  size: 18,
                ),
              if (trailingIcon != null)
                IconButton(
                  icon: Icon(trailingIcon, color: AppTheme.primaryOrange, size: 20),
                  onPressed: onTrailingTap,
                ),
              if (isPassword)
                IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppTheme.lightSlate,
                    size: 19,
                  ),
                  onPressed: onToggleVisibility,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationBox({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<TextEditingController> controllers,
    required List<FocusNode> focusNodes,
    required String timerText,
    required VoidCallback onChangeTap,
    required VoidCallback onResendTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E0D6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.iconOrange,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.sans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.sans(
                        fontSize: 10.5,
                        color: AppTheme.slateText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onChangeTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      size: 13,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Change',
                      style: AppTheme.sans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 6-digit OTP Row (Responsive using Expanded)
          Row(
            children: List.generate(6, (index) {
              return Expanded(
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: 2.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFDDD5CA)),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: AppTheme.sans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkNavy,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 5) {
                          focusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // Footer: Didn't receive the code? Resend in 00:45
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Didn't receive the code?",
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sans(
                    fontSize: 10.5,
                    color: AppTheme.slateText,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onResendTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.refresh_rounded,
                      size: 13,
                      color: AppTheme.primaryOrange,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Resend in $timerText',
                      style: AppTheme.sans(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

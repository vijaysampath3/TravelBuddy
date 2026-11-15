import 'package:flutter/material.dart';
import '../models/buddy_registration_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_indicator_widget.dart';
import 'screen3_personal_details.dart';

class Screen2IdentityVerification extends StatefulWidget {
  const Screen2IdentityVerification({super.key});

  @override
  State<Screen2IdentityVerification> createState() =>
      _Screen2IdentityVerificationState();
}

class _Screen2IdentityVerificationState
    extends State<Screen2IdentityVerification> {
  late TextEditingController _aadhaarController;
  final List<String> _idProofOptions = [
    'Aadhaar Card',
    'Passport',
    'Voter ID',
    'Driving License',
  ];

  @override
  void initState() {
    super.initState();
    _aadhaarController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final data = RegistrationScope.of(context);
    if (_aadhaarController.text.isEmpty &&
        data.aadhaarNumber != 'Enter your 12 digit Aadhaar number') {
      _aadhaarController.text = data.aadhaarNumber;
    }
  }

  @override
  void dispose() {
    _aadhaarController.dispose();
    super.dispose();
  }

  // Scrollable Zero-Overflow ID Proof Picker
  void _showIdProofPicker(BuddyRegistrationData data) {
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
                    'Select Government ID Proof',
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
                children: _idProofOptions.map((opt) {
                  final isSelected = data.governmentIdType == opt;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? AppTheme.primaryOrange : AppTheme.lightSlate,
                    ),
                    title: Text(
                      opt,
                      style: AppTheme.sans(
                        fontSize: 14.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    onTap: () {
                      data.updateGovernmentIdType(opt);
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

  // Upload Options Modal for Front/Back ID
  void _showUploadSourceModal({required bool isFront, required BuddyRegistrationData data}) {
    showModalBottomSheet(
      context: context,
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
            Text(
              isFront ? 'Upload ID Front Side' : 'Upload ID Back Side',
              style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Select file source for document verification',
              style: AppTheme.sans(fontSize: 12, color: AppTheme.slateText),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.camera_alt_rounded, color: AppTheme.primaryOrange),
              title: Text('Take Document Photo', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(ctx);
                if (isFront) {
                  data.toggleFrontUpload(true);
                } else {
                  data.toggleBackUpload(true);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFront ? 'Front ID photo captured' : 'Back ID photo captured', style: AppTheme.sans(color: Colors.white)),
                    backgroundColor: AppTheme.darkNavy,
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.photo_library_rounded, color: AppTheme.primaryOrange),
              title: Text('Choose from Gallery', style: AppTheme.sans(fontSize: 14, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(ctx);
                if (isFront) {
                  data.toggleFrontUpload(true);
                } else {
                  data.toggleBackUpload(true);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFront ? 'Front ID selected from gallery' : 'Back ID selected from gallery', style: AppTheme.sans(color: Colors.white)),
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

  // Camera Simulator for Selfie
  void _showSelfieCameraModal(BuddyRegistrationData data) {
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Face Verification',
                  style: AppTheme.serif(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(ctx),
                  child: const Icon(Icons.close_rounded, color: AppTheme.slateText),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: 180,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECE4),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppTheme.primaryOrange, width: 2),
              ),
              child: const Center(
                child: Icon(Icons.face_rounded, size: 80, color: AppTheme.primaryOrange),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Position your face inside the oval frame',
              style: AppTheme.sans(fontSize: 12.5, color: AppTheme.slateText),
            ),
            const SizedBox(height: 18),
            GradientButton(
              text: 'Capture Selfie',
              showArrow: false,
              onPressed: () {
                data.toggleSelfieUpload(true);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selfie captured & verified successfully!', style: AppTheme.sans(color: Colors.white)),
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

  void _onContinuePressed() {
    final data = RegistrationScope.of(context);
    if (_aadhaarController.text.isNotEmpty) {
      data.updateAadhaarNumber(_aadhaarController.text);
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Screen3PersonalDetails(),
      ),
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
              // Header with clean beach sunset and Local Buddy Partner text
              PartnerRegistrationHeader(
                onBack: () => Navigator.of(context).maybePop(),
              ),

              // Progress Indicator: Step 1
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RegistrationProgressIndicator(currentStep: 1),
              ),
              const SizedBox(height: 16),

              // Identity Verification Content Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
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
                            Icons.badge_outlined,
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
                                'Identity Verification',
                                style: AppTheme.serif(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Help us verify you are a genuine local buddy.',
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

                    // Government ID Proof Label & Dropdown
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Government ID Proof ',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkNavy,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () => _showIdProofPicker(data),
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
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.iconBoxBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.credit_card_rounded,
                                color: AppTheme.iconOrange,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                data.governmentIdType,
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

                    // Aadhaar Number Label & Input Field
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Aadhaar Number ',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkNavy,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

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
                            child: const Icon(
                              Icons.fingerprint_rounded,
                              color: AppTheme.iconOrange,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _aadhaarController,
                              keyboardType: TextInputType.number,
                              style: AppTheme.sans(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkNavy,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    'Enter your 12 digit Aadhaar number',
                                hintStyle: AppTheme.sans(
                                  fontSize: 13,
                                  color: AppTheme.lightSlate,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Upload ID: Front Side & Back Side Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Front Side
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Upload ID (Front Side) ',
                                      style: AppTheme.sans(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkNavy,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: AppTheme.sans(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primaryRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildFrontIdCard(data),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Back Side
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Upload ID (Back Side) ',
                                      style: AppTheme.sans(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkNavy,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '*',
                                      style: AppTheme.sans(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primaryRed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildBackIdCard(data),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Selfie Verification Section
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Selfie Verification ',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkNavy,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: AppTheme.sans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildSelfieCard(data),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Continue Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buildFrontIdCard(BuddyRegistrationData data) {
    if (data.frontUploaded) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => _showUploadSourceModal(isFront: true, data: data),
            child: Container(
              height: 98,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE8E0D6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  'assets/images/aadhaar_preview.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: () => data.toggleFrontUpload(false),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2D9CF)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: AppTheme.slateText,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () => _showUploadSourceModal(isFront: true, data: data),
        child: Container(
          height: 98,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF7F3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFDFD7CC),
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.iconBoxBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppTheme.iconOrange,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upload Front',
                  style: AppTheme.sans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkNavy,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildBackIdCard(BuddyRegistrationData data) {
    return GestureDetector(
      onTap: () => _showUploadSourceModal(isFront: false, data: data),
      child: Container(
        height: 98,
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F3),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: data.backUploaded
                ? AppTheme.primaryOrange
                : const Color(0xFFDFD7CC),
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: data.backUploaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppTheme.successGreen,
                      size: 26,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Back ID Uploaded',
                      style: AppTheme.sans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.iconBoxBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        color: AppTheme.iconOrange,
                        size: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Upload Back Side',
                      style: AppTheme.sans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    Text(
                      'JPG, PNG or PDF',
                      style: AppTheme.sans(
                        fontSize: 9.5,
                        color: AppTheme.slateText,
                      ),
                    ),
                    Text(
                      '(Max 5 MB)',
                      style: AppTheme.sans(
                        fontSize: 9,
                        color: AppTheme.lightSlate,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSelfieCard(BuddyRegistrationData data) {
    return GestureDetector(
      onTap: () => _showSelfieCameraModal(data),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF7F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: data.selfieUploaded
                ? AppTheme.primaryOrange
                : const Color(0xFFDFD7CC),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.iconBoxBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                data.selfieUploaded
                    ? Icons.check_rounded
                    : Icons.photo_camera_outlined,
                color: AppTheme.iconOrange,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data.selfieUploaded ? 'Selfie Captured ✓' : 'Take a Selfie',
              style: AppTheme.sans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkNavy,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Make sure your face is clearly visible',
              style: AppTheme.sans(
                fontSize: 11,
                color: AppTheme.slateText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'JPG, PNG or PDF • Max 5 MB',
              style: AppTheme.sans(
                fontSize: 10,
                color: AppTheme.lightSlate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

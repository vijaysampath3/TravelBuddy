import 'package:flutter/material.dart';
import '../models/traveller_registration_data.dart';
import '../theme/app_theme.dart';
import 'screen1_login.dart';

class TravellerPhase1CompleteScreen extends StatelessWidget {
  final TravellerRegistrationData data;
  const TravellerPhase1CompleteScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Success Icon Container
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppTheme.iconBoxBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryOrange.withValues(alpha: 0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.primaryOrange,
                    size: 54,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "You're All Set for ",
                      style: AppTheme.serif(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkNavy,
                      ),
                    ),
                    TextSpan(
                      text: 'Now!',
                      style: AppTheme.serif(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Phase 1 of your Traveller profile setup is complete. Review your preferences below:',
                textAlign: TextAlign.center,
                style: AppTheme.sans(
                  fontSize: 13,
                  color: AppTheme.slateText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEDE6DD)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Traveller Name',
                      value: data.fullName.isNotEmpty ? data.fullName : 'Guest Traveller',
                    ),
                    const Divider(height: 16, color: Color(0xFFF3ECE4)),
                    _buildSummaryRow(
                      icon: Icons.flag_outlined,
                      label: 'Nationality',
                      value: data.nationality.isNotEmpty ? data.nationality : 'Not specified',
                    ),
                    const Divider(height: 16, color: Color(0xFFF3ECE4)),
                    _buildSummaryRow(
                      icon: Icons.explore_outlined,
                      label: 'Purpose',
                      value: data.travelPurpose.isNotEmpty ? data.travelPurpose : 'Leisure / Tourism',
                    ),
                    const Divider(height: 16, color: Color(0xFFF3ECE4)),
                    _buildSummaryRow(
                      icon: Icons.access_time_rounded,
                      label: 'Duration',
                      value: data.stayDuration.isNotEmpty ? data.stayDuration : 'Customizable',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 18, color: AppTheme.primaryOrange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Phase 2: Passport Verification & Traveller Home will be available in the next release.',
                        style: AppTheme.sans(fontSize: 11.5, color: AppTheme.darkNavy),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Back to Login Button
              Container(
                width: double.infinity,
                height: 52,
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
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Screen1Login()),
                        (route) => false,
                      );
                    },
                    child: Center(
                      child: Text(
                        'Return to Login',
                        style: AppTheme.sans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryOrange, size: 18),
        const SizedBox(width: 10),
        Text(
          label,
          style: AppTheme.sans(
            fontSize: 12.5,
            color: AppTheme.slateText,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTheme.sans(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkNavy,
          ),
        ),
      ],
    );
  }
}


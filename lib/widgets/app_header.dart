import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PartnerRegistrationHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const PartnerRegistrationHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Clean beach photograph on top right with smooth gradient fades
        Positioned(
          top: 0,
          right: 0,
          width: 200,
          height: 150,
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
                  stops: [0.65, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/beach_header_partner.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Text & circular back button content
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Back Button
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
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
              const SizedBox(height: 10),

              // "BECOME A"
              Text(
                'BECOME A',
                style: AppTheme.sans(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primaryOrange,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 2),

              // "Local Buddy Partner"
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Local Buddy\n',
                      style: AppTheme.serif(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkNavy,
                        height: 1.15,
                      ),
                    ),
                    TextSpan(
                      text: 'Partner',
                      style: AppTheme.serif(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              // Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 210),
                child: Text(
                  'Join our community and help travellers explore amazing places together.',
                  style: AppTheme.sans(
                    fontSize: 11.5,
                    color: AppTheme.slateText,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

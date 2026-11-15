import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable Onboarding Header with subtle warm cream gradient overlays,
/// ensuring high contrast, excellent text legibility, and seamless image blending.
class OnboardingHeader extends StatelessWidget {
  final String imagePath;
  final double height;
  final VoidCallback onBack;
  final VoidCallback? onSkip;
  final String? tag;
  final List<TextSpan> titleSpans;
  final String? subtitle;
  final Alignment imageAlignment;
  final double? imageWidthRatio;
  final Widget? trailingBadge;

  const OnboardingHeader({
    super.key,
    required this.imagePath,
    this.height = 275,
    required this.onBack,
    this.onSkip,
    this.tag = 'TRAVEL BUDDY',
    required this.titleSpans,
    this.subtitle,
    this.imageAlignment = Alignment.topRight,
    this.imageWidthRatio,
    this.trailingBadge,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imgWidth = imageWidthRatio != null ? screenWidth * imageWidthRatio! : screenWidth * 0.75;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Photographic Background layer (positioned on the right / top)
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          width: imgWidth,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: [0.45, 1.0],
                colors: [Colors.black, Colors.transparent],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.70, 1.0],
                  colors: [Colors.black, Colors.transparent],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  const Color(0xFFFF9E66).withValues(alpha: 0.10),
                  BlendMode.colorBurn,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: imageAlignment,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/onboarding_discover.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ),

        // 2. Warm peach-orange / sunset gradient wash behind text
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.42, 0.75],
                colors: [
                  const Color(0xFFF7E2D5),
                  const Color(0xFFF8E7DC).withValues(alpha: 0.90),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // 3. Subtle bottom blend into warm cream background
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 35,
          child: IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.creamBg,
                  ],
                ),
              ),
            ),
          ),
        ),

        // 4. Foreground Content inside SafeArea
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Navigation Row (Back & Skip)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Circular Back Button
                    GestureDetector(
                      onTap: onBack,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
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

                    // Optional Skip Pill Button
                    if (onSkip != null)
                      GestureDetector(
                        onTap: onSkip,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Skip',
                                style: AppTheme.sans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkNavy,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 14,
                                color: AppTheme.primaryOrange,
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (trailingBadge != null)
                      trailingBadge!
                    else
                      const SizedBox(width: 38),
                  ],
                ),
                const SizedBox(height: 14),

                // Branding Tag (TRAVEL BUDDY)
                if (tag != null && tag!.isNotEmpty) ...[
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 13,
                        color: AppTheme.primaryOrange,
                        margin: const EdgeInsets.only(right: 6),
                      ),
                      Text(
                        tag!,
                        style: AppTheme.sans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryOrange,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                // Prominent Heading (with navy and orange typography)
                RichText(
                  text: TextSpan(
                    children: titleSpans,
                  ),
                ),

                // Supporting Subtitle (clear, high contrast)
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
                    child: Text(
                      subtitle!,
                      style: AppTheme.sans(
                        fontSize: 12,
                        color: AppTheme.slateText,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

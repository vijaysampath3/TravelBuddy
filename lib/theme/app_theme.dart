import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors - Warm Sunset / Peach-Orange Color Grading
  static const Color creamBg = Color(0xFFF7ECE1);
  static const Color offWhite = Color(0xFFFAF2EA);
  static const Color darkNavy = Color(0xFF162544);
  static const Color darkBlue = Color(0xFF1E293B);
  static const Color primaryOrange = Color(0xFFFF5E36);
  static const Color primaryRed = Color(0xFFE53935);
  static const Color slateText = Color(0xFF6B7280);
  static const Color lightSlate = Color(0xFF9CA3AF);
  static const Color softBorder = Color(0xFFEEDCCA);
  static const Color inputBg = Color(0xFFFFF7EF);
  static const Color iconBoxBg = Color(0xFFFFEADB);
  static const Color iconOrange = Color(0xFFFF5E36);
  static const Color successGreen = Color(0xFF10B981);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF5E36), Color(0xFFE53935)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient warmHeaderGradient = LinearGradient(
    colors: [Color(0xFFFFFAF5), Color(0xFFFDF3EB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Typography - Serif for display headings
  static TextStyle serif({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold,
    Color color = darkNavy,
    double? height,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.playfairDisplay(
      textStyle: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
      ),
    );
  }

  // Typography - Sans-serif for body & UI labels
  static TextStyle sans({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = darkNavy,
    double? height,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.plusJakartaSans(
      textStyle: TextStyle(
        fontFamily: 'PlusJakartaSans',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
      ),
    );
  }

  // Common Card Box Decoration
  static BoxDecoration cardDecoration({
    Color color = offWhite,
    BorderRadius? borderRadius,
    Color borderColor = softBorder,
    double borderWidth = 1.0,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: const Color(0xFFDC9566).withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
    );
  }
}

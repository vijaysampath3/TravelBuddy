import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RegistrationProgressIndicator extends StatelessWidget {
  /// currentStep: 1, 2, or 3
  final int currentStep;

  const RegistrationProgressIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.softBorder.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStep(
            stepNumber: 1,
            label: 'Verify Identity',
            isCompleted: currentStep > 1,
            isActive: currentStep == 1,
          ),
          _buildConnectingLine(isDone: currentStep > 1),
          _buildStep(
            stepNumber: 2,
            label: 'Personal Details',
            isCompleted: currentStep > 2,
            isActive: currentStep == 2,
          ),
          _buildConnectingLine(isDone: currentStep > 2),
          _buildStep(
            stepNumber: 3,
            label: 'Share Your Interests',
            isCompleted: false,
            isActive: currentStep == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required int stepNumber,
    required String label,
    required bool isCompleted,
    required bool isActive,
  }) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: (isActive || isCompleted)
                  ? AppTheme.primaryGradient
                  : null,
              color: (isActive || isCompleted) ? null : const Color(0xFFF3ECE4),
              border: Border.all(
                color: (isActive || isCompleted)
                    ? Colors.transparent
                    : const Color(0xFFE2D7CC),
                width: 1,
              ),
              boxShadow: (isActive || isCompleted)
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 15,
                    )
                  : Text(
                      '$stepNumber',
                      style: AppTheme.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : AppTheme.slateText,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.sans(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? AppTheme.primaryOrange
                  : (isCompleted ? AppTheme.darkNavy : AppTheme.slateText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectingLine({required bool isDone}) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 1.5,
        margin: const EdgeInsets.only(bottom: 18),
        color: isDone ? AppTheme.primaryOrange : const Color(0xFFE5DDD5),
      ),
    );
  }
}


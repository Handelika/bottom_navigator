import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'indicator_style.dart';

class PillIndicatorStyle extends IndicatorStyle {
  const PillIndicatorStyle();

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    final horizontalPadding = (isTablet ? 12.0 : 8.0) / 2;
    // Make it taller to fill more of the bar height
    final targetHeight = isTablet
        ? (showLabels ? 105.0 : 90.0)
        : (showLabels ? 78.0 : 68.0);
    final verticalPadding = math.max(0.0, (barHeight - targetHeight) / 2);

    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      borderRadius: isTablet ? 40 : 32, // Smoother rounding
      showGlow: true,
    );
  }

  @override
  Widget buildIndicator({
    required BuildContext context,
    required bool isSelected,
    required IndicatorMetrics metrics,
    required Duration animationDuration,
    Color? itemColor,
    List<Color>? indicatorColors,
  }) {
    final theme = Theme.of(context);
    final primaryColor =
        itemColor ?? indicatorColors?.first ?? theme.colorScheme.primary;

    return AnimatedContainer(
      duration: animationDuration,
      width: metrics.width,
      height: metrics.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(metrics.borderRadius),
        color: primaryColor.withValues(alpha: 0.15),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     primaryColor.withValues(alpha: 0.3),
        //     primaryColor.withValues(alpha: 0.1),
        //   ],
        // ),
        // boxShadow: [
        //   if (metrics.showGlow && isSelected)
        //     BoxShadow(
        //       color: primaryColor.withValues(alpha: 0.2),
        //       blurRadius: 15,
        //       offset: const Offset(0, 4),
        //     ),
        // ],
      ),
    );
  }
}

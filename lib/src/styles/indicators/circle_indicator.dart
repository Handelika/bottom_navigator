import 'package:flutter/material.dart';
import 'indicator_style.dart';

/// An indicator style that renders a perfect circle behind the active item.
///
/// This style uses a radial gradient and a subtle glow effect to create a
/// premium, glassmorphic appearance.
class CircleIndicatorStyle extends IndicatorStyle {
  const CircleIndicatorStyle();

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    // Base sizing logic for different device types
    final double baseSize = isTablet ? 80.0 : 60.0;

    // When labels are shown, the icon is shifted upwards.
    // We calculate this shift to keep the circle perfectly centered on the icon.
    final double shift = showLabels ? (isTablet ? 12.0 : 8.0) : 0.0;

    // Calculate maximum space to maintain a 1:1 ratio (perfect circle)
    final double maxAvailable = barHeight - (shift * 2);

    // Clamp the target size to available height to prevent "squeezing"
    final double targetSize = showLabels ? baseSize + 10.0 : baseSize;
    final double circleSize = targetSize > maxAvailable
        ? maxAvailable
        : targetSize;

    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.only(bottom: shift * 2),
      borderRadius: circleSize / 2,
      showGlow: true,
      width: circleSize,
      height: circleSize,
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
      ),
    );
  }
}

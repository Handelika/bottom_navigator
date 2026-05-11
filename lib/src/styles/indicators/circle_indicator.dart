import 'package:flutter/material.dart';
import 'indicator_style.dart';

/// An indicator style that renders a perfect circle behind the active item.
///
/// This style uses a radial gradient and a subtle glow effect to create a
/// premium, glassmorphic appearance.
class CircleIndicatorStyle extends IndicatorStyle {
  const CircleIndicatorStyle({this.indicatorColor, this.border, this.padding});

  final Color? indicatorColor;
  final BoxBorder? border;
  final EdgeInsets? padding;

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.zero,
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
        indicatorColor ??
        itemColor ??
        indicatorColors?.first ??
        theme.colorScheme.primary;

    return SizedBox.expand(
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor.withValues(alpha: 0.15),
          border:
              border ??
              Border.all(
                color: primaryColor.withValues(alpha: 0.2),
                width: 1.5,
              ),
        ),
      ),
    );
  }
}

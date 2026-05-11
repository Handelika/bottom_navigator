import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'indicator_style.dart';

class PillIndicatorStyle extends IndicatorStyle {
  const PillIndicatorStyle({this.indicatorColor, this.border, this.padding});

  final Color? indicatorColor;
  final BoxBorder? border;
  final EdgeInsets? padding;

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
      padding:
          padding ??
          EdgeInsets.symmetric(
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
        indicatorColor ??
        itemColor ??
        indicatorColors?.first ??
        theme.colorScheme.primary;

    Widget indicator = AnimatedContainer(
      duration: animationDuration,
      width: metrics.width,
      height: metrics.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(metrics.borderRadius!),
        color: primaryColor.withValues(alpha: 0.15),
        border:
            border ??
            Border.all(color: primaryColor.withValues(alpha: 0.2), width: 1.5),
      ),
    );

    if (metrics.width == null && metrics.height == null) {
      return SizedBox.expand(child: indicator);
    }

    if (metrics.width == null) {
      return SizedBox(
        height: metrics.height,
        child: SizedBox.expand(child: indicator),
      );
    }

    if (metrics.height == null) {
      return SizedBox(
        width: metrics.width,
        child: SizedBox.expand(child: indicator),
      );
    }

    return indicator;
  }
}

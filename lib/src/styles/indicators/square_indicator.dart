import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'indicator_style.dart';

/// An indicator style that renders a soft-edged square behind the active item.
///
/// This style provides a modern, structured look with subtle transparency
/// and clear boundaries.
class SquareIndicatorStyle extends IndicatorStyle {
  const SquareIndicatorStyle({this.indicatorColor, this.border, this.padding});

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
    final targetHeight = isTablet
        ? (showLabels ? 95.0 : 80.0)
        : (showLabels ? 70.0 : 60.0);
    final verticalPadding = math.max(0.0, (barHeight - targetHeight) / 2);

    return IndicatorMetrics(
      style: this,
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
      borderRadius: isTablet ? 12 : 8,
      showGlow: false,
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withValues(alpha: 0.15),
            primaryColor.withValues(alpha: 0.05),
          ],
        ),
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

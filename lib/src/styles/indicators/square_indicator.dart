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
    // Determine the size of the square based on bar height to ensure it fits perfectly.
    final double size = barHeight - 20.0;
    return IndicatorMetrics(
      style: this,
      padding: EdgeInsets.zero,
      borderRadius: isTablet ? 12 : 8,
      showGlow: false,
      width: size,
      height: size,
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

    final double size = metrics.height ?? 48.0;

    return Center(
      child: AnimatedContainer(
        duration: animationDuration,
        width: size,
        height: size,
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
              Border.all(
                color: primaryColor.withValues(alpha: 0.2),
                width: 1.5,
              ),
        ),
      ),
    );
  }
}

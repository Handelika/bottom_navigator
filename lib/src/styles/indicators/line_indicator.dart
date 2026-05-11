import 'package:flutter/material.dart';
import 'indicator_style.dart';

class LineIndicatorStyle extends IndicatorStyle {
  final double height;

  const LineIndicatorStyle({
    this.height = 3.0,
    this.indicatorColor,
    this.border,
    this.padding,
  });

  final Color? indicatorColor;
  final BoxBorder? border;
  final EdgeInsets? padding;

  @override
  IndicatorMetrics resolveMetrics({
    required double barHeight,
    bool isTablet = false,
    bool showLabels = false,
  }) {
    final lineWidth = isTablet ? 32.0 : 20.0;
    final bottomPadding = isTablet ? 12.0 : 8.0;
    final lineAreaHeight = barHeight - bottomPadding;

    return IndicatorMetrics(
      style: this,
      padding: padding ?? EdgeInsets.only(bottom: bottomPadding),
      borderRadius: 2,
      showGlow: false,
      width: lineWidth,
      height: lineAreaHeight,
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

    return AnimatedContainer(
      duration: animationDuration,
      width: metrics.width,
      height: metrics.height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: metrics.width,
          height: height,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(metrics.borderRadius ?? 0),
            border: border,
          ),
        ),
      ),
    );
  }
}

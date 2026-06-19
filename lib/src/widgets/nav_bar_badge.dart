import 'package:flutter/material.dart';

/// A badge widget that can be placed on a [BottomNavItem].
/// It supports responsive size adjustment based on screen width (tablet mode).
class NavBarBadge extends StatelessWidget {
  /// The text to display inside the badge. If null or empty, the badge may be hidden (unless [showDot] is true).
  final String? text;

  /// The background color of the badge. Defaults to theme's error color.
  final Color? color;

  /// The text color of the badge. Defaults to theme's onError color.
  final Color? textColor;

  /// The size of the badge. If null, a responsive default size is used.
  final double? size;

  /// Whether the badge should display only as a small dot.
  final bool showDot;

  /// The style to use for the badge text.
  final TextStyle? textStyle;

  const NavBarBadge({
    super.key,
    this.text,
    this.color,
    this.textColor,
    this.size,
    this.showDot = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final theme = Theme.of(context);
    final badgeColor = color ?? theme.colorScheme.error;
    final badgeTextColor = textColor ?? theme.colorScheme.onError;

    final double defaultSize = showDot
        ? (isTablet ? 10.0 : 8.0)
        : (isTablet ? 20.0 : 16.0);
    final double finalSize = size ?? defaultSize;
    final double fontSize = isTablet ? 11.0 : 9.0;

    if (showDot) {
      return Container(
        width: finalSize,
        height: finalSize,
        decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
      );
    }

    if (text == null || text!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 6.0 : 4.0,
        vertical: isTablet ? 3.0 : 2.0,
      ),
      constraints: BoxConstraints(minWidth: finalSize, minHeight: finalSize),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(finalSize / 2),
      ),
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Text(
          text!,
          style: (textStyle ?? const TextStyle()).copyWith(
            color: badgeTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

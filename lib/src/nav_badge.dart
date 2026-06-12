import 'package:flutter/material.dart';

/// A configuration class for displaying badges on bottom navigation items.
class BottomNavBadge {
  /// The text content of the badge. If null or empty, the badge will render as a simple dot.
  final String? text;

  /// The background color of the badge. Defaults to red.
  final Color? color;

  /// The text style of the badge content.
  final TextStyle? textStyle;

  /// Offset to adjust the position of the badge relative to the icon.
  final Offset? offset;

  /// Controls the visibility of the badge. Defaults to true.
  final bool showBadge;

  const BottomNavBadge({
    this.text,
    this.color,
    this.textStyle,
    this.offset,
    this.showBadge = true,
  });
}

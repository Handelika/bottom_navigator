import 'package:flutter/material.dart';

/// A model representing a single item in the [BottomNavBar].
class BottomNavItem {
  /// The icon to display for this item.
  final IconData icon;

  /// The text label to display below or next to the icon.
  final String label;

  /// A custom widget to display instead of the icon.
  /// If provided, [icon] will be ignored.
  final Widget? customWidget;

  /// The color of the item when it is active (selected).
  /// This affects the icon color and indicator color.
  /// If null, the active color from the nav bar's theme will be used.
  final Color? activeColor;

  /// The widget to display when this item is selected.
  /// This is optional and can be used to handle navigation logic.
  final Widget? screen;

  /// Whether this item should be treated as a center action button.
  final bool isCenterAction;

  /// Optional callback fired when this item is tapped.
  final VoidCallback? onTap;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeColor,
    this.screen,
    this.customWidget,
    this.isCenterAction = false,
    this.onTap,
  });
}

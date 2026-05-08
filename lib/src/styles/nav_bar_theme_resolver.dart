import 'package:flutter/material.dart';

class NavBarThemeColors {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  const NavBarThemeColors({
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
  });
}

NavBarThemeColors resolveNavBarThemeColors({
  required ThemeData theme,
  required BottomNavigationBarThemeData navTheme,
  required Color? backgroundColor,
  required Color? selectedItemColor,
  required Color? unselectedItemColor,
}) {
  return NavBarThemeColors(
    backgroundColor:
        backgroundColor ??
        navTheme.backgroundColor ??
        (theme.brightness == Brightness.dark
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.2)),
    selectedItemColor:
        selectedItemColor ?? navTheme.selectedItemColor ?? Colors.white,
    unselectedItemColor:
        unselectedItemColor ??
        navTheme.unselectedItemColor ??
        (theme.brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.5)
            : Colors.black.withValues(alpha: 0.5)),
  );
}

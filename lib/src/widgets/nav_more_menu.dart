import 'dart:ui';
import 'package:flutter/material.dart';
import '../nav_item.dart';
import '../nav_badge.dart';

class NavMoreMenu extends StatelessWidget {
  final bool isMoreOpen;
  final double borderRadius;
  final double blurAmount;
  final Color backgroundColor;
  final List<BottomNavItem> extraItems;
  final int displayItemsCount;
  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? textStyle;
  final ValueChanged<int> onItemTap;
  final bool isTablet;
  final double horizontalMargin;
  final double bottomPadding;

  const NavMoreMenu({
    super.key,
    required this.isMoreOpen,
    required this.borderRadius,
    required this.blurAmount,
    required this.backgroundColor,
    required this.extraItems,
    required this.displayItemsCount,
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.textStyle,
    required this.onItemTap,
    this.isTablet = false,
    this.horizontalMargin = 0.0,
    this.bottomPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      bottom: isMoreOpen ? (isTablet ? 110 : 80) + bottomPadding : -400,
      right: horizontalMargin + (isTablet ? 40 : 0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isMoreOpen ? 1 : 0,
        child: Container(
          width: isTablet ? 260 : 150,
          padding: EdgeInsets.all(isTablet ? 16 : 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: extraItems.asMap().entries.map((entry) {
                  final idx = entry.key + displayItemsCount;
                  final item = entry.value;
                  final isSelected = currentIndex == idx;

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isMoreOpen ? () => onItemTap(idx) : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 20 : 12,
                        horizontal: isTablet ? 24 : 16,
                      ),
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.transparent,
                      child: Row(
                        children: [
                          _buildBadge(
                            item.customWidget != null
                                ? SizedBox(
                                    width: isTablet ? 28 : 20,
                                    height: isTablet ? 28 : 20,
                                    child: Center(child: item.customWidget),
                                  )
                                : Icon(
                                    item.icon,
                                    color: isSelected
                                        ? (item.activeColor ?? selectedColor)
                                        : unselectedColor,
                                    size: isTablet ? 28 : 20,
                                  ),
                            item.badge,
                          ),
                          SizedBox(width: isTablet ? 18 : 12),
                          Expanded(
                            child: Text(
                              item.label,
                              style:
                                  (textStyle ??
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium!)
                                      .copyWith(
                                        color: isSelected
                                            ? selectedColor
                                            : unselectedColor,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(Widget child, BottomNavBadge? badge) {
    if (badge == null || !badge.showBadge) return child;

    final isDot = badge.text == null || badge.text!.isEmpty;

    Widget badgeWidget;
    if (isDot) {
      badgeWidget = Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: badge.color ?? Colors.red,
          shape: BoxShape.circle,
        ),
      );
    } else {
      badgeWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        constraints: const BoxConstraints(minWidth: 16.0, minHeight: 16.0),
        decoration: BoxDecoration(
          color: badge.color ?? Colors.red,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          badge.text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
          ).merge(badge.textStyle),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: badge.offset?.dy ?? -8.0,
          right: badge.offset?.dx ?? -8.0,
          child: badgeWidget,
        ),
      ],
    );
  }
}

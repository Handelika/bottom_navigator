import 'dart:ui';

import 'package:flutter/material.dart';

import '../nav_item.dart';

class NavMoreMenu extends StatelessWidget {
  final bool isMoreOpen;
  final double borderRadius;
  final double blurAmount;
  final Color backgroundColor;
  final List<BottomNavItem> extraItems;
  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? textStyle;
  final ValueChanged<int> onItemTap;

  const NavMoreMenu({
    super.key,
    required this.isMoreOpen,
    required this.borderRadius,
    required this.blurAmount,
    required this.backgroundColor,
    required this.extraItems,
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.textStyle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      bottom: isMoreOpen ? 80 : -200,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isMoreOpen ? 1 : 0,
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(8),
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
                  final idx = entry.key + 3;
                  final item = entry.value;
                  final isSelected = currentIndex == idx;

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isMoreOpen ? () => onItemTap(idx) : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected ? selectedColor : unselectedColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
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
                                        fontSize: 14,
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
}

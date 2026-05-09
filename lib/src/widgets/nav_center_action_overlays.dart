import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../nav_item.dart';

/// A widget that builds the specialized center action button overlays.
class NavCenterActionOverlays extends StatelessWidget {
  final List<BottomNavItem> items;
  final int midIndex;
  final bool hasExternalCenterButton;
  final bool hasMore;
  final int displayItemsCount;
  final EdgeInsets padding;
  final Function(int) onItemTapped;
  final bool isTablet;

  const NavCenterActionOverlays({
    super.key,
    required this.items,
    required this.midIndex,
    required this.hasExternalCenterButton,
    required this.hasMore,
    required this.displayItemsCount,
    required this.padding,
    required this.onItemTapped,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      // Inject gap for external center button
      if (hasExternalCenterButton && i == midIndex) {
        children.add(const Expanded(child: SizedBox.shrink()));
      }

      final item = items[i];
      if (item.isCenterAction) {
        children.add(
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onItemTapped(i);
                },
                child: Container(
                  width: isTablet ? 72 : 60,
                  height: isTablet ? 72 : 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isTablet ? 22 : 18),
                    gradient: LinearGradient(
                      colors: [
                        item.activeColor ??
                            Theme.of(context).colorScheme.primary,
                        (item.activeColor ??
                                Theme.of(context).colorScheme.primary)
                            .withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (item.activeColor ??
                                    Theme.of(context).colorScheme.primary)
                                .withValues(alpha: 0.5),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        item.customWidget ??
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: isTablet ? 34 : 28,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        children.add(const Expanded(child: SizedBox.shrink()));
      }

      if (hasMore && i == displayItemsCount - 1) {
        // After displayed items, add the 'More' slot placeholder
        children.add(const Expanded(child: SizedBox.shrink()));
        break;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding.horizontal / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}

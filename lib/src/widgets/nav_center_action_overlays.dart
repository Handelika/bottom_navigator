import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../nav_item.dart';

/// A widget that builds the specialized center action button overlays.
class NavCenterActionOverlays extends StatelessWidget {
  final List<BottomNavItem> items;
  final double itemWidth;
  final int midIndex;
  final bool hasExternalCenterButton;
  final EdgeInsets padding;
  final Function(int) onItemTapped;

  const NavCenterActionOverlays({
    super.key,
    required this.items,
    required this.itemWidth,
    required this.midIndex,
    required this.hasExternalCenterButton,
    required this.padding,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> overlays = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      if (item.isCenterAction) {
        // Calculate position, accounting for the gap if an external FAB exists
        final leftOffset = (hasExternalCenterButton && i >= midIndex)
            ? (i + 1) * itemWidth
            : i * itemWidth;

        overlays.add(
          Positioned(
            left: leftOffset + padding.left,
            width: itemWidth,
            top: -22,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onItemTapped(i);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
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
                        const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Stack(clipBehavior: Clip.none, children: overlays);
  }
}

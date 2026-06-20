## 0.0.4

* Added `centerButtonOffset` parameter to customize the vertical position of the center action button.
* Fixed a `RangeError` exception in `_BottomNavBarState._onItemTapped` when selecting items or the center button.
* Fixed navigation indicator line position, rendering it above the item text label if labels are shown, or above the icon if they are hidden.

## 0.0.3

* Added custom Badge support (`BottomNavBadge`) to navigation items.
* Supports numeric, text, and dot-only badges.
* Supports custom badge backgrounds, text styles, and offsets.
* Automatically shows a summary dot badge on the "More" button when hidden items have active badges.

## 0.0.2

* Updated package release to `0.0.2`.
* Clarified documentation and install instructions.
* Confirmed support for all current indicator styles, including Pill, Line, Square, Circle, and None.
* Reinforced scroll-to-hide behavior and overflow handling in docs.
* Added support for custom widget in BottomNavItem.
* Added tablet and phone responsiveness.
* Added active color foe navigation item.
* Added text style foe navigation item.(In Beta)
* Classic Navigation Bottom bar updated
* Reformated names for better readability.


## 0.0.1

* Initial release of `bottom_navigator`.
* Features 4 navigation variants: Classic, Docked, Floating, and Notched.
* Glassmorphism support with customizable blur.
* Automatic item overflow management (Auto-More).
* Customizable indicator styles (Pill, Dot, Line, Square).
* Scroll-to-hide functionality.

import 'package:flutter/material.dart';

class FridgeBottomNavBar extends StatelessWidget {
  const FridgeBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.onFabTap,
  });

  final int currentIndex;
  final void Function(int index)? onTap;
  final VoidCallback? onFabTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavItem(
                  icon: Icons.kitchen_rounded,
                  label: 'Home',
                  isSelected: currentIndex == 0,
                  onTap: () => onTap?.call(0),
                ),
                _NavItem(
                  icon: Icons.grid_view_rounded,
                  label: null,
                  isSelected: currentIndex == 1,
                  onTap: () => onTap?.call(1),
                ),
                _NavItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: null,
                  isSelected: currentIndex == 2,
                  onTap: () => onTap?.call(2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Material(
            color: const Color(0xFF2196F3),
            shape: const CircleBorder(),
            elevation: 4,
            shadowColor: Colors.black26,
            child: InkWell(
              onTap: onFabTap,
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 56,
                height: 56,
                child: Icon(Icons.add_rounded, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String? label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  label!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            size: 24,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}

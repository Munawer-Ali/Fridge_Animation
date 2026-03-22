import 'package:flutter/material.dart';

import '../data/food_item_details.dart';
import '../models/food_item.dart';
import 'fridge_item_detail_tooltip.dart';

class FridgeItemsOverlay extends StatelessWidget {
  const FridgeItemsOverlay({
    super.key,
    required this.items,
  });

  final List<FoodItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final mediaSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        const size = 48.0;
        final eggs = items.where((item) => item.id == 'egg').toList();
        final others = items.where((item) => item.id != 'egg').toList();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            ...others.map((item) {
              final left = (w * item.x) - (size / 2);
              final top = (h * item.y) - (size / 2);
              return Positioned(
                left: left.clamp(0.0, w - size),
                top: top.clamp(0.0, h - size),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (d) => _showItemDetail(context, item, d.globalPosition),
                  child: Image.asset(
                    item.assetPath,
                    width: size,
                    height: size,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(
                      Icons.restaurant,
                      size: size,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              );
            }),
            ...List.generate(eggs.length, (index) {
              final egg = eggs[index];
              final right = 80.0 - (index * 10.0);
              return Positioned(
                right: right,
                top: mediaSize.height * 0.334,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (d) => _showItemDetail(context, egg, d.globalPosition),
                  child: SizedBox(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      ClipRect(
                        clipper: _TopHalfClipper(),
                        child: Transform.flip(
                          flipX: true,
                          child: Image.asset(
                            egg.assetPath,
                            width: size,
                            height: size,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.restaurant,
                              size: size,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                      ClipRect(
                        clipper: _BottomHalfClipper(),
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            egg.assetPath,
                            width: size,
                            height: size,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.restaurant,
                              size: size,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

void _showItemDetail(BuildContext context, FoodItem item, Offset globalPosition) {
  final detail = getFoodItemDetail(item.id);
  const tipOffsetFromLeft = 23.0;
  const belowTapDy = 8.0;

  final left = globalPosition.dx - tipOffsetFromLeft;
  final top = globalPosition.dy + belowTapDy;

  showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.28),
    transitionDuration: Duration.zero,
    pageBuilder: (dialogContext, _, _) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(dialogContext).pop(),
                child: const SizedBox.expand(),
              ),
            ),
            Positioned(
              left: left,
              top: top,
              child: GestureDetector(
                onTap: () {},
                child: FridgeItemDetailTooltip(
                  detail: detail,
                  onClose: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _TopHalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width, size.height / 2);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

class _BottomHalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

import 'package:flutter/material.dart';

import '../data/food_items_data.dart';
import 'food_item_card.dart';

class FoodListSection extends StatelessWidget {
  const FoodListSection({
    super.key,
    this.onAddFood,
    this.onSettingsTap,
  });

  final void Function(String foodId)? onAddFood;
  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
          child: Row(
            children: [
              const Text(
                'Your Fridge is empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D3D3D),
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              if (onSettingsTap != null)
                IconButton(
                  onPressed: onSettingsTap,
                  icon: Icon(
                    Icons.settings_rounded,
                    color: Colors.grey.shade600,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 15),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              return FoodItemCard(
                item: item,
                onAdd: () => onAddFood?.call(item.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

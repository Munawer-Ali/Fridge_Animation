import 'food_item.dart';

class FoodCategory {
  const FoodCategory({
    required this.name,
    required this.items,
  });

  final String name;
  final List<FoodItem> items;
}

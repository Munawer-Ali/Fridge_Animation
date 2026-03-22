import '../core/constants/app_assets.dart';
import '../models/food_item.dart';

import 'fridge_inner_positions.dart';

FoodItem _item(String id, String name, String assetPath) {
  final pos = getFridgeInnerPosition(id);
  return FoodItem(id: id, name: name, assetPath: assetPath, x: pos.$1, y: pos.$2);
}

final List<FoodItem> foodItems = [
  _item('tomato', 'Tomato', AppAssets.foodTomato),
  _item('ham', 'Ham Leg', AppAssets.foodHam),
  _item('cabbage', 'Cabbage', AppAssets.foodCabbage),
  _item('bread', 'Bread', AppAssets.foodBread),
  _item('chicken', 'Chicken', AppAssets.foodChickenMeat),
];

FoodItem? getFoodItemById(String id) {
  try {
    return foodItems.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
}

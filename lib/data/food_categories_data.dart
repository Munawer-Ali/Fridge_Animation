import '../core/constants/app_assets.dart';
import '../models/food_category.dart';
import '../models/food_item.dart';

import 'fridge_inner_positions.dart';

FoodItem _item(String id, String name, String assetPath) {
  final pos = getFridgeInnerPosition(id);
  return FoodItem(id: id, name: name, assetPath: assetPath, x: pos.$1, y: pos.$2);
}

List<FoodCategory> get foodCategories => [
      FoodCategory(
        name: 'Popular items',
        items: [
          _item('tomato', 'Tomato', AppAssets.foodTomato),
          _item('pepper', 'Pepper', AppAssets.foodPepper),
          _item('egg', 'Egg', AppAssets.foodEgg),
          _item('bread', 'Bread', AppAssets.foodBread),
          _item('ice_cream', 'Ice cream', AppAssets.foodIceCream),
          _item('butter', 'Butter', AppAssets.foodButter),
          _item('cheese', 'Cheese', AppAssets.foodCheese),
          _item('cake', 'Cake', AppAssets.foodCake),
          _item('onion', 'Onion', AppAssets.foodOnion),
          _item('steak', 'Steak', AppAssets.foodSteak),
          _item('chicken', 'Chicken', AppAssets.foodChickenMeat),
          _item('orange', 'Orange', AppAssets.foodOrange),
          _item('muskmelon', 'Muskmelon', AppAssets.foodMuskmelon),
          _item('ham', 'Ham leg', AppAssets.foodHam),
          _item('water', 'Water', AppAssets.foodWater),
        ],
      ),
      FoodCategory(
        name: 'Drinks',
        items: [
          _item('wine', 'Wine', AppAssets.foodWine),
          _item('beer', 'Beer', AppAssets.foodBeer),
          _item('energy', 'Energy', AppAssets.foodEnergy),
          _item('water', 'Water', AppAssets.foodWater),
        ],
      ),
      FoodCategory(
        name: 'Vegetables',
        items: [
          _item('radish', 'Radish', AppAssets.foodRadish),
          _item('cauliflower', 'Cauliflower', AppAssets.foodCauliflower),
          _item('tomato', 'Tomato', AppAssets.foodTomato),
          _item('bell_pepper', 'Bell pepper', AppAssets.foodBellPepper),
          _item('cabbage', 'Cabbage', AppAssets.foodCabbage),
          _item('onion', 'Onion', AppAssets.foodOnion),
        ],
      ),
    ];

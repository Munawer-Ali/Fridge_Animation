import '../models/food_item_detail.dart';

const Map<String, FoodItemDetail> _detailsById = {
  'cake': FoodItemDetail(
    title: 'Cake',
    description:
        "A cupcake is a high-calorie treat that's mostly carbs and fat, high in sugar, and low in protein.",
    carb: 'Carb: 38-45 g',
    protein: 'Protein: 3-5 g',
    fat: 'Fats: 14-18 g',
  ),
  'tomato': FoodItemDetail(
    title: 'Tomato',
    description:
        'Tomatoes are low in calories, rich in vitamin C and lycopene, with natural sugars and fiber.',
    carb: 'Carb: 3-5 g',
    protein: 'Protein: 0.5-1 g',
    fat: 'Fats: 0-0.2 g',
  ),
  'bread': FoodItemDetail(
    title: 'Bread',
    description:
        'Bread is mainly carbohydrates from flour, moderate protein, and low fat unless enriched.',
    carb: 'Carb: 40-50 g',
    protein: 'Protein: 6-10 g',
    fat: 'Fats: 1-4 g',
  ),
  'egg': FoodItemDetail(
    title: 'Egg',
    description:
        'Eggs are high-quality protein with healthy fats and micronutrients like choline and B12.',
    carb: 'Carb: ~1 g',
    protein: 'Protein: 6-7 g',
    fat: 'Fats: 5-6 g',
  ),
  'chicken': FoodItemDetail(
    title: 'Chicken',
    description:
        'Chicken breast is lean protein; darker cuts have more fat. Good source of B vitamins.',
    carb: 'Carb: 0 g',
    protein: 'Protein: 25-30 g',
    fat: 'Fats: 3-15 g',
  ),
  'ham': FoodItemDetail(
    title: 'Ham',
    description:
        'Ham is cured pork: high protein but often high in sodium and saturated fat.',
    carb: 'Carb: 0-2 g',
    protein: 'Protein: 18-22 g',
    fat: 'Fats: 4-12 g',
  ),
  'cabbage': FoodItemDetail(
    title: 'Cabbage',
    description:
        'Low-calorie cruciferous vegetable with fiber, vitamin C, and antioxidants.',
    carb: 'Carb: 5-7 g',
    protein: 'Protein: 1-2 g',
    fat: 'Fats: 0-0.2 g',
  ),
  'cheese': FoodItemDetail(
    title: 'Cheese',
    description:
        'Cheese is calorie-dense: protein and calcium with saturated fat depending on variety.',
    carb: 'Carb: 0-2 g',
    protein: 'Protein: 6-25 g',
    fat: 'Fats: 6-30 g',
  ),
  'butter': FoodItemDetail(
    title: 'Butter',
    description:
        'Butter is almost entirely milk fat; very high in saturated fat and calories.',
    carb: 'Carb: 0 g',
    protein: 'Protein: 0.1 g',
    fat: 'Fats: 11-12 g',
  ),
  'pepper': FoodItemDetail(
    title: 'Pepper',
    description:
        'Chili peppers add heat with capsaicin; low calories, some vitamin C.',
    carb: 'Carb: 4-9 g',
    protein: 'Protein: 1-2 g',
    fat: 'Fats: 0.3-1 g',
  ),
  'onion': FoodItemDetail(
    title: 'Onion',
    description:
        'Onions are low calorie, mostly water and carbs, with prebiotic fiber.',
    carb: 'Carb: 9-12 g',
    protein: 'Protein: 1-2 g',
    fat: 'Fats: 0-0.2 g',
  ),
  'orange': FoodItemDetail(
    title: 'Orange',
    description:
        'Oranges are known for vitamin C, natural sugars, and fiber when eaten whole.',
    carb: 'Carb: 12-15 g',
    protein: 'Protein: 1 g',
    fat: 'Fats: 0-0.2 g',
  ),
  'muskmelon': FoodItemDetail(
    title: 'Muskmelon',
    description:
        'Melon is hydrating, mostly water and natural sugars, with vitamin A and C.',
    carb: 'Carb: 8-13 g',
    protein: 'Protein: 0.5-1 g',
    fat: 'Fats: 0-0.3 g',
  ),
  'ice_cream': FoodItemDetail(
    title: 'Ice cream',
    description:
        'Ice cream is high in sugar and fat, moderate protein from dairy.',
    carb: 'Carb: 20-35 g',
    protein: 'Protein: 3-5 g',
    fat: 'Fats: 10-18 g',
  ),
  'steak': FoodItemDetail(
    title: 'Steak',
    description:
        'Beef steak is rich in protein, iron, and B12; fat varies by cut.',
    carb: 'Carb: 0 g',
    protein: 'Protein: 22-28 g',
    fat: 'Fats: 8-25 g',
  ),
  'wine': FoodItemDetail(
    title: 'Wine',
    description:
        'Wine contains alcohol and residual sugars; calories mostly from alcohol.',
    carb: 'Carb: 0-4 g',
    protein: 'Protein: 0 g',
    fat: 'Fats: 0 g',
  ),
  'beer': FoodItemDetail(
    title: 'Beer',
    description:
        'Beer is fermented grains: moderate carbs and alcohol, low protein.',
    carb: 'Carb: 10-15 g',
    protein: 'Protein: 1-2 g',
    fat: 'Fats: 0 g',
  ),
  'water': FoodItemDetail(
    title: 'Water',
    description:
        'Water has no calories. Essential for hydration and bodily functions.',
    carb: 'Carb: 0 g',
    protein: 'Protein: 0 g',
    fat: 'Fats: 0 g',
  ),
  'energy': FoodItemDetail(
    title: 'Energy drink',
    description:
        'Energy drinks are high in sugar or sweeteners and often caffeine.',
    carb: 'Carb: 25-40 g',
    protein: 'Protein: 0 g',
    fat: 'Fats: 0 g',
  ),
  'radish': FoodItemDetail(
    title: 'Radish',
    description:
        'Radishes are crunchy, very low calorie, with vitamin C and fiber.',
    carb: 'Carb: 2-4 g',
    protein: 'Protein: 0.5-1 g',
    fat: 'Fats: 0-0.2 g',
  ),
  'cauliflower': FoodItemDetail(
    title: 'Cauliflower',
    description:
        'Low-carb vegetable, high in fiber and vitamin C, popular as rice substitute.',
    carb: 'Carb: 4-6 g',
    protein: 'Protein: 2-3 g',
    fat: 'Fats: 0-0.5 g',
  ),
  'bell_pepper': FoodItemDetail(
    title: 'Bell pepper',
    description:
        'Sweet peppers are low calorie, rich in vitamin C and antioxidants.',
    carb: 'Carb: 4-7 g',
    protein: 'Protein: 0.5-1 g',
    fat: 'Fats: 0-0.3 g',
  ),
};

String _titleFromId(String id) {
  return id
      .split('_')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

FoodItemDetail getFoodItemDetail(String id) {
  return _detailsById[id] ??
      FoodItemDetail(
        title: _titleFromId(id),
        description: 'Values depend on brand and serving size.',
        carb: 'Carb: —',
        protein: 'Protein: —',
        fat: 'Fats: —',
      );
}

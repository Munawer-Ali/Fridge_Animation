import 'package:flutter_test/flutter_test.dart';
import 'package:frige_animation/data/food_categories_data.dart';
import 'package:frige_animation/data/food_item_details.dart';
import 'package:frige_animation/data/food_items_data.dart';
import 'package:frige_animation/data/fridge_inner_positions.dart';

void main() {
  group('getFoodItemById', () {
    test('returns item for known id', () {
      final item = getFoodItemById('tomato');
      expect(item, isNotNull);
      expect(item!.id, 'tomato');
      expect(item.name, 'Tomato');
    });

    test('returns null for unknown id', () {
      expect(getFoodItemById('not_a_food'), isNull);
    });
  });

  group('getFridgeInnerPosition', () {
    test('returns mapped position for known id', () {
      final (x, y) = getFridgeInnerPosition('tomato');
      expect(x, greaterThan(0));
      expect(x, lessThanOrEqualTo(1));
      expect(y, greaterThan(0));
      expect(y, lessThanOrEqualTo(1));
    });

    test('returns center for unknown id', () {
      final (x, y) = getFridgeInnerPosition('unknown_id_xyz');
      expect(x, 0.5);
      expect(y, 0.5);
    });
  });

  group('getFoodItemDetail', () {
    test('returns cake copy from reference data', () {
      final d = getFoodItemDetail('cake');
      expect(d.title, 'Cake');
      expect(d.description, contains('cupcake'));
      expect(d.carb, contains('Carb'));
    });

    test('builds title for unknown id', () {
      final d = getFoodItemDetail('mystery_snack');
      expect(d.title, 'Mystery Snack');
    });
  });

  group('foodCategories', () {
    test('has categories with items', () {
      expect(foodCategories, isNotEmpty);
      for (final c in foodCategories) {
        expect(c.name, isNotEmpty);
        expect(c.items, isNotEmpty);
      }
    });
  });

  group('fridgeInnerPositions', () {
    test('every entry has valid fractions', () {
      for (final e in fridgeInnerPositions.entries) {
        expect(e.value.x, inInclusiveRange(0.0, 1.0));
        expect(e.value.y, inInclusiveRange(0.0, 1.0));
      }
    });
  });
}

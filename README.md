# Fridge Animation

Flutter app with a fridge-themed UI: video playback, scrollable food picker, “add to fridge” flow with quantities, and item overlays with nutrition tooltips.

## Quick start

```bash
cd frige_animation
flutter pub get
flutter run
```

## Dependencies

| Package        | Role                          |
|----------------|-------------------------------|
| `video_player` | Fridge opening / interior video |
| `cupertino_icons` | iOS-style icons            |

## Project structure

```
lib/
├── main.dart
├── core/constants/
│   └── app_assets.dart          # Asset paths (video + food PNGs)
├── data/
│   ├── food_items_data.dart     # Top carousel items + getFoodItemById
│   ├── food_categories_data.dart# Categories for Add to Fridge screen
│   ├── food_item_details.dart   # Tooltip copy + macros per food id
│   └── fridge_inner_positions.dart # Normalized x,y (0–1) inside fridge
├── models/
│   ├── food_item.dart
│   ├── food_item_detail.dart
│   └── food_category.dart
├── screens/
│   ├── home_screen.dart         # Main layout: list, video, overlay, nav
│   ├── video_player_screen.dart # Asset video, tap to play, onVideoStarted
│   └── add_to_fridge_screen.dart# Search → Continue → quantity → Add
└── widgets/
    ├── food_list_section.dart
    ├── food_item_card.dart
    ├── fridge_items_overlay.dart# Items on video + tap → detail dialog
    ├── fridge_item_detail_tooltip.dart
    ├── add_to_fridge_item_tile.dart
    └── bottom_nav_bar.dart
```

## Assets

Registered in `pubspec.yaml`:

- `assets/frige_animation.mp4` — fridge animation video
- `assets/foods/` — food images (PNG), referenced from `app_assets.dart`

## Main features

1. **Home**
   - “Your Fridge is empty” horizontal food list (`+` adds to fridge overlay).
   - Center: `VideoPlayerScreen` (tap to start playback).
   - Hint “Click to open fridge” after playback starts; optional delayed **Add to Fridge** when the fridge is empty (timer tied to video duration at 3× speed — see `home_screen.dart`).
   - `FridgeItemsOverlay`: draws items at fractional positions from `fridge_inner_positions.dart`.
   - **Eggs**: special stacked rendering; multiple eggs offset horizontally.
   - **Tap an overlay item**: dark tooltip with title, description, carb/protein/fat (`food_item_details.dart`).

2. **Add to Fridge**
   - Search + category grids → **Continue** → quantity screen (per-item +/-, bottom strip) → **Add to Fridge** returns expanded `List<FoodItem>` by quantity.

3. **Bottom bar**
   - Home / list / chat placeholders + FAB (opens Add to Fridge).

## Customizing positions

Edit **`lib/data/fridge_inner_positions.dart`**: each food `id` maps to `(x, y)` in **0–1** relative to the video overlay (inner fridge area).  
Debug tap logging on the fridge area is available in `home_screen.dart` (prints pixel + fraction) if you need to re-tune.

## Customizing copy

- **Carousel items**: `food_items_data.dart`
- **Add-to-fridge catalog**: `food_categories_data.dart`
- **Tooltip text**: `food_item_details.dart` (`getFoodItemDetail`)

## Tests

```bash
# All tests
flutter test

# Single file
flutter test test/food_data_test.dart
flutter test test/widget_test.dart
```

- **`test/food_data_test.dart`** — `getFoodItemById`, `getFridgeInnerPosition`, `getFoodItemDetail`, categories, position map bounds.
- **`test/widget_test.dart`** — smoke: app builds and shows “Your Fridge is empty”.

## Analysis

```bash
flutter analyze lib test
```

## Build release (examples)

```bash
flutter build apk
flutter build ios
flutter build macos
```

## Notes

- Food icons in `assets/foods/` may use third-party artwork (e.g. Icons8 / Twemoji); keep licenses in mind for store builds.
- `VideoPlayerScreen` exposes `onVideoStarted` so the home screen can sync UI (hint + button delay) with the first play.

## License

This project’s **source code** is licensed under the [MIT License](LICENSE).

`publish_to: 'none'` in `pubspec.yaml` only means the package is not published to pub.dev; the repo can still be public on GitHub.

**Assets:** Images under `assets/foods/` (and any other bundled media) may come from third parties with their own terms—check each source before redistributing commercially.

import 'package:flutter/material.dart';

import 'package:frige_animation/screens/add_to_fridge_screen.dart';
import 'package:frige_animation/screens/video_player_screen.dart';

import '../data/food_items_data.dart';
import '../models/food_item.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/food_list_section.dart';
import '../widgets/fridge_items_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final List<FoodItem> _itemsInFridge = [];
  bool showAddToFridge = false;
  bool _videoStarted = false;
  bool _addToFridgeTimerStarted = false;

  void _onAddFood(String foodId) {
    final item = getFoodItemById(foodId);
    if (item == null) return;
    setState(() => _itemsInFridge.add(item));
  }

  void _onSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings')),
    );
  }

  void _onFabTap() {
    _openAddToFridge();
  }

  Future<void> _openAddToFridge() async {
    final result = await Navigator.of(context).push<List<FoodItem>>(
      MaterialPageRoute(
        builder: (context) => const AddToFridgeScreen(),
      ),
    );
    if (result != null && result.isNotEmpty && mounted) {
      setState(() => _itemsInFridge.addAll(result));
    }
  }
  
  void _onVideoStarted(Duration duration) {
    if (_addToFridgeTimerStarted) return;
    _addToFridgeTimerStarted = true;
    setState(() => _videoStarted = true);

    // Video plays at 3x speed in VideoPlayerScreen.
    final delayedMs = (duration.inMilliseconds / 3).ceil();
    Future.delayed(Duration(milliseconds: delayedMs), () {
      if (!mounted) return;
      setState(() => showAddToFridge = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffFDF8F9),
      body: Stack(
        children: [
        
          Positioned(
            top: size.height * 0.22,
            left: -15,
            right: 0,
            bottom: size.height * 0.08,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) {
                    final local = details.localPosition;
                    final fx = (local.dx / w).clamp(0.0, 1.0);
                    final fy = (local.dy / h).clamp(0.0, 1.0);
                    debugPrint('tap x: ${local.dx.toStringAsFixed(1)}, y: ${local.dy.toStringAsFixed(1)} | fraction x: ${fx.toStringAsFixed(3)}, y: ${fy.toStringAsFixed(3)}');
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayerScreen(onVideoStarted: _onVideoStarted),
                      FridgeItemsOverlay(items: _itemsInFridge),
                      if (_itemsInFridge.isEmpty && showAddToFridge)
                        Positioned(
                          top: size.height * 0.22,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Material(
                              color: const Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(28),
                              child: InkWell(
                                onTap: _openAddToFridge,
                                borderRadius: BorderRadius.circular(28),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                  child: Text(
                                    'Add to Fridge',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                 
                      if (!_videoStarted)
                        Positioned(
                          top: size.height * 0.14,
                          left: size.width * 0.26,
                          child: Text(
                            'Click to open fridge',
                            style: TextStyle(
                              color: Colors.black.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          
            Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: FoodListSection(
              onAddFood: _onAddFood,
              onSettingsTap: _onSettings,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: FridgeBottomNavBar(
              currentIndex: _navIndex,
              onTap: (index) => setState(() => _navIndex = index),
              onFabTap: _onFabTap,
            ),
          ),
        ],
      ),
    );
  }
}
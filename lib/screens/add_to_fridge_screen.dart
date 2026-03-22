import 'package:flutter/material.dart';

import '../data/food_categories_data.dart';
import '../models/food_category.dart';
import '../models/food_item.dart';
import '../widgets/add_to_fridge_item_tile.dart';

class AddToFridgeScreen extends StatefulWidget {
  const AddToFridgeScreen({super.key});

  @override
  State<AddToFridgeScreen> createState() => _AddToFridgeScreenState();
}

class _AddToFridgeScreenState extends State<AddToFridgeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedIds = {};
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FoodItem> get _selectedItems {
    final all = foodCategories.expand((c) => c.items).toList();
    final seen = <String>{};
    return all.where((e) => _selectedIds.contains(e.id) && seen.add(e.id)).toList();
  }

  List<FoodCategory> get _filteredCategories {
    if (_query.trim().isEmpty) {
      return foodCategories;
    }
    final q = _query.trim().toLowerCase();
    return foodCategories.map((cat) {
      final items = cat.items.where((i) => i.name.toLowerCase().contains(q)).toList();
      return FoodCategory(name: cat.name, items: items);
    }).where((c) => c.items.isNotEmpty).toList();
  }

  void _onAdd(FoodItem item) {
    setState(() => _selectedIds.add(item.id));
  }

  Future<void> _continue() async {
    if (_selectedItems.isEmpty) return;
    final result = await Navigator.of(context).push<List<FoodItem>>(
      MaterialPageRoute(
        builder: (context) => _SelectedItemsQuantityScreen(items: _selectedItems),
      ),
    );
    if (result != null && mounted) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search Items',
                prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                final cat = _filteredCategories[index];
                return _CategorySection(
                  name: cat.name,
                  items: cat.items,
                  onAdd: _onAdd,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: _selectedItems.isEmpty ? null : _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: Text(
                _selectedItems.isEmpty
                    ? 'Select items to continue'
                    : 'Continue (${_selectedItems.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedItemsQuantityScreen extends StatefulWidget {
  const _SelectedItemsQuantityScreen({
    required this.items,
  });

  final List<FoodItem> items;

  @override
  State<_SelectedItemsQuantityScreen> createState() =>
      _SelectedItemsQuantityScreenState();
}

class _SelectedItemsQuantityScreenState extends State<_SelectedItemsQuantityScreen> {
  late final List<FoodItem> _items;
  late final Map<String, int> _qtyById;
  int _currentIndex = 0;
  int _previewAnimTick = 0;

  FoodItem get _currentItem => _items[_currentIndex];

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _qtyById = {
      for (final item in _items) item.id: 1,
    };
  }

  int _qtyOf(FoodItem item) => _qtyById[item.id] ?? 1;

  void _inc() {
    final id = _currentItem.id;
    setState(() {
      _qtyById[id] = (_qtyById[id] ?? 1) + 1;
      _previewAnimTick++;
    });
  }

  void _dec() {
    final id = _currentItem.id;
    final current = _qtyById[id] ?? 1;
    if (current <= 1) return;
    setState(() {
      _qtyById[id] = current - 1;
      _previewAnimTick++;
    });
  }

  void _next() {
    if (_currentIndex >= _items.length - 1) return;
    setState(() => _currentIndex++);
  }

  void _prev() {
    if (_currentIndex <= 0) return;
    setState(() => _currentIndex--);
  }

  void _submit() {
    final result = <FoodItem>[];
    for (final item in _items) {
      final qty = _qtyById[item.id] ?? 1;
      for (var i = 0; i < qty; i++) {
        result.add(item);
      }
    }
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentItem;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 2),
          Text(
            current.name,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w400,
            ),
          ),
        
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _arrowButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: _prev,
              ),
              const SizedBox(width: 28),
              SizedBox(
                width: 170,
                height: 170,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 8,
                      child: Container(
                        width: 120,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Image.asset(
                      current.assetPath,
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28),
              _arrowButton(
                icon: Icons.arrow_forward_ios_rounded,
                onTap: _next,
              ),
            ],
          ),
          const SizedBox(height: 4),
          _QuantityPreviewStrip(
            item: current,
            quantity: _qtyOf(current),
            tick: _previewAnimTick,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _roundQtyButton(icon: Icons.remove_rounded, onTap: _dec),
              const SizedBox(width: 26),
              Text(
                '${_qtyOf(current)}',
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 26),
              _roundQtyButton(icon: Icons.add_rounded, onTap: _inc),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(_items.length, (index) {
                    final item = _items[index];
                    final selected = index == _currentIndex;
                    return _bottomItemCard(
                      item: item,
                      selected: selected,
                      onTap: () => setState(() => _currentIndex = index),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Add to Fridge',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _arrowButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Icon(icon, size: 15, color: Colors.black54),
      ),
    );
  }

  Widget _roundQtyButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE5E7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.black54),
      ),
    );
  }

  Widget _bottomItemCard({
    required FoodItem item,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        padding: const EdgeInsets.fromLTRB(5, 4, 5, 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF2196F3) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD7D9),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF5A8AE), width: 0.8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'x',
                  style: TextStyle(
                    color: Color(0xFFD64555),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Image.asset(
              item.assetPath,
              width: 34,
              height: 34,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 2),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9),
            ),
            Text(
              'x${_qtyOf(item)}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: selected ? const Color(0xFF1E88E5) : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityPreviewStrip extends StatelessWidget {
  const _QuantityPreviewStrip({
    required this.item,
    required this.quantity,
    required this.tick,
  });

  final FoodItem item;
  final int quantity;
  final int tick;

  @override
  Widget build(BuildContext context) {
    final visibleCount = quantity > 5 ? 5 : quantity;
    return TweenAnimationBuilder<double>(
      key: ValueKey('${item.id}-$tick-$quantity'),
      tween: Tween(begin: 0.85, end: 1),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE6DFE1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(visibleCount, (index) {
              return Transform.translate(
                offset: Offset(index == 0 ? 0 : -index * 6, 0),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    item.assetPath,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }),
            if (quantity > 5)
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  '+${quantity - 5}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.name,
    required this.items,
    required this.onAdd,
  });

  final String name;
  final List<FoodItem> items;
  final void Function(FoodItem) onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              const crossCount = 5;
              const spacing = 8.0;
              final w = MediaQuery.sizeOf(context).width - 40;
              final itemWidth = (w - (crossCount - 1) * spacing) / crossCount;
              return Wrap(
                spacing: spacing,
                runSpacing: 16,
                children: items.map((item) {
                  return SizedBox(
                    width: itemWidth,
                    child: AddToFridgeItemTile(
                      item: item,
                      onAdd: () => onAdd(item),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

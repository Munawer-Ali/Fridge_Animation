// Normalized x,y inside the fridge interior (0–1 of overlay).

const Map<String, ({double x, double y})> fridgeInnerPositions = {
  // Shelf 1 (topmost) – y ~0.18–0.22
  'butter': (x: 0.32, y: 0.23),
  'cheese': (x: 0.50, y: 0.235),
  // Shelf 2 – y ~0.28–0.32
  'egg': (x: 0.26, y: 0.36),
  'pepper': (x: 0.40, y: 0.36),
  'onion': (x: 0.60, y: 0.36),
  // Shelf 3 – y ~0.38–0.42
  'orange': (x: 0.28, y: 0.35),
  'muskmelon': (x: 0.45, y: 0.35),
  'chicken': (x: 0.62, y: 0.35),
  // Shelf 4 (last open shelf above drawers) – y ~0.52–0.56
  'cake': (x: 0.26, y: 0.52),
  'bread': (x: 0.38, y: 0.52),
  'cabbage': (x: 0.55, y: 0.52),
  'ice_cream': (x: 0.63, y: 0.52),
  // Drawer 1 (upper) – y ~0.68–0.72
  'steak': (x: 0.26, y: 0.65),
  'beer': (x: 0.38, y: 0.65),
  'ham': (x: 0.55, y: 0.65),
  'wine': (x: 0.70, y: 0.65),
  // Drawer 2 (lower) – y ~0.78–0.82
  'tomato': (x: 0.28, y: 0.80),
  'radish': (x: 0.35, y: 0.79),
  'water': (x: 0.48, y: 0.79),
  'cauliflower': (x: 0.58, y: 0.78),
  'energy': (x: 0.66, y: 0.80),
  'bell_pepper': (x: 0.53, y: 0.79),
};

(double, double) getFridgeInnerPosition(String id) {
  final pos = fridgeInnerPositions[id];
  if (pos != null) return (pos.x, pos.y);
  return (0.5, 0.5);
}

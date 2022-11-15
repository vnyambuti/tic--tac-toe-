import 'dart:math';

enum TileeState { Empty, circle, cross }

List<List<TileeState>> chunk(List<TileeState> list, int size) {
  return List.generate(
      (list.length / size).ceil(),
      (index) =>
          list.sublist(index * size, min(index * size + size, list.length)));
}

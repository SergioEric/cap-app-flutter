import 'dart:math';

/// return a random number between 0 and max-1
/// ```dart
/// final rnd = random(4);
/// rnd >=0 and <4;
/// ```
/// `rnd` will never be 4
int random(int max) {
  return Random().nextInt(max);
}

/// return a List of int with values between 0 and 3
List<int> randomColorPositions(int picked) {
  assert(picked != null);
  var list = [picked];

  var n = list.length;

  while (n != 4) {
    var r = random(4);
    if (!list.contains(r)) {
      list.add(r);
      n++;
    }
  }

  return list;
}

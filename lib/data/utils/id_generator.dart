import 'dart:math';

class IdGenerator {
  IdGenerator._();

  static final Random _random = Random();

  static String generate() {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final suffix = _random.nextInt(900000) + 100000;
    return '${timestamp}_$suffix';
  }
}

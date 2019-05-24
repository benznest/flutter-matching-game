import 'dart:math';

class MyUtils{
  static int randomInt({int min = 1, int max = 5}) {
    Random random = Random();
    return random.nextInt(max) + min;
  }
}
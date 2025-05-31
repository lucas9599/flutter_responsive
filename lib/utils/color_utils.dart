import 'package:flutter/cupertino.dart';

///
///Ajusta as cores
///
abstract class ColorUtils {
  static Color adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    double normalize(int value) => value / 255.0;
    double clamp(double value) => value.clamp(0.0, 1.0);

    return Color.from(
      alpha: color.a,
      red: clamp(color.r + normalize(amount)),
      green: clamp(color.g + normalize(amount)),
      blue: clamp(color.b + normalize(amount)),
    );
  }
}

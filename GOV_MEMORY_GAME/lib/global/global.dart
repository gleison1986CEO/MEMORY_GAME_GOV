import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/gametheme.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:flutter/material.dart'
    show Alignment, Color, Gradient, HSLColor, LinearGradient;
import 'package:flutter/widgets.dart';

class Global {
  static final colors = _Colors();
  static final gameThemeGradients = _GameThemeGradients();
  static final gameTimesInSeconds = _GameTimesInSeconds();
}

class _GameTimesInSeconds {
  final Map<MapSize, Map<Difficulty, int>> times = {
    MapSize.fourxfour: {
      Difficulty.easy: 90,
      Difficulty.intermediate: 60,
      Difficulty.hard: 30,
    },
    MapSize.fivexsix: {
      Difficulty.easy: 240,
      Difficulty.intermediate: 180,
      Difficulty.hard: 60,
    },
    MapSize.sixxeight: {
      Difficulty.easy: 360,
      Difficulty.intermediate: 240,
      Difficulty.hard: 90
    }
  };
}

class _Colors {
  final lightIconColor = const Color(0XFFE7EAEB);
  late final lightIconColorDarker =
      HSLColor.fromColor(lightIconColor).withLightness(0.55).toColor();
  final darkIconColor = const Color.fromARGB(255, 47, 0, 203);
  late final darkIconColorLighter =
      HSLColor.fromColor(darkIconColor).withLightness(0.75).toColor();
}

class _GameThemeGradients {
  final Map<GameTheme, Gradient> gradients = {
    GameTheme.retro: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 25, 0, 255),
        Color.fromARGB(255, 253, 253, 253),
        Color.fromARGB(255, 255, 213, 0),
        Color.fromARGB(255, 0, 0, 0),
      ],
      stops: [
        0.55,
        0.8,
        0.85,
        1.0,
      ],
    )
  };
}

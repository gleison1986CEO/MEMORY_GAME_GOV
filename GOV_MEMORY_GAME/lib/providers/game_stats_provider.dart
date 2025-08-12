import 'dart:convert';
import 'dart:io';

import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:desenvolvimento_sustentavel_governo/models/game_stat.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class GameStatsProvider extends ChangeNotifier {
  final String _fileName = 'historico_jogo.json';

  List<GameStat> _gameStats = [];
  List<GameStat> get gameStats => _gameStats;

  GameStatsProvider() {
    _loadGameStats();

    //_fakeStatsForScreenShots();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<void> _loadGameStats() async {
    try {
      File file = await _localFile;
      if (!await file.exists()) {
        return;
      }
      String stringFromFile = await file.readAsString();

      if (kDebugMode) {
        print('\n\nGame Stats\n$stringFromFile');
      }

      List<dynamic> parsedListJson = jsonDecode(stringFromFile);

      _gameStats = List<GameStat>.from(
        parsedListJson.map(
          (e) => GameStat.fromJson(e),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    notifyListeners();
  }

  Future<void> _saveGameStats() async {
    String gameStats = jsonEncode(_gameStats);
    File file = await _localFile;
    file.writeAsString(gameStats);
  }

  void deleteAllStats() async {
    _gameStats.clear();
    notifyListeners();
    await _saveGameStats();
  }

  void addStat(GameStat stat) async {
    _gameStats.insert(0, stat);
    notifyListeners();
    await _saveGameStats();
  }

  void _fakeStatsForScreenShots() {
    for (int i = 0; i < 25; i++) {
      GameStat stat = GameStat(
        correct: 4,
        flips: 48 + i,
        win: i.isEven,
        mapSize: i.isEven ? MapSize.fivexsix : MapSize.fourxfour,
        difficulty: Difficulty.intermediate,
        gameDuration: Duration(seconds: 87 + i),
        gameStarted: DateTime.now(),
      );
      _gameStats.add(stat);
    }

    notifyListeners();
  }
}

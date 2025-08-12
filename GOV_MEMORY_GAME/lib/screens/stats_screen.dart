import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:desenvolvimento_sustentavel_governo/models/game_stat.dart';
import 'package:desenvolvimento_sustentavel_governo/providers/game_stats_provider.dart';
import 'package:desenvolvimento_sustentavel_governo/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ranking Geral',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(children: [
          const Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                    child: Text('Vitórias',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Nível',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Jogo',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Tempo',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text('Tentativas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13))),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<GameStatsProvider>().gameStats.length,
              itemBuilder: (BuildContext context, int index) {
                GameStat stat =
                    context.read<GameStatsProvider>().gameStats[index];
                return SizedBox(
                  height: 54,
                  child: Card(
                    color: Global.colors.darkIconColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Icon(
                              stat.win
                                  ? Icons.emoji_events
                                  : Icons.cancel_rounded,
                              size: 32,
                              color: stat.win
                                  ? Colors.amberAccent.shade700
                                  : Colors.blueAccent.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: Colors.white),
                                Icon(
                                  stat.difficulty == Difficulty.intermediate ||
                                          stat.difficulty == Difficulty.hard
                                      ? Icons.star
                                      : Icons.star_outline,
                                  color: Colors.white,
                                ),
                                Icon(
                                  stat.difficulty == Difficulty.hard
                                      ? Icons.star
                                      : Icons.star_outline,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              stat.mapSize == MapSize.fourxfour
                                  ? '4x4'
                                  : stat.mapSize == MapSize.fivexsix
                                      ? '5x6'
                                      : '6x8',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              stat.gameDuration.toMinutesSeconds(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              stat.flips.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

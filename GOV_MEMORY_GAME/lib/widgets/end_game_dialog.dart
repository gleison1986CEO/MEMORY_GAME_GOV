import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:desenvolvimento_sustentavel_governo/models/game_stat.dart';
import 'package:desenvolvimento_sustentavel_governo/utilities/extensions.dart';
import 'package:flutter/material.dart';

class EndGameDialog extends StatelessWidget {
  const EndGameDialog({Key? key, required this.stat}) : super(key: key);

  final GameStat stat;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 375,
        child: Stack(
          children: [
            Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Global.colors.lightIconColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        stat.win
                            ? Icons.emoji_events
                            : Icons.sentiment_dissatisfied,
                        size: 50,
                        color: stat.win ? const Color(0XFFF6D100) : null,
                      ),
                      Text(
                        stat.win ? 'Vencedor!' : 'Tempo Finalizado',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.black45,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tempo',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            stat.gameDuration.toMinutesSeconds(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tentativas',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            stat.flips.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pares',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            stat.correct.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nível',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star),
                              Icon(stat.difficulty != Difficulty.easy
                                  ? Icons.star
                                  : Icons.star_outline),
                              Icon(
                                stat.difficulty == Difficulty.hard
                                    ? Icons.star
                                    : Icons.star_outline,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 25,
              child: GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/', (_) => false),
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    // color: Colors.red,
                    color: Global.colors.lightIconColorDarker,
                  ),
                  child: const Icon(
                    // Icons.cancel_rounded,
                    Icons.home,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 150,
              child: GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/game',
                    ModalRoute.withName(
                        '/newGame') // Replace this with your root screen's route name (usually '/')
                    ),
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.yellow.shade800),
                  child: const Icon(
                    Icons.replay_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

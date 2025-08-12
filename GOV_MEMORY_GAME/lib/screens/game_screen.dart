import 'dart:async';

import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:desenvolvimento_sustentavel_governo/models/game_stat.dart';
import 'package:desenvolvimento_sustentavel_governo/providers/game_stats_provider.dart';
import 'package:desenvolvimento_sustentavel_governo/providers/settings_provider.dart';
import 'package:desenvolvimento_sustentavel_governo/utilities/extensions.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/end_game_dialog.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/quit_game_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late var _rows;
  late var _columns;
  late var _mapSize;
  late var _difficulty;
  late Timer _timer;

  List<bool> _selectedCards = [];
  List<bool> _solvedCards = [];
  List<int> _cardBottoms = [];
  int _flips = 0;
  int _solvedCount = 0;

  int? _heldCardIndex;

  late Duration _timeLeft;

  final DateTime _gameStarted = DateTime.now();

  @override
  void didChangeDependencies() {
    _mapSize = context.read<SettingsProvider>().mapSize;
    _difficulty = context.read<SettingsProvider>().difficulty;

    _rows = _mapSize == MapSize.fourxfour
        ? 4
        : _mapSize == MapSize.fivexsix
            ? 6
            : 8;
    _columns = _mapSize == MapSize.fourxfour
        ? 4
        : _mapSize == MapSize.fivexsix
            ? 5
            : 6;

    _selectedCards = List.filled(_rows * _columns, false);
    _solvedCards = List.filled(_rows * _columns, false);

    int uniqueCardCount = (_columns * _rows / 2).round();

    _cardBottoms = (List.generate(uniqueCardCount, (index) => index) +
        List.generate(uniqueCardCount, (index) => index));

    _cardBottoms.shuffle();

    int seconds = Global.gameTimesInSeconds.times[_mapSize]![_difficulty]!;

    _timeLeft = Duration(seconds: seconds);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _timeLeft = Duration(seconds: _timeLeft.inSeconds - 1);
        });

        if (_timeLeft == Duration.zero) {
          _endGame();
        }
      },
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Column(children: [
              Expanded(
                child: Column(
                  children: List.generate(
                    _rows,
                    (index) => Expanded(
                      child: Row(
                        children: List.generate(
                          _columns,
                          (index2) =>
                              _buildFlipAnimation(_columns * index + index2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          height: 55,
                          child: GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                pageBuilder: (_, __, ___) {
                                  return const QuitGameDialog();
                                },
                                transitionBuilder: (_, anim, __, child) {
                                  Tween<Offset> tween;
                                  if (anim.status == AnimationStatus.reverse) {
                                    tween = Tween(
                                        begin: const Offset(0, -1),
                                        end: Offset.zero);
                                  } else {
                                    tween = Tween(
                                        begin: const Offset(0, 1),
                                        end: Offset.zero);
                                  }

                                  return SlideTransition(
                                    position: tween.animate(anim),
                                    child: FadeTransition(
                                      opacity: anim,
                                      child: child,
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Card(
                              elevation: 4,
                              margin: EdgeInsets.zero,
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Icon(
                                Icons.cancel_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 55,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.amberAccent,
                          ),
                          child: Center(
                            child: Text(
                              _timeLeft.toMinutesSeconds(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          height: 55,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Color(0XFF323031),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _flips.toString() + " Tentativas",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(bool showBottom, int index) {
    String themeName = context.read<SettingsProvider>().gameTheme.name;
    return Padding(
      key: ValueKey(showBottom),
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade700,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: showBottom
              ? FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SvgPicture.asset(
                    'assets/images/$themeName/${_cardBottoms[index]}.svg',
                  ),
                )
              : FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SvgPicture.asset('assets/images/$themeName.svg'),
                ),
        ),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isTop = widget!.key != const ValueKey(false);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isTop ? -1.0 : 1.0;
        final value = isTop ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFlipAnimation(int index) {
    bool showBottomOfCard = _selectedCards[index] || _solvedCards[index];
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();

          if (!_solvedCards[index]) {
            if (_heldCardIndex == index) return;

            // Flip The Card
            setState(() {
              _selectedCards[index] = !_selectedCards[index];
              if (_selectedCards[index]) _flips++;
            });

            if (_heldCardIndex != null) {
              if (_cardBottoms[_heldCardIndex!] == _cardBottoms[index]) {
                _solvedCards[_heldCardIndex!] = true;
                _solvedCards[index] = true;
                _heldCardIndex = null;
                _solvedCount++;

                if (_solvedCount == _rows * _columns / 2) {
                  _endGame();
                }
                return;
              } else {
                Future.delayed(const Duration(milliseconds: 400), () {
                  setState(() {
                    _selectedCards[index] = false;
                    _selectedCards[_heldCardIndex!] = false;
                    _heldCardIndex = null;
                  });
                });
                return;
              }
            }

            _heldCardIndex ??= index;
          }
        },
        child: AnimatedSwitcher(
          layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
          transitionBuilder: _transitionBuilder,
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
          child: _buildCard(showBottomOfCard, index),
        ),
      ),
    );
  }

  void _endGame() {
    _timer.cancel();

    // Win
    bool win = _solvedCount == _rows * _columns / 2;

    // Difficulty
    Difficulty difficulty = _difficulty;

    // Map Size
    MapSize mapSize = _mapSize;

    // Game Started
    DateTime gameStarted = _gameStarted;

    // Game Duration
    Duration gameDuration = Duration(seconds: _timer.tick);

    // Flips
    int flips = _flips;

    // Correct
    int correct = _solvedCount;

    GameStat stat = GameStat(
        win: win,
        difficulty: difficulty,
        mapSize: mapSize,
        gameStarted: gameStarted,
        gameDuration: gameDuration,
        flips: flips,
        correct: correct);

    if (!kIsWeb) {
      context.read<GameStatsProvider>().addStat(stat);
    }

    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return EndGameDialog(stat: stat);
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );

    // Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

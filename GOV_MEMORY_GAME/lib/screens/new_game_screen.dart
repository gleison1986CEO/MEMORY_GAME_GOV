import 'package:desenvolvimento_sustentavel_governo/enums/difficulty.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/gametheme.dart';
import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:desenvolvimento_sustentavel_governo/providers/settings_provider.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/difficulty_card.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/main_button.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/map_card.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/theme_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.blueAccent.shade700,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo/icon.png',
                  width: 330.0,
                  height: 330.0,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MapCard(
                    mapSize: MapSize.fourxfour,
                    selected: context.watch<SettingsProvider>().mapSize ==
                        MapSize.fourxfour,
                    mapCallback: (mapSize) =>
                        context.read<SettingsProvider>().setMapSize(mapSize),
                  ),
                  MapCard(
                    mapSize: MapSize.fivexsix,
                    selected: context.watch<SettingsProvider>().mapSize ==
                        MapSize.fivexsix,
                    mapCallback: (mapSize) =>
                        context.read<SettingsProvider>().setMapSize(mapSize),
                  ),
                  MapCard(
                    mapSize: MapSize.sixxeight,
                    selected: context.watch<SettingsProvider>().mapSize ==
                        MapSize.sixxeight,
                    mapCallback: (mapSize) =>
                        context.read<SettingsProvider>().setMapSize(mapSize),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: 77,
                      height: 77,
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Icon(
                          Icons.cancel_rounded,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MainButton(
                      title: 'Vamos lá',
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/game',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '*Vamos começar, escolha a dificuldade do game, e faça o seu melhor!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Global.colors.lightIconColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

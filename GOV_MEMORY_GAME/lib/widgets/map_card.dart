import 'package:desenvolvimento_sustentavel_governo/enums/mapsize.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef MapCallback = Function(MapSize mapSize);

class MapCard extends StatelessWidget {
  MapCard(
      {Key? key,
      required this.selected,
      required this.mapCallback,
      required this.mapSize})
      : super(key: key);

  final bool selected;
  final MapSize mapSize;
  final MapCallback mapCallback;

  late final _title = mapSize == MapSize.fourxfour
      ? '4x4'
      : mapSize == MapSize.fivexsix
          ? '5x6'
          : '6x8';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: selected ? Colors.blueAccent.shade700 : Colors.transparent,
          ),
          child: Center(
            child: SizedBox(
              width: 92,
              height: 200,
              child: GestureDetector(
                onTap: () {
                  mapCallback(mapSize);
                  HapticFeedback.mediumImpact();
                },
                child: Card(
                  color: Global.colors.lightIconColorDarker,
                  margin: EdgeInsets.zero,
                  child: Image.asset(
                    'assets/images/map_$_title.png',
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: selected,
          child: Text(
            "Cartas " + _title,
            style: const TextStyle(
                fontWeight: FontWeight.w300, fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

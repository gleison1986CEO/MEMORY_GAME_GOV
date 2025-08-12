import 'package:auto_size_text/auto_size_text.dart';
import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:flutter/material.dart';

class QuitGameDialog extends StatelessWidget {
  const QuitGameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 165,
        child: Stack(
          children: [
            Container(
              width: 250,
              height: 135,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Global.colors.lightIconColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: AutoSizeText(
                      'Você quer mesmo sair?',
                      minFontSize: 18,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
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
                      color: Colors.blueAccent.shade700),
                  child: const Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Sim',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 150,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.blueAccent.shade700,
                  ),
                  child: const Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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

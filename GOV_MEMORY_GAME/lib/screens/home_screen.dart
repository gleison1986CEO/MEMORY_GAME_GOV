import 'package:desenvolvimento_sustentavel_governo/global/global.dart';
import 'package:desenvolvimento_sustentavel_governo/widgets/main_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Container(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/logo/logo.png',
                      width: 330.0,
                      height: 330.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MainButton(
                      title: 'Começar Jogo',
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pushNamed(
                          context,
                          '/newGame',
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !kIsWeb,
                    child: MainButton(
                        title: 'Ranking',
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.pushNamed(
                            context,
                            '/stats',
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Objetivo de Desenvolvimento Sustentável.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 88, 88, 88),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            HOUSEOFCODE();
                          },
                          child: Text(
                            'Desenvolvido por HouseOfCode 2025 | LTDA',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 88, 88, 88),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/credits',
                            );
                          },
                          child: Text(
                            'Créditos',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 141, 141, 141),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void HOUSEOFCODE() async {
    final Uri url = Uri.parse('https://houseofcode.pro/');
    if (!await launchUrl(url)) {
      throw Exception('URL INEXISTENTE!');
    }
  }
}

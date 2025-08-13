import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({Key? key}) : super(key: key);

  @override
  _CreditsScreenState createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Desenvolvimento Sustentável Game',
    packageName: 'com.houseofcode.memoria',
    version: '1.0.2025',
    buildNumber: '1.0.2025',
    buildSignature: 'com.houseofcode.memoria',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre o Desenvolvedor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Devenvolvedor'),
            trailing: Text('Gleison Silveira de Freitas'),
          ),
          ListTile(
            title: const Text('Empresa'),
            trailing: const Text('Empresa'),
            onTap: () async {
              final String url = "https://houseofcode.pro";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          ListTile(
            title: const Text('Linkedin'),
            trailing: const Text('Linkedin'),
            onTap: () async {
              final String url =
                  "https://www.linkedin.com/in/gleison-silveira-de-freitas-04385022b/";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          ListTile(
            title: const Text('Whatsapp'),
            trailing: const Text('Whatsapp'),
            onTap: () async {
              final String url =
                  "https://api.whatsapp.com/send/?phone=5521965408033&text=Olá, Gostaria de conversar com a empresa HouseofCode...";
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          ListTile(
            title: Text('Profissional'),
            trailing: Text('Engenheiro de Sistemas, Engenheiro de Jogos.'),
          ),
          ListTile(
            title: const Text('Email'),
            trailing: const Text('devgleisonsilveira@gmail.com'),
            onTap: () async {
              final Uri params = Uri(
                scheme: 'mailto',
                path: 'devgleisonsilveira@gmail.com',
                query: 'subject=App Feedback (${_packageInfo.version})',
              );

              final String url = params.toString();
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
        ],
      ),
    );
  }
}

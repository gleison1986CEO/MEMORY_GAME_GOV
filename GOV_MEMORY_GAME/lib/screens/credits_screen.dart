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
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
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
      appBar: AppBar(title: const Text('Créditos')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Devenvolvedor'),
            trailing: Text('Gleison Silveira de Freitas'),
          ),

          ListTile(
            title: const Text('Versão'),
            trailing: Text('v${_packageInfo.version}'),
          ),
          ListTile(
            title: const Text('Contato'),
            trailing: const Text('devgleisonsilveira@gmail.com'),
            onTap: () async {
              final Uri params = Uri(
                scheme: 'mailto',
                path: 'devgleisonsilveira@gmail.com',
                query:
                    'subject=App Feedback (${_packageInfo.version})', 
              );

              final String url = params.toString();
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          // ListTile(
          //   title: const Text('Repo'),
          //   trailing: const Text('github.com/ChrisStayte/Concentration'),
          //   onTap: () async {
          //     final Uri params = Uri(
          //         scheme: 'https',
          //         path: 'www.github.com/ChrisStayte/Concentration');

          //     final String url = params.toString();
          //     if (await canLaunch(url)) {
          //       await launch(url);
          //     }
          //   },
          // ),
          // ListTile(
          //   title: const Text('View Licenses'),
          //   trailing: const Icon(Icons.description),
          //   onTap: () => showLicensePage(context: context),
          // ),
        ],
      ),
    );
  }
}

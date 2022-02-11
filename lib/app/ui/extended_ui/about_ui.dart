import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

//
class AboutUI extends StatefulWidget {
  const AboutUI({Key? key}) : super(key: key);

  @override
  _AboutUIState createState() => _AboutUIState();
}

class _AboutUIState extends State<AboutUI> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIos = theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS;
    return AboutPage(
      values: {
        'version': _packageInfo.version,
        'buildNumber': _packageInfo.buildNumber,
        'year': DateTime
            .now()
            .year
            .toString(),
        'author': 'D Rykov',
        // 'author': Pubspec.authorsName.join(', '),
      },
      title: const Text('About'),
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationIcon: const FlutterLogo(size: 100),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: const <Widget>[
        MarkdownPageListTile(
          filename: 'md/README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
        ),
        MarkdownPageListTile(
          filename: 'md/CHANGELOG.md',
          title: Text('View Changelog'),
          icon: Icon(Icons.view_list),
        ),
        MarkdownPageListTile(
          filename: 'md/LICENSE.md',
          title: Text('View License'),
          icon: Icon(Icons.description),
        ),
      ],
    );
  }

//   const AboutUI({Key? key}) : super(key: key);
//
//
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isIos = theme.platform == TargetPlatform.iOS ||
//         theme.platform == TargetPlatform.macOS;
//
//     final aboutPage = AboutPage(
//       values: {
//         'version': Pubspec.version,
//         'buildNumber': Pubspec.versionBuild.toString(),
//         'year': DateTime.now().year.toString(),
//         'author': Pubspec.authorsName.join(', '),
//       },
//       title: const Text('About'),
//       applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
//       applicationDescription: const Text(
//         Pubspec.description,
//         textAlign: TextAlign.justify,
//       ),
//       applicationIcon: const FlutterLogo(size: 100),
//       applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
//       children: const <Widget>[
//         MarkdownPageListTile(
//           filename: 'README.md',
//           title: Text('View Readme'),
//           icon: Icon(Icons.all_inclusive),
//         ),
//         MarkdownPageListTile(
//           filename: 'CHANGELOG.md',
//           title: Text('View Changelog'),
//           icon: Icon(Icons.view_list),
//         ),
//         MarkdownPageListTile(
//           filename: 'LICENSE.md',
//           title: Text('View License'),
//           icon: Icon(Icons.description),
//         ),
//         MarkdownPageListTile(
//           filename: 'CONTRIBUTING.md',
//           title: Text('Contributing'),
//           icon: Icon(Icons.share),
//         ),
//         MarkdownPageListTile(
//           filename: 'CODE_OF_CONDUCT.md',
//           title: Text('Code of conduct'),
//           icon: Icon(Icons.sentiment_satisfied),
//         ),
//         LicensesPageListTile(
//           title: Text('Open source Licenses'),
//           icon: Icon(Icons.favorite),
//         ),
//       ],
//     );
//
//     if (isIos) {
//       return CupertinoApp(
//         title: 'About Demo (Cupertino)',
//         home: aboutPage,
//         theme: CupertinoThemeData(
//           brightness: theme.brightness,
//         ),
//       );
//     }
//
//     // return MaterialApp(
//     //   title: 'About Demo (Material)',
//     //   home: aboutPage,
//     //   theme: ThemeData(),
//     //   darkTheme: ThemeData(brightness: Brightness.dark),
//     // );
//   }
}

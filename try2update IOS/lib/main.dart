import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'Common/Global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Routes/LoginPage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();



  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
        brightness: Brightness.light,
        barBackgroundColor: CupertinoColors.systemGroupedBackground,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,),

      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'zh'),
        const Locale.fromSubtags(languageCode: 'en'),
      ],
      home:LoginPage(),
      locale: Locale('zh'),
    );
  }
}


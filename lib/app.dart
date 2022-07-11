import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskoo/src/screen/main/main_page.dart';
import 'package:taskoo/src/screen/setting/setting_page.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const MainPage(),
        '/setting':(context) => const SettingPage(),
      },
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}

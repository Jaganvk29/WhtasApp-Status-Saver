import 'package:flutter/material.dart';

import './screens/Permission.dart';
import './screens/Home.dart';
import 'package:provider/provider.dart';
import './Providers/VideoProvider.dart';


void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => VideoStatus())
  ],


      child:   MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home:Home()
    );
  }
}

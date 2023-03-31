import 'package:flutter/material.dart';
import 'package:purplepay_task/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PurplePay Task',
      home: Home(),
    );
  }
}

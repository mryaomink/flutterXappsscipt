import 'package:flutter/material.dart';

import 'screens/yao_lirik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STB App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const YaoLirik(),
    );
  }
}

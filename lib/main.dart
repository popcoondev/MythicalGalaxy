import 'package:flutter/material.dart';
import 'title_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mythical Galaxy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TitleScreen(),
    );
  }
}

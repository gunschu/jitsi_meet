import 'package:flutter/material.dart';
import 'package:jitsi_meet_example/home.dart';
import 'package:jitsi_meet_example/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ExampleTheme.exampleTheme,
      home: Home(),
    );
  }
}

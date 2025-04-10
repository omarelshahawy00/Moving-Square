import 'package:flutter/material.dart';
import 'package:flutter_task/red_square_animation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RedSquareAnimation(),
    );
  }
}

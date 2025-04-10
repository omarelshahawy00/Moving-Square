import 'package:flutter/material.dart';
import 'square_button.dart';

class RedSquareAnimation extends StatefulWidget {
  const RedSquareAnimation({super.key});

  @override
  State<RedSquareAnimation> createState() => _RedSquareAnimationState();
}

class _RedSquareAnimationState extends State<RedSquareAnimation> {
  Alignment _alignment = Alignment.center;
  bool _isAnimating = false;

  Future<void> _moveSquare(Alignment newAlignment) async {
    setState(() {
      _alignment = newAlignment;
      _isAnimating = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Square Animation'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedAlign(
            alignment: _alignment,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareButton(
                label: 'Move to Left',
                onPressed: () => _moveSquare(Alignment.centerLeft),
                disabled: _isAnimating || _alignment == Alignment.centerLeft,
              ),
              const SizedBox(width: 20),
              SquareButton(
                label: 'Move to Right',
                onPressed: () => _moveSquare(Alignment.centerRight),
                disabled: _isAnimating || _alignment == Alignment.centerRight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

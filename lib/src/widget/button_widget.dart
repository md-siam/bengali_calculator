import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final butttonTapped;

  const MyButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    this.butttonTapped,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isElevated = true;
  AudioCache audioCache = AudioCache(prefix: 'assets/audio/');
  bool _isPlaying = false;
  final Color _color = Colors.grey[300]!;

  void _pressedDown(PointerEvent details) async {
    await audioCache.play(
      'office_calculator_single_press_002.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  void _pressedUp(PointerEvent details) {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.butttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Listener(
          onPointerDown: _pressedDown,
          onPointerUp: _pressedUp,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isElevated
                  ? [
                      BoxShadow(
                        color: Colors.grey[500]!,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        // spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

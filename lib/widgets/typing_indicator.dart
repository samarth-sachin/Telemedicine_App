import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF2196F3).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF2196F3).withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'TeleMedi is typing',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 20,
              height: 20,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDot(0),
                      _buildDot(0.33),
                      _buildDot(0.66),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(double delay) {
    return Opacity(
      opacity: (_controller.value + delay) % 1.0 > 0.5 ? 1.0 : 0.3,
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Color(0xFF2196F3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

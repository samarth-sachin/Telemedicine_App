import 'package:flutter/material.dart';

class SymptomChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SymptomChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  static const Color primaryColor = Color(0xFF2E7C9A);   // logo dark
  static const Color secondaryColor = Color(0xFF6FBFCC); // logo light

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(
          label,
          style: const TextStyle(
            fontFamily: 'K2D',
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: secondaryColor.withOpacity(0.18),
        side: BorderSide(
          color: secondaryColor.withOpacity(0.6),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onTap,
        elevation: 0,
        pressElevation: 1.5,
      ),
    );
  }
}

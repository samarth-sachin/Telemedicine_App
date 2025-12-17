import 'package:flutter/material.dart';

class SymptomChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SymptomChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(
          label,
          style: TextStyle(
            color: Color(0xFF2196F3),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xFF2196F3).withOpacity(0.1),
        side: BorderSide(
          color: Color(0xFF2196F3).withOpacity(0.3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onTap,
        elevation: 0,
        pressElevation: 2,
      ),
    );
  }
}

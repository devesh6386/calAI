import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MacroChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;

  const MacroChip({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.hankenGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

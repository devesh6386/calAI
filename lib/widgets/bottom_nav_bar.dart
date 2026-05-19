import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_outlined, 'iconFilled': Icons.home, 'label': 'Home'},
      {'icon': Icons.menu_book_outlined, 'iconFilled': Icons.menu_book, 'label': 'Log'},
      {'icon': Icons.photo_camera_outlined, 'iconFilled': Icons.photo_camera, 'label': 'Scan'},
      {'icon': Icons.insights_outlined, 'iconFilled': Icons.insights, 'label': 'Trends'},
      {'icon': Icons.person_outline, 'iconFilled': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.92),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isActive = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: isActive
                      ? BoxDecoration(
                          color: AppTheme.primaryContainer.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive
                            ? items[i]['iconFilled'] as IconData
                            : items[i]['icon'] as IconData,
                        color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.6),
                        size: 24,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        items[i]['label'] as String,
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

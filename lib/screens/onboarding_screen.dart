import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // Glassmorphic top app bar
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppTheme.surface.withOpacity(0.85),
            elevation: 0,
            shadowColor: Colors.black.withOpacity(0.08),
            toolbarHeight: 64,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VitalAI',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                    letterSpacing: -0.5,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      color: AppTheme.onSurfaceVariant,
                      onPressed: () {},
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.surfaceContainer,
                      backgroundImage: const NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBG4NEsjPkkHm1mSnmnndvxnPmQmW4HH5LMZlkVVVlvzFkuCHvAzfoSSZfI3LxVKTA3j3r33w12z9vAezeaQD458XgD4hzvQPcdVsKLSMixk_7AEflSiS3tcGTYWcKc_Pcr4oFZIlqDVF6iKTkmOeWTI98UCaYuz_w_5ZKr6KtLSCWAJCYiT7nK1GMosrBMviaj1ycSs9KRPp21xr-yRzX7_Af4ffCpL4q1sj1zW6ndFEX96CvWDPvYfoUBWAiIN_zwyH33CHA0fli5',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero section
                  Text(
                    'Track meals\nwith AI',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Snap your food and get instant calories, macros, and daily progress.',
                    style: GoogleFonts.hankenGrotesk(
                      fontSize: 16,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/goal-setup'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryContainer,
                            foregroundColor: const Color(0xFF004b1e),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.hankenGrotesk(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.outline),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            'Watch Demo',
                            style: GoogleFonts.hankenGrotesk(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.onSurface),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Scanner image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 5,
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBHuhPfYQBG2QF4j8iybt7zUsVUFlE9CKjwV4UKRKbyUepjdm8MOKvubJ17T1RMtEOLZvRUbAVr53LgE7id-zVQ0C9b0QOFfwRYiH8ipSAhkTNjSxhmrd48hsyhLgxTPH-92CcKx1nC2k2mR_mM3WugN9GQfImfEboGqPxHGMkOk9k1UZ3OlqleaUhNA625TQ9Irgza8qef_Df30ewU4FCVpIpn6vpA4pb4VgTCQz2qUmxLHJgkL2CvsGwWRjWDg7Y0h_mCxwQQyghT',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Scan overlay corners
                        Positioned.fill(
                          child: CustomPaint(painter: _ScanCornerPainter()),
                        ),
                        // AI badge top right
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppTheme.tertiary, AppTheme.tertiaryContainer],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: [BoxShadow(color: AppTheme.tertiary.withOpacity(0.4), blurRadius: 12)],
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                          ),
                        ),
                        // Floating info card
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(0.4)),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40, height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryContainer.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Icon(Icons.restaurant, color: AppTheme.primary, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Salmon Bowl', style: GoogleFonts.hankenGrotesk(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.onSurface)),
                                      Text('450 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                _chip('32g P', AppTheme.primary, AppTheme.primaryContainer.withOpacity(0.1)),
                                const SizedBox(width: 4),
                                _chip('12g F', AppTheme.tertiary, AppTheme.tertiaryContainer.withOpacity(0.1)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Features grid
                  Column(
                    children: [
                      _featureCard(Icons.photo_camera_outlined, 'Snap & Scan', 'No manual entry. AI recognizes thousands of dishes instantly.', AppTheme.primary),
                      const SizedBox(height: 12),
                      _featureCard(Icons.insights_outlined, 'Deep Insights', 'Track micronutrients and get personalized feedback.', AppTheme.tertiary),
                      const SizedBox(height: 12),
                      _featureCard(Icons.bolt_outlined, 'Instant Results', 'Macro breakdowns in under 2 seconds with 98% accuracy.', AppTheme.secondary),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Trust badges
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _trustBadge(Icons.verified_user, 'HIPAA'),
                        _trustBadge(Icons.groups_outlined, '1M+ Users'),
                        _trustBadge(Icons.star_outlined, '4.9 ★'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (i == 1) Navigator.pushReplacementNamed(context, '/diary');
          if (i == 2) Navigator.pushReplacementNamed(context, '/food-scan');
          if (i == 3) Navigator.pushReplacementNamed(context, '/analytics');
        },
      ),
    );
  }

  Widget _chip(String label, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w500, color: color)),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trustBadge(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.onSurfaceVariant.withOpacity(0.6), size: 20),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant.withOpacity(0.6))),
      ],
    );
  }
}

class _ScanCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF22c55e)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const len = 32.0;
    const r = 12.0;
    // TL
    canvas.drawLine(Offset(40, 40 + len), Offset(40, 40 + r), paint);
    canvas.drawArc(Rect.fromLTWH(40, 40, r * 2, r * 2), 3.14159, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(40 + r, 40), Offset(40 + r + len, 40), paint);
    // TR
    canvas.drawLine(Offset(size.width - 40 - len, 40), Offset(size.width - 40 - r, 40), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 40 - r * 2, 40, r * 2, r * 2), 3 * 3.14159 / 2, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(size.width - 40, 40 + r), Offset(size.width - 40, 40 + r + len), paint);
    // BL
    canvas.drawLine(Offset(40, size.height - 40 - len), Offset(40, size.height - 40 - r), paint);
    canvas.drawArc(Rect.fromLTWH(40, size.height - 40 - r * 2, r * 2, r * 2), 3.14159 / 2, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(40 + r, size.height - 40), Offset(40 + r + len, size.height - 40), paint);
    // BR
    canvas.drawLine(Offset(size.width - 40, size.height - 40 - len), Offset(size.width - 40, size.height - 40 - r), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 40 - r * 2, size.height - 40 - r * 2, r * 2, r * 2), 0, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(size.width - 40 - r, size.height - 40), Offset(size.width - 40 - r - len, size.height - 40), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

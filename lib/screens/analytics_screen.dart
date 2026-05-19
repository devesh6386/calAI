import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _navIndex = 3;

  final List<Map<String, dynamic>> _bars = [
    {'day': 'M', 'h': 0.65, 'active': false},
    {'day': 'T', 'h': 0.85, 'active': true},
    {'day': 'W', 'h': 0.45, 'active': false},
    {'day': 'T', 'h': 0.72, 'active': false},
    {'day': 'F', 'h': 0.55, 'active': true},
    {'day': 'S', 'h': 0.28, 'active': false},
    {'day': 'S', 'h': 0.35, 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.surface.withOpacity(0.9),
            elevation: 0,
            toolbarHeight: 64,
            automaticallyImplyLeading: false,
            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                CircleAvatar(radius: 20, backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBkI9zHAPrTmwyuHqoeXdL1wmWDbE8lxsYo-Q9g1NOvw7l2tzpZCEVK5aII05qJZfMDnNgvNUYS7gWlfJ63SmwStNTywE9B_SAZjXE1j2cE4mNiCCTsw8-sfS_RTQzS53jThAPKPlZmdOYc1UyH8GnSMKToxSmlmuCOwU156gpc8uxV1hxNTnzeaa5oVXW4ROU1xutRkbqo-b4M6G6IoT-2_Je5AypIaCC2xPVXWjQSVBHIYGxxi4oHzNHUd6HeVhh-4Uk9Wc3ggsxb')),
                const SizedBox(width: 10),
                Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary)),
              ]),
              IconButton(icon: const Icon(Icons.notifications_outlined, size: 26), color: AppTheme.onSurfaceVariant, onPressed: () {}),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            sliver: SliverList(delegate: SliverChildListDelegate([
              Text('Weekly Insights', style: GoogleFonts.hankenGrotesk(fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
              Text('Your metabolic trends for Sep 12 – Sep 18', style: GoogleFonts.hankenGrotesk(fontSize: 14, color: AppTheme.onSurfaceVariant)),
              const SizedBox(height: 20),

              // Stat cards row
              Row(children: [
                Expanded(child: _statCard(Icons.restaurant, 'Daily Avg', '1,842', '↓ 12% vs LW', AppTheme.primary)),
                const SizedBox(width: 12),
                Expanded(child: _statCard(Icons.local_fire_department, 'Best Streak', '14 Days', 'Personal Record', AppTheme.secondary, iconFilled: true)),
              ]),
              const SizedBox(height: 16),

              // Calorie bar chart
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Calorie Consumption', style: GoogleFonts.hankenGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                    Text('Goal: 2,000', style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                  ]),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _bars.map((bar) {
                        final isActive = bar['active'] as bool;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOut,
                                height: 140 * (bar['h'] as double),
                                decoration: BoxDecoration(
                                  color: isActive ? AppTheme.primaryContainer : const Color(0xFFDCE9FF),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(999)),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(bar['day'] as String, style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: isActive ? FontWeight.w700 : FontWeight.w400, color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant)),
                            ]),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 16),

              // Macro trends line chart
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Macro Balance', style: GoogleFonts.hankenGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                  const SizedBox(height: 12),
                  Row(children: [
                    _legend('Protein', AppTheme.primaryContainer),
                    const SizedBox(width: 16),
                    _legend('Carbs', AppTheme.secondaryContainer),
                    const SizedBox(width: 16),
                    _legend('Fats', AppTheme.tertiaryContainer),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: CustomPaint(
                      size: const Size(double.infinity, 140),
                      painter: _LineChartPainter(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    'Mon', 'Wed', 'Fri', 'Sun'
                  ].map((d) => Text(d, style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant.withOpacity(0.5)))).toList()),
                ]),
              ),
              const SizedBox(height: 16),

              // AI insight card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withOpacity(0.06),
                  border: Border.all(color: AppTheme.tertiaryContainer.withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppTheme.tertiary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.lightbulb, color: AppTheme.tertiary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('AI Nutritionist', style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.tertiary)),
                    const SizedBox(height: 4),
                    Text("You've hit your protein target 6 days in a row! Increasing your protein intake on Wednesdays slightly improved your energy levels by 15% according to your log.", style: GoogleFonts.hankenGrotesk(fontSize: 14, color: AppTheme.onSurface, height: 1.5)),
                  ])),
                ]),
              ),
            ])),
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
          if (i == 4) Navigator.pushReplacementNamed(context, '/streak-badges');
        },
      ),
    );
  }

  Widget _statCard(IconData icon, String label, String value, String sub, Color color, {bool iconFilled = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
        ]),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.hankenGrotesk(fontSize: 24, fontWeight: FontWeight.w700, color: color, letterSpacing: -0.5)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(999)),
          child: Text(sub, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w500, color: color)),
        ),
      ]),
    );
  }

  Widget _legend(String label, Color color) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999))),
      const SizedBox(width: 5),
      Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
    ]);
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    void drawLine(List<Offset> pts, Color color) {
      final paint = Paint()..color = color..strokeWidth = 2.5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
      final path = Path()..moveTo(pts[0].dx * size.width, pts[0].dy * size.height);
      for (int i = 1; i < pts.length; i++) {
        final cp1 = Offset((pts[i - 1].dx + pts[i].dx) / 2 * size.width, pts[i - 1].dy * size.height);
        final cp2 = Offset((pts[i - 1].dx + pts[i].dx) / 2 * size.width, pts[i].dy * size.height);
        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx * size.width, pts[i].dy * size.height);
      }
      canvas.drawPath(path, paint);
    }

    drawLine([const Offset(0, 0.55), const Offset(0.25, 0.25), const Offset(0.5, 0.18), const Offset(0.75, 0.45), const Offset(1, 0.25)], const Color(0xFF22c55e));
    drawLine([const Offset(0, 0.68), const Offset(0.25, 0.78), const Offset(0.5, 0.58), const Offset(0.75, 0.72), const Offset(1, 0.62)], const Color(0xFFfd761a));
    drawLine([const Offset(0, 0.88), const Offset(0.25, 0.93), const Offset(0.5, 0.82), const Offset(0.75, 0.90), const Offset(1, 0.78)], const Color(0xFFb89cff));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

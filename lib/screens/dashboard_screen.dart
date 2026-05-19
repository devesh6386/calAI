import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_ring.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: AppTheme.surface.withOpacity(0.9),
            elevation: 0,
            toolbarHeight: 64,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppTheme.surfaceContainer,
                      backgroundImage: const NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDZX9THhjwDg5x_QSKoQZncpQTuSwrVhr2qScYJCgKzaYvJPMasshmlue-pEcN0nhDDq4GXgqXS6eXdjryZnFgmMnfknHnEUK_OKNvAD_WoYtkydnvBCz4GkSawGT4Gp9-z9xRymrVQUENtTIsLNtNxBFkMscyl6ecxKXo0swkzv86wieg70JOqg6a7FpSdZBQhYJsChMPq40kqAcjMZHXEVyg_B2fonlb95djUb2ExGPHbvSGfZTmb597hfMoI0FWwfKfkoePZcU0V',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary, letterSpacing: -0.5)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: AppTheme.primary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Calorie ring card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                    border: Border.all(color: AppTheme.surfaceContainer),
                  ),
                  child: Column(
                    children: [
                      ProgressRing(
                        progress: 1420 / 2200,
                        size: 200,
                        strokeWidth: 12,
                        trackColor: AppTheme.primary.withOpacity(0.1),
                        progressColor: AppTheme.primaryContainer,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('1,420', style: GoogleFonts.hankenGrotesk(fontSize: 36, fontWeight: FontWeight.w800, color: AppTheme.onSurface, letterSpacing: -1)),
                            Text('/ 2,200 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _macroRing('Protein', 0.75, AppTheme.primary, AppTheme.primary.withOpacity(0.1), '75%'),
                          _macroRing('Carbs', 0.50, AppTheme.secondaryContainer, AppTheme.secondary.withOpacity(0.1), '50%'),
                          _macroRing('Fat', 0.30, AppTheme.tertiaryContainer, AppTheme.tertiary.withOpacity(0.1), '30%'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Streak card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6d3bd7), Color(0xFF23005c)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Container(
                          width: 96, height: 96,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(999)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Current Streak', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text('12 Days 🔥', style: GoogleFonts.hankenGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
                            child: Text('Keep it up!', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Today's Meals
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Meals", style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/diary'),
                      child: Text('View All', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _mealCard(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC5piz2kNydbap1At8gOSL15Tqy0gLm1Svk8sLPlK_LjemSObG-qlTKke6uiF68Pi98oiyPmOWDPoxNDjGP98DMy8udF8CL_mPyH4us0FS1nhtb3CNeIpxGnawqYFob9aHmahtAqpGQuRnQ8clrLP2-kdB1iZSqsP6_zNJksPN_mHMkC8Ro4Vj00vH4QjGJHQ_Hnlt1dVbH-3-SECVkCOWP_7K1IoREuvCOhHxJJht8FVMxWI5nCxBy41GN3qRBFrXQ1PpWQV5fBOLT',
                  'Avocado Toast & Egg',
                  'Breakfast • 8:30 AM',
                  '420 kcal',
                ),
                const SizedBox(height: 10),
                _mealCard(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCzVwxN1jBQcAu2vRBn9K08xjAwYpaVt-cmz_te6Pln5Cg5AnvJpqy7wPzdoBtbQEPa6KX1GeYkDJewYuMOeg_HzansQ_Zq7UEoKg3yQCv68HkhW5iuFv1WXQIeWj1qnyd5EaCGgrtK-YWgJXhL7EvP4VLsYu-he0AMec7p7wnxhQLPP0_mOizWjns2ZEOL85HYlIXAewpAWRIjm9lnVJDRRvn4XqSmrv8F7IYgcq4ZKv33s1WvovCajykZMnl1MX1QdpxIRjQOQziV',
                  'Quinoa Chicken Salad',
                  'Lunch • 1:15 PM',
                  '680 kcal',
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/food-scan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.tertiary, AppTheme.tertiaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(999),
            boxShadow: [BoxShadow(color: AppTheme.tertiary.withOpacity(0.4), blurRadius: 12)],
          ),
          child: const Icon(Icons.photo_camera, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 1) Navigator.pushReplacementNamed(context, '/diary');
          if (i == 2) Navigator.pushReplacementNamed(context, '/food-scan');
          if (i == 3) Navigator.pushReplacementNamed(context, '/analytics');
          if (i == 4) Navigator.pushReplacementNamed(context, '/streak-badges');
        },
      ),
    );
  }

  Widget _macroRing(String label, double progress, Color color, Color trackColor, String centerText) {
    return Column(
      children: [
        ProgressRing(
          progress: progress,
          size: 64,
          strokeWidth: 6,
          trackColor: trackColor,
          progressColor: color,
          child: Text(centerText, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
        ),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
      ],
    );
  }

  Widget _mealCard(String imageUrl, String name, String subtitle, String kcal) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        border: Border.all(color: AppTheme.surfaceContainer),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(imageUrl, width: 48, height: 48, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                Text(subtitle, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(kcal, style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
              const Icon(Icons.chevron_right, color: Color(0xFF3d4a3d), size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

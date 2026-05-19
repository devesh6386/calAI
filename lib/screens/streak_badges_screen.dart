import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class StreakBadgesScreen extends StatefulWidget {
  const StreakBadgesScreen({super.key});

  @override
  State<StreakBadgesScreen> createState() => _StreakBadgesScreenState();
}

class _StreakBadgesScreenState extends State<StreakBadgesScreen> {
  int _navIndex = 4;

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
                CircleAvatar(radius: 20, backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCLp3L814mC2N3z5P1f4Q9OaXJtA4B75wGZ3P1bZ5a4T3L9L6xWq2tJ0jVp1w_G8_3j9LwW9A5Vj4k2Y2X5F3K3vT1qZ5o1O4_vLz9P7yQ8uV0_8tC6o_yY1qY3h4Z_4wH2wKxXz7bV1Hj1_3y5yY3t0_XgD5vT5P3zY9V8nB7y_P8t9Z0zV1zX_gR4_')),
                const SizedBox(width: 10),
                Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary)),
              ]),
              IconButton(icon: const Icon(Icons.share_outlined, size: 26), color: AppTheme.onSurfaceVariant, onPressed: () {}),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // Top hero card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6d3bd7), Color(0xFF23005c)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFF6d3bd7).withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Current Streak', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.8))),
                    const SizedBox(height: 4),
                    Text('14 Days', style: GoogleFonts.hankenGrotesk(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -1)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                      child: Text('Top 5% of users 🔥', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ])),
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white.withOpacity(0.3), width: 2)),
                    child: const Center(child: Text('🔥', style: TextStyle(fontSize: 36))),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              // Activity graph
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Activity', style: GoogleFonts.hankenGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
                    Text('Oct', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                  ]),
                  const SizedBox(height: 16),
                  _buildActivityGrid(),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Less', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                    Row(children: [
                      _heatSquare(AppTheme.surfaceContainer.withOpacity(0.6)),
                      const SizedBox(width: 4),
                      _heatSquare(AppTheme.primary.withOpacity(0.3)),
                      const SizedBox(width: 4),
                      _heatSquare(AppTheme.primary.withOpacity(0.6)),
                      const SizedBox(width: 4),
                      _heatSquare(AppTheme.primary),
                    ]),
                    Text('More', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                  ]),
                ]),
              ),
              const SizedBox(height: 24),
              Text('Achievements', style: GoogleFonts.hankenGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
              const SizedBox(height: 16),
              // Badges Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.85,
                children: [
                  _badgeCard('Early Bird', 'Logged breakfast before 8AM for 7 days', true, '🌅'),
                  _badgeCard('Protein King', 'Hit protein goal 10 days in a row', true, '🥩'),
                  _badgeCard('Perfect Week', 'Hit all goals for 7 consecutive days', false, '👑'),
                  _badgeCard('Marathoner', 'Track 30 days without breaking streak', false, '🏃‍♂️'),
                ],
              ),
              const SizedBox(height: 24),
              // Leaderboard Teaser
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppTheme.primaryContainer, const Color(0xFFc0e7d5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
                    child: Icon(Icons.leaderboard_outlined, color: AppTheme.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Join the Leaderboard', style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF004b1e))),
                    const SizedBox(height: 4),
                    Text('Compete with friends and stay accountable.', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: const Color(0xFF004b1e).withOpacity(0.8))),
                  ])),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: AppTheme.primary),
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
          if (i == 3) Navigator.pushReplacementNamed(context, '/analytics');
        },
      ),
    );
  }

  Widget _buildActivityGrid() {
    final values = [
      0, 1, 2, 3, 1, 0, 0,
      1, 2, 3, 3, 2, 1, 0,
      2, 3, 3, 3, 3, 2, 1,
      3, 3, 3, 3, 3, 0, 0,
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: values.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final val = values[index];
        Color color = AppTheme.surfaceContainer.withOpacity(0.6);
        if (val == 1) color = AppTheme.primary.withOpacity(0.3);
        if (val == 2) color = AppTheme.primary.withOpacity(0.6);
        if (val == 3) color = AppTheme.primary;
        return _heatSquare(color);
      },
    );
  }

  Widget _heatSquare(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _badgeCard(String title, String desc, bool unlocked, String emoji) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : AppTheme.surfaceContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: unlocked ? AppTheme.primary.withOpacity(0.3) : Colors.transparent),
        boxShadow: unlocked ? [BoxShadow(color: AppTheme.primary.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))] : [],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              gradient: unlocked
                  ? LinearGradient(colors: [const Color(0xFFffecb3), const Color(0xFFffcf33)], begin: Alignment.topLeft, end: Alignment.bottomRight)
                  : LinearGradient(colors: [AppTheme.surfaceContainer, const Color(0xFFd1d1d1)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
          ),
          if (!unlocked)
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(999)),
              child: const Icon(Icons.lock, color: Colors.black54, size: 24),
            ),
        ]),
        const SizedBox(height: 12),
        Text(title, style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: unlocked ? AppTheme.onSurface : AppTheme.onSurfaceVariant), textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(desc, style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant.withOpacity(unlocked ? 1.0 : 0.6)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}

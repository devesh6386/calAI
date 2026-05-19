import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_ring.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int _navIndex = 1;

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
                CircleAvatar(radius: 16, backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCpkF_x7k91Z1L0fRmf8Q83sfsq3VfU93GUkMjVqyJ9k79geBbDRsocQvJJH_E0IP-aU-Mzv_7710y1Fwt50EM8KRSb5rivh9hoJFEZarFuiuBEepOgGC0xZq8tDXjIrvzwIWw5kxxC7IIBYa7nUJBSAG6deZ3xlE27hCv9TWqI2MpIETD6yU-pENppewzbq4iidhOvKz18vzgDT-6skZmLi9ECD-IdHC-YxIStPpVn1F7I3RYo04_HcoI_UWgk6uod62G7Fsqi7-Eg')),
                const SizedBox(width: 10),
                Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary)),
              ]),
              IconButton(icon: const Icon(Icons.notifications_outlined), color: AppTheme.onSurfaceVariant, onPressed: () {}),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // Daily summary card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.15)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)],
                ),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Daily Summary', style: GoogleFonts.hankenGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                      Text('Wednesday, Oct 24', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
                    ]),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('1,420', style: GoogleFonts.hankenGrotesk(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.primary, letterSpacing: -1)),
                      Text('KCAL LEFT', style: GoogleFonts.hankenGrotesk(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant, letterSpacing: 1)),
                    ]),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    ProgressRing(
                      progress: 780 / 2200,
                      size: 100,
                      strokeWidth: 8,
                      trackColor: AppTheme.primary.withOpacity(0.1),
                      progressColor: AppTheme.primary,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text('780', style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
                        Text('eaten', style: GoogleFonts.hankenGrotesk(fontSize: 10, color: AppTheme.onSurfaceVariant)),
                      ]),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: Column(children: [
                      _macroBar('Protein', '45/120g', 0.375, AppTheme.secondaryContainer),
                      const SizedBox(height: 8),
                      _macroBar('Carbs', '82/250g', 0.328, AppTheme.tertiaryContainer),
                      const SizedBox(height: 8),
                      _macroBar('Fat', '22/70g', 0.314, AppTheme.outline),
                    ])),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              // Breakfast
              _mealSection('Breakfast', Icons.light_mode, '320 kcal', [
                {'name': 'Greek Yogurt & Berries', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBIDNi2PvJCa4LfwxF9pofG-J-EzeYj-CI3oACJmKe3ynGGwKxDUwbosPL0JAI49jslV-dvhPdik7JiABMsJSaq08Iw8t15rCRmQjq0lPMwWQS0VvQQ390KiZeJWEUfWmXBa3bLtWtx8OcHzNlv1nM9nV_bDVdkhh5FkGI2G9Gmy7YOotiUsuMiYpjkueP1Pz7t-23mXA_oMo9H3Ecefvjlbuy5vlVIdGoa5gjvM1hz6x-YDUxP085g1NNmdd3EJZURJhrBev2MM7uo', 'p': '18g P', 'c': '24g C'},
              ]),
              const SizedBox(height: 16),
              // Lunch
              _mealSection('Lunch', Icons.wb_sunny, '460 kcal', [
                {'name': 'Grilled Chicken Quinoa', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCNdd5m1RcrHU4NVLpkX8BPatGZZSFGr6WPX0PR2bdqJaRmPG5bSS2aq5mHJDba0AQKQM85CczGRccBxzvjUldRqByXk_ygX7krWSA0JGhGJM8d3WdA8Xtg3isd3j7BjiZEiKTaBvNje1ciJerFZozzLHVdEN56XyRF5RKhFZ6eLOZx20ACyH2deas1r9mMhWvYDhrSm9c2zFGExTHQ6lGxR-1-71icvW_Vnlt3yJLDhEOY2I4aNTcOm9JZnW9fW6FxKPfoandTyUNF', 'p': '32g P', 'c': '48g C'},
              ]),
              const SizedBox(height: 16),
              // Dinner (empty)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Icon(Icons.nights_stay, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 6),
                    Text('Dinner', style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
                  ]),
                  Text('0 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
                ]),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.4), width: 2, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(children: [
                      Icon(Icons.restaurant, color: AppTheme.onSurfaceVariant.withOpacity(0.5), size: 30),
                      const SizedBox(height: 6),
                      Text('No entries yet', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant.withOpacity(0.6))),
                      Text('Add Dinner', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                    ]),
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              // Snacks
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Icon(Icons.cookie, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 6),
                    Text('Snacks', style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
                  ]),
                  Text('0 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
                ]),
                const SizedBox(height: 8),
                _addButton('Add Meal'),
              ]),
            ])),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppTheme.tertiary, AppTheme.tertiaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(999),
            boxShadow: [BoxShadow(color: AppTheme.tertiary.withOpacity(0.4), blurRadius: 12)],
          ),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          if (i == 2) Navigator.pushReplacementNamed(context, '/food-scan');
          if (i == 3) Navigator.pushReplacementNamed(context, '/analytics');
          if (i == 4) Navigator.pushReplacementNamed(context, '/streak-badges');
        },
      ),
    );
  }

  Widget _macroBar(String name, String label, double pct, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(name, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
        Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
      ]),
      const SizedBox(height: 4),
      ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(value: pct, minHeight: 6, backgroundColor: AppTheme.surfaceContainer, valueColor: AlwaysStoppedAnimation<Color>(color)),
      ),
    ]);
  }

  Widget _mealSection(String title, IconData icon, String kcal, List<Map<String, String>> foods) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(width: 6),
          Text(title, style: GoogleFonts.hankenGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
        ]),
        Text(kcal, style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
      ]),
      const SizedBox(height: 8),
      ...foods.map((food) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.1)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(food['img']!, width: 40, height: 40, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(food['name']!, style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
              const SizedBox(height: 4),
              Row(children: [
                _pill(food['p']!, AppTheme.secondaryContainer),
                const SizedBox(width: 6),
                _pill(food['c']!, AppTheme.tertiaryContainer),
              ]),
            ])),
            Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant.withOpacity(0.4), size: 18),
          ]),
        ),
      )),
      _addButton('Add Meal'),
    ]);
  }

  Widget _pill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w500, color: color)),
    );
  }

  Widget _addButton(String label) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/food-scan'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.35), width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.add_circle_outline, color: AppTheme.primary, size: 20),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primary)),
        ]),
      ),
    );
  }
}

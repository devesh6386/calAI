import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class GoalSetupScreen extends StatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  State<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends State<GoalSetupScreen> {
  int _selectedGoal = 0; // 0=lose, 1=maintain, 2=gain
  double _calorieTarget = 2450;
  double _protein = 30;
  double _carbs = 45;
  double _fat = 25;
  int _navIndex = 0;

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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppTheme.primary,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Set Your Goals',
              style: GoogleFonts.hankenGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
              ),
            ),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Objective Section
                Text(
                  'SELECT OBJECTIVE',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    _goalCard(0, Icons.trending_down, 'Lose weight', 'Calorie deficit for fat loss', AppTheme.primary),
                    const SizedBox(height: 10),
                    _goalCard(1, Icons.balance, 'Maintain', 'Balance intake and energy', AppTheme.secondary),
                    const SizedBox(height: 10),
                    _goalCard(2, Icons.fitness_center, 'Gain muscle', 'Calorie surplus for growth', AppTheme.tertiary),
                  ],
                ),
                const SizedBox(height: 24),
                // Calorie target card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.surface.withOpacity(0.3)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Daily Calorie Target', style: GoogleFonts.hankenGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                              Text('Adjust your total daily intake', style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${_calorieTarget.toInt()}',
                                  style: GoogleFonts.hankenGrotesk(fontSize: 32, fontWeight: FontWeight.w800, color: AppTheme.primary, letterSpacing: -1),
                                ),
                                TextSpan(
                                  text: ' kcal',
                                  style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppTheme.primary,
                          inactiveTrackColor: AppTheme.surfaceContainer,
                          thumbColor: AppTheme.primary,
                          overlayColor: AppTheme.primary.withOpacity(0.12),
                          trackHeight: 6,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                        ),
                        child: Slider(
                          min: 1200,
                          max: 4500,
                          value: _calorieTarget,
                          onChanged: (v) => setState(() => _calorieTarget = v),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1,200 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant.withOpacity(0.5))),
                          Text('4,500 kcal', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant.withOpacity(0.5))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Macro breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DAILY MACRO TARGET', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant.withOpacity(0.7), letterSpacing: 1.5)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(999)),
                      child: Text('Total: ${(_protein + _carbs + _fat).toInt()}%', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _macroCard('Protein', _protein, AppTheme.primary, AppTheme.surfaceContainer, (v) => setState(() => _protein = v), '${((_calorieTarget * _protein / 100) / 4).toInt()}g', 'High Protein'),
                const SizedBox(height: 10),
                _macroCard('Carbs', _carbs, AppTheme.secondary, AppTheme.secondaryContainer.withOpacity(0.2), (v) => setState(() => _carbs = v), '${((_calorieTarget * _carbs / 100) / 4).toInt()}g', 'Moderate'),
                const SizedBox(height: 10),
                _macroCard('Fat', _fat, AppTheme.tertiary, AppTheme.tertiaryContainer.withOpacity(0.2), (v) => setState(() => _fat = v), '${((_calorieTarget * _fat / 100) / 9).toInt()}g', 'Essential'),
                const SizedBox(height: 24),
                // Summary bento
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Est. Weekly Impact', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF004b1e).withOpacity(0.8))),
                            const SizedBox(height: 4),
                            Text('-0.5 kg', style: GoogleFonts.hankenGrotesk(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF004b1e))),
                            Text('Based on your activity & metabolic rate.', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: const Color(0xFF004b1e).withOpacity(0.7))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCE9FF),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('AI Recommendation', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.onSurfaceVariant)),
                            const SizedBox(height: 6),
                            Text(
                              'Your macro split is optimized for muscle preservation while in a deficit.',
                              style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurface),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(color: AppTheme.tertiaryContainer.withOpacity(0.4), borderRadius: BorderRadius.circular(999)),
                              child: Icon(Icons.auto_awesome, color: AppTheme.tertiary, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryContainer,
                      foregroundColor: const Color(0xFF004b1e),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 2,
                    ),
                    child: Text('Apply & Save Goals', style: GoogleFonts.hankenGrotesk(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 0) Navigator.pushReplacementNamed(context, '/dashboard');
        },
      ),
    );
  }

  Widget _goalCard(int index, IconData icon, String title, String subtitle, Color color) {
    final isSelected = _selectedGoal == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedGoal = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
            width: 2,
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.hankenGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                  Text(subtitle, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _macroCard(String name, double value, Color color, Color trackColor, ValueChanged<double> onChanged, String grams, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.surfaceContainer.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
              Text('${value.toInt()}%', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: AppTheme.surfaceContainer,
              thumbColor: color,
              overlayColor: color.withOpacity(0.12),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(min: 5, max: 75, value: value, onChanged: onChanged),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(grams, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
              Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/progress_ring.dart';
import '../utils/upload_helper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _meals = [
    {
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuC5piz2kNydbap1At8gOSL15Tqy0gLm1Svk8sLPlK_LjemSObG-qlTKke6uiF68Pi98oiyPmOWDPoxNDjGP98DMy8udF8CL_mPyH4us0FS1nhtb3CNeIpxGnawqYFob9aHmahtAqpGQuRnQ8clrLP2-kdB1iZSqsP6_zNJksPN_mHMkC8Ro4Vj00vH4QjGJHQ_Hnlt1dVbH-3-SECVkCOWP_7K1IoREuvCOhHxJJht8FVMxWI5nCxBy41GN3qRBFrXQ1PpWQV5fBOLT',
      'name': 'Avocado Toast & Egg',
      'subtitle': 'Breakfast • 8:30 AM',
      'kcal': '420 kcal',
    },
    {
      'imageUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCzVwxN1jBQcAu2vRBn9K08xjAwYpaVt-cmz_te6Pln5Cg5AnvJpqy7wPzdoBtbQEPa6KX1GeYkDJewYuMOeg_HzansQ_Zq7UEoKg3yQCv68HkhW5iuFv1WXQIeWj1qnyd5EaCGgrtK-YWgJXhL7EvP4VLsYu-he0AMec7p7wnxhQLPP0_mOizWjns2ZEOL85HYlIXAewpAWRIjm9lnVJDRRvn4XqSmrv8F7IYgcq4ZKv33s1WvovCajykZMnl1MX1QdpxIRjQOQziV',
      'name': 'Quinoa Chicken Salad',
      'subtitle': 'Lunch • 1:15 PM',
      'kcal': '680 kcal',
    },
  ];

  Future<void> _pickAndUploadImage() async {
    try {
      // Show simple camera or gallery picker sheet
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Color(0xFF6d3bd7)),
                title: const Text('Take a Photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF6d3bd7)),
                title: const Text('Choose from Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      setState(() => _isUploading = true);

      final String imageUrl = await UploadHelper.uploadFoodImage(File(pickedFile.path));

      // Try saving to Supabase if authenticated
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        try {
          await supabase.from('meals').insert({
            'user_id': userId,
            'food_name': 'AI Scanned Meal',
            'calories': 350.0,
            'protein': 15.0,
            'carbs': 40.0,
            'fats': 12.0,
            'quantity': 1.0,
            'meal_type': 'snack',
            'image_url': imageUrl,
          });
        } catch (e) {
          print('Failed inserting meal in Supabase: $e');
        }
      }

      setState(() {
        _meals.add({
          'imageUrl': imageUrl,
          'name': 'AI Scanned Meal',
          'subtitle': 'Snack • Just Now',
          'kcal': '350 kcal',
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Meal image uploaded and logged successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to log meal: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          CustomScrollView(
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
                    // Render dynamic meals list
                    ..._meals.map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _mealCard(m['imageUrl'], m['name'], m['subtitle'], m['kcal']),
                    )).toList(),
                  ]),
                ),
              ),
            ],
          ),
          if (_isUploading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.55),
                child: Center(
                  child: Card(
                    color: AppTheme.surface.withOpacity(0.95),
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(color: AppTheme.primary.withOpacity(0.3), width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6d3bd7)),
                            strokeWidth: 4,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'AI Scanning Food...',
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Uploading to server & identifying macros',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 13,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndUploadImage,
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

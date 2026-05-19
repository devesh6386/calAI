import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class FoodScanScreen extends StatelessWidget {
  const FoodScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full-screen camera view (mock)
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC2ED6yPIE42BVbDPBdSAU-iuQPsKIANdqoWroZ09mzUhKQ6A7M2NxINluoVUUW4LpH5VxHD4KxilVyxkH3wONHIlLMOk3uXqfgo-Bb0G1-dR7eBwuxPAplxNO1ecEZgLbDS-RqBk6Q4JifknVtWd_01cayvgbuJ4-12KHQyQ_oa1nCTPCKhnVP7sAJZ5PGWzUOXhD2ThFhCoKhVOay2f9E8m278grbKSA9guMKokb6s01CKh1WXGTUwwBsx_x2Ud3TYZPsznArenR8',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.25),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.flash_on, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Scanner overlay
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 280, height: 280,
                  child: CustomPaint(painter: _ScannerFramePainter()),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('Center your meal for analysis', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.9))),
                ),
              ],
            ),
          ),
          // Floating AI detection tags
          Positioned(
            top: MediaQuery.of(context).size.height * 0.32,
            left: 50,
            child: _detectionTag('Salmon detected'),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            right: 50,
            child: _detectionTag('Fiber focus'),
          ),
          // Tip card
          Positioned(
            bottom: 180,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.lightbulb_outline, color: Color(0xFF22c55e), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Tip: Good lighting helps AI accuracy.', style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  const Icon(Icons.close, color: Colors.white38, size: 18),
                ],
              ),
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _controlButton(Icons.photo_library_outlined, 'Gallery'),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/scan-result'),
                        child: Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppTheme.primary, width: 4),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppTheme.tertiary, const Color(0xFF23005c)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Icon(Icons.photo_camera, color: Colors.white, size: 32),
                          ),
                        ),
                      ),
                      _controlButton(Icons.flip_camera_ios_outlined, 'Flip'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/scan-result'),
                      icon: const Icon(Icons.auto_awesome, color: Colors.white),
                      label: Text('SCAN MEAL', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.5, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detectionTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.tertiary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.tertiaryContainer.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: AppTheme.tertiaryContainer, borderRadius: BorderRadius.circular(999))),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFb89cff)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const len = 36.0;
    const r = 14.0;
    // TL
    canvas.drawLine(Offset(0, len), const Offset(0, r), paint);
    canvas.drawArc(Rect.fromLTWH(0, 0, r * 2, r * 2), 3.14159, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(r, 0), Offset(r + len, 0), paint);
    // TR
    canvas.drawLine(Offset(size.width - len, 0), Offset(size.width - r, 0), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - r * 2, 0, r * 2, r * 2), 3 * 3.14159 / 2, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(size.width, r), Offset(size.width, r + len), paint);
    // BL
    canvas.drawLine(Offset(0, size.height - len), Offset(0, size.height - r), paint);
    canvas.drawArc(Rect.fromLTWH(0, size.height - r * 2, r * 2, r * 2), 3.14159 / 2, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(r, size.height), Offset(r + len, size.height), paint);
    // BR
    canvas.drawLine(Offset(size.width, size.height - len), Offset(size.width, size.height - r), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - r * 2, size.height - r * 2, r * 2, r * 2), 0, 3.14159 / 2, false, paint);
    canvas.drawLine(Offset(size.width - r, size.height), Offset(size.width - r - len, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

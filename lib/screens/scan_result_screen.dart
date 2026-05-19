import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/macro_chip.dart';

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Grilled Chicken', 'desc': 'Lean breast meat, roasted', 'kcal': 165, 'p': '31g', 'c': '0g', 'f': '3.6g', 'g': 100},
      {'name': 'Brown Rice', 'desc': 'Whole grain, steamed', 'kcal': 111, 'p': '2.6g', 'c': '23g', 'f': '0.9g', 'g': 150},
      {'name': 'Broccoli', 'desc': 'Steamed fresh', 'kcal': 35, 'p': '2.8g', 'c': '7g', 'f': '0.4g', 'g': 80},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), color: AppTheme.onSurfaceVariant, onPressed: () => Navigator.pop(context)),
        title: Text('VitalAI', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.primary)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 220),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network('https://lh3.googleusercontent.com/aida-public/AB6AXuCLfWWd9cRQyjfY2YwSap486XPSHfia9kYbwt-IFSr5lmkA0IaXjJxwsk1uLL5kvd-NtjCIF03zwtAz-UBUdV7Omabcv4Ctyn5fy1wlrFgiUITiag6W2gSBcthu6ufrS_74OTMD_FNCv120s55muoQLlH9uHChheeJmZN0wSA2e5yyVArKlF7j_Q7UN8aUIKbEr--Xz5E8WCW2jx_RtmPwRKbFl-LhElZ2u1XgMr0JVeMOfoo0rVbJg2TbPCUoV80MjyQysFs3kC5za', fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(999)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.auto_awesome, color: Colors.white, size: 13),
                        const SizedBox(width: 5),
                        Text('AI Analysis Complete', style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                      ]),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              Text('Detected Items', style: GoogleFonts.hankenGrotesk(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.onSurface)),
              Text('Review and adjust quantities for accuracy.', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
              const SizedBox(height: 16),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFBCCBB9).withOpacity(0.3)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item['name'] as String, style: GoogleFonts.hankenGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.onSurface)),
                        Text(item['desc'] as String, style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                      ]),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('${item['kcal']}', style: GoogleFonts.hankenGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                        Text('kcal', style: GoogleFonts.hankenGrotesk(fontSize: 11, color: AppTheme.onSurfaceVariant)),
                      ]),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      MacroChip(label: 'P: ${item['p']}', color: AppTheme.primary, backgroundColor: AppTheme.primaryContainer.withOpacity(0.2)),
                      const SizedBox(width: 6),
                      MacroChip(label: 'C: ${item['c']}', color: AppTheme.secondary, backgroundColor: AppTheme.secondaryContainer.withOpacity(0.2)),
                      const SizedBox(width: 6),
                      MacroChip(label: 'F: ${item['f']}', color: AppTheme.tertiary, backgroundColor: AppTheme.tertiaryContainer.withOpacity(0.2)),
                    ]),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFBCCBB9)),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Serving Size', style: GoogleFonts.hankenGrotesk(fontSize: 13, color: AppTheme.onSurfaceVariant)),
                      Row(children: [
                        Container(
                          width: 60, height: 38,
                          decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(12)),
                          child: Center(child: Text('${item['g']}', style: GoogleFonts.hankenGrotesk(fontSize: 14, fontWeight: FontWeight.w600))),
                        ),
                        const SizedBox(width: 6),
                        Text('g', style: GoogleFonts.hankenGrotesk(fontSize: 14, color: AppTheme.onSurfaceVariant)),
                      ]),
                    ]),
                  ]),
                ),
              )),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppTheme.tertiary, AppTheme.tertiaryContainer], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  const Icon(Icons.flare, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('AI Suggestion', style: GoogleFonts.hankenGrotesk(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.9))),
                    Text('"Adding 10g of olive oil would increase healthy fats by 9g."', style: GoogleFonts.hankenGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ])),
                ]),
              ),
            ],
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              decoration: BoxDecoration(
                color: AppTheme.surface.withOpacity(0.96),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -4))],
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Total Energy', style: GoogleFonts.hankenGrotesk(fontSize: 12, color: AppTheme.onSurfaceVariant)),
                    RichText(text: TextSpan(children: [
                      TextSpan(text: '311 ', style: GoogleFonts.hankenGrotesk(fontSize: 34, fontWeight: FontWeight.w800, color: AppTheme.primary, letterSpacing: -1)),
                      TextSpan(text: 'kcal', style: GoogleFonts.hankenGrotesk(fontSize: 17, fontWeight: FontWeight.w600, color: AppTheme.primary)),
                    ])),
                  ]),
                  Row(children: [
                    _ring('36g', 'PRO', AppTheme.primaryContainer),
                    const SizedBox(width: 8),
                    _ring('30g', 'CARB', AppTheme.secondaryContainer),
                    const SizedBox(width: 8),
                    _ring('5g', 'FAT', AppTheme.tertiaryContainer),
                  ]),
                ]),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/diary'),
                    icon: const Icon(Icons.add_task, color: Colors.white),
                    label: Text('Add to Diary', style: GoogleFonts.hankenGrotesk(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ring(String value, String label, Color color) {
    return Column(children: [
      Container(
        width: 48, height: 48,
        decoration: BoxDecoration(border: Border.all(color: color, width: 3), borderRadius: BorderRadius.circular(999)),
        child: Center(child: Text(value, style: GoogleFonts.hankenGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.onSurface))),
      ),
      const SizedBox(height: 3),
      Text(label, style: GoogleFonts.hankenGrotesk(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.onSurfaceVariant, letterSpacing: 0.5)),
    ]);
  }
}

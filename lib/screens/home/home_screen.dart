import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/section_title.dart';
import '../crops/crop_list_screen.dart';
import '../pest/pest_screen.dart';
import '../fertilizer/fertilizer_screen.dart';
import '../community/community_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AppTopBar(title: 'AgroGuide BD'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: AppTheme.green),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('আসসালামু আলাইকুম, কৃষক ভাই!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                              SizedBox(height: 4),
                              Text('টাঙ্গাইলের জন্য আজকের কৃষি পরামর্শ প্রস্তুত।', style: TextStyle(color: AppTheme.muted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SectionTitle(title: 'আজকের আবহাওয়া'),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.paleGreen,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFDDEEE0)),
                    ),
                    child: const Row(
                      children: [
                        Text('☁️', style: TextStyle(fontSize: 38)),
                        SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('32°C', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                            Text('আংশিক মেঘলা • টাঙ্গাইল'),
                          ],
                        ),
                        Spacer(),
                        Text('বিস্তারিত ›', style: TextStyle(color: AppTheme.green, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SectionTitle(title: 'আপনার জন্য পরামর্শ'),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.35,
                    children: [
                      _FeatureCard(icon: '🌾', title: 'ফসল পরামর্শ', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CropListScreen()))),
                      _FeatureCard(icon: '🧪', title: 'সার পরামর্শ', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FertilizerScreen()))),
                      _FeatureCard(icon: '🐛', title: 'রোগ ও পোকা', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PestScreen()))),
                      _FeatureCard(icon: '👨‍🌾', title: 'কমিউনিটি', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityScreen()))),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const SectionTitle(title: 'জনপ্রিয় ফসল', action: 'সব দেখুন'),
                  ...crops.take(3).map((crop) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppTheme.lightGreen,
                        child: Text(crop.icon, style: const TextStyle(fontSize: 22)),
                      ),
                      title: Text(crop.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(crop.season),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CropListScreen(initialCrop: crop))),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _FeatureCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8E3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 7),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

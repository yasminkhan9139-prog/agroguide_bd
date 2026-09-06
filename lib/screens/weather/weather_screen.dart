import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/section_title.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AppTopBar(title: 'আবহাওয়া'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('টাঙ্গাইল', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text('32°C', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800)),
                            SizedBox(width: 18),
                            Text('☁️', style: TextStyle(fontSize: 42)),
                          ],
                        ),
                        Text('আংশিক মেঘলা • কৃষিকাজের জন্য মোটামুটি ভালো'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SectionTitle(title: 'দৈনিক পূর্বাভাস'),
                  ...weatherDays.map((day) => Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Text(day.icon, style: const TextStyle(fontSize: 28)),
                      title: Text(day.day, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(day.condition),
                      trailing: Text(day.temp, style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  )),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5E8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: AppTheme.orange),
                        SizedBox(width: 10),
                        Expanded(child: Text('সতর্কতা: বৃষ্টির সম্ভাবনা থাকায় সেচ ও সার প্রয়োগের সময় স্থানীয় আবহাওয়া দেখে নিন।')),
                      ],
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
}

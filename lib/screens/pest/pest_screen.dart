import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class PestScreen extends StatelessWidget {
  const PestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diseases = [
      ('পাতা পোড়া রোগ', 'ধানের পাতায় বাদামি/কালো দাগ দেখা দিতে পারে।', '🌿'),
      ('স্টেম বোরার', 'কাণ্ডে আক্রমণ করে গাছ দুর্বল করতে পারে।', '🐛'),
      ('ফল ছিদ্রকারী পোকা', 'টমেটো ও অন্যান্য সবজিতে আক্রমণ করতে পারে।', '🍅'),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'রোগ ও পোকা', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.camera_alt_outlined, size: 42, color: AppTheme.green),
                        const SizedBox(height: 8),
                        const Text('আক্রান্ত ফসলের ছবি দিন', style: TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 5),
                        const Text('ডেমো সংস্করণে নিচের রোগের তথ্য দেখানো হচ্ছে।'),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image picker demo.'))),
                          icon: const Icon(Icons.upload_outlined),
                          label: const Text('ছবি আপলোড'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...diseases.map((d) => Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Text(d.$3, style: const TextStyle(fontSize: 28)),
                      title: Text(d.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                      subtitle: Text(d.$2),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

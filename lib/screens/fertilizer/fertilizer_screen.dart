import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class FertilizerScreen extends StatefulWidget {
  const FertilizerScreen({super.key});

  @override
  State<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends State<FertilizerScreen> {
  String crop = 'ধান';
  String soil = 'দোআঁশ মাটি';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'সার পরামর্শ', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ফসল ও মাটির তথ্য দিন', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: crop,
                      decoration: const InputDecoration(labelText: 'ফসল'),
                      items: ['ধান', 'গম', 'টমেটো', 'আলু'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
                      onChanged: (v) => setState(() => crop = v!),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: soil,
                      decoration: const InputDecoration(labelText: 'মাটির ধরন'),
                      items: ['দোআঁশ মাটি', 'এঁটেল মাটি', 'বেলে মাটি'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
                      onChanged: (v) => setState(() => soil = v!),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (_) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('প্রস্তাবিত সার', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                              SizedBox(height: 12),
                              Text('ইউরিয়া: ২০ কেজি/বিঘা'),
                              Text('টিএসপি: ১০ কেজি/বিঘা'),
                              Text('এমওপি: ১০ কেজি/বিঘা'),
                              SizedBox(height: 8),
                              Text('নোট: এটি ডেমো recommendation; বাস্তবে মাটি পরীক্ষা ও বিশেষজ্ঞ পরামর্শ অনুসরণ করুন।', style: TextStyle(color: AppTheme.muted)),
                            ],
                          ),
                        ),
                      ),
                      child: const Text('সার পরামর্শ দেখুন'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

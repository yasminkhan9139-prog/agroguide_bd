import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final comments = TextEditingController();
  String category = 'পরামর্শ';

  @override
  void dispose() {
    comments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'ফিডব্যাক / রিপোর্ট', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('আপনার মতামত আমাদের জানান', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 14),
                    TextField(
                      maxLines: 5,
                      controller: comments,
                      decoration: const InputDecoration(hintText: 'আপনার মতামত লিখুন...'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(labelText: 'ক্যাটাগরি'),
                      items: ['পরামর্শ', 'সমস্যা রিপোর্ট', 'ভুল তথ্য', 'অন্যান্য']
                          .map((x) => DropdownMenuItem(value: x, child: Text(x)))
                          .toList(),
                      onChanged: (v) => setState(() => category = v!),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (comments.text.trim().isEmpty) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ফিডব্যাক সফলভাবে জমা হয়েছে।')),
                        );
                        comments.clear();
                      },
                      child: const Text('ফিডব্যাক জমা দিন'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'আপনার রিপোর্ট কমিউনিটি নিরাপত্তা ও অ্যাপ উন্নয়নে ব্যবহার করা হবে।',
                      style: TextStyle(color: AppTheme.muted),
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

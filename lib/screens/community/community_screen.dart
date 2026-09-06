import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final postController = TextEditingController();
  final posts = <String>[
    'আমার ধানের পাতায় দাগ দেখা যাচ্ছে। কী করা উচিত?',
    'এবার টমেটোর ফলন বেশ ভালো হয়েছে। সবাইকে শুভেচ্ছা!',
  ];

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  void addPost() {
    final text = postController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      posts.insert(0, text);
      postController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'কমিউনিটি', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: postController,
                      decoration: const InputDecoration(hintText: 'আপনার অভিজ্ঞতা বা প্রশ্ন লিখুন'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: addPost,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: posts.length,
                itemBuilder: (_, i) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(radius: 18, child: Icon(Icons.person, size: 19)),
                            SizedBox(width: 9),
                            Text('কৃষক সদস্য', style: TextStyle(fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(posts[i], style: const TextStyle(fontSize: 15)),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.favorite_border, size: 19, color: AppTheme.muted),
                            SizedBox(width: 5),
                            Text('লাইক'),
                            SizedBox(width: 20),
                            Icon(Icons.comment_outlined, size: 19, color: AppTheme.muted),
                            SizedBox(width: 5),
                            Text('মন্তব্য'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

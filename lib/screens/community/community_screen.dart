import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController postController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final List<String> posts = [
    'আমার ধানের পাতায় দাগ দেখা যাচ্ছে। কী করা উচিত?',
    'এবার টমেটোর ফলন বেশ ভালো হয়েছে। সবাইকে শুভেচ্ছা!',
  ];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    postController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void addPost() {
    final text = postController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('দয়া করে আপনার পোস্ট লিখুন।'),
        ),
      );
      return;
    }

    setState(() {
      posts.insert(0, text);
      postController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('আপনার পোস্ট সফলভাবে যোগ হয়েছে।'),
      ),
    );
  }

  void deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('পোস্টটি মুছে ফেলা হয়েছে।'),
      ),
    );
  }

  List<String> get filteredPosts {
    if (searchQuery.isEmpty) {
      return posts;
    }

    return posts
        .where(
          (post) => post.toLowerCase().contains(searchQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayedPosts = filteredPosts;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(
              title: 'কমিউনিটি',
              showBack: true,
            ),

            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'পোস্ট বা প্রশ্ন খুঁজুন',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
            ),

            // Add post
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: postController,
                      maxLines: 3,
                      minLines: 1,
                      decoration: const InputDecoration(
                        hintText: 'আপনার অভিজ্ঞতা বা প্রশ্ন লিখুন',
                        prefixIcon: Icon(Icons.edit_outlined),
                      ),
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

            const Divider(height: 1),

            // Posts
            Expanded(
              child: displayedPosts.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.forum_outlined,
                            size: 52,
                            color: AppTheme.muted,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'কোনো পোস্ট পাওয়া যায়নি',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.muted,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: displayedPosts.length,
                      itemBuilder: (_, i) {
                        final post = displayedPosts[i];
                        final originalIndex = posts.indexOf(post);

                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 18,
                                      child: Icon(
                                        Icons.person,
                                        size: 19,
                                      ),
                                    ),
                                    const SizedBox(width: 9),
                                    const Expanded(
                                      child: Text(
                                        'কৃষক সদস্য',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          deletePost(originalIndex);
                                        }
                                      },
                                      itemBuilder: (_) => const [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Text('পোস্ট মুছুন'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  post,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'পোস্টে লাইক দেওয়া হয়েছে।',
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        size: 19,
                                        color: AppTheme.muted,
                                      ),
                                      label: const Text('লাইক'),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'মন্তব্য ফিচারটি শীঘ্রই আসছে।',
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.comment_outlined,
                                        size: 19,
                                        color: AppTheme.muted,
                                      ),
                                      label: const Text('মন্তব্য'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


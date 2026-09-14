import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class HelplineScreen extends StatefulWidget {
  const HelplineScreen({super.key});

  @override
  State<HelplineScreen> createState() => _HelplineScreenState();
}

class _HelplineScreenState extends State<HelplineScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'সব';

  final List<String> categories = [
    'সব',
    'কৃষি',
    'জরুরি',
  ];

  final List<HelplineContact> contacts = [
    HelplineContact(
      title: 'কৃষি কল সেন্টার',
      number: '16123',
      category: 'কৃষি',
      icon: Icons.agriculture,
      description: 'কৃষি বিষয়ক পরামর্শ ও সহায়তা',
    ),
    HelplineContact(
      title: 'স্থানীয় কৃষি অফিস',
      number: '০৯২১-xxxxxxx',
      category: 'কৃষি',
      icon: Icons.location_city,
      description: 'স্থানীয় কৃষি কর্মকর্তার সহায়তা',
    ),
    HelplineContact(
      title: 'জরুরি সহায়তা',
      number: '999',
      category: 'জরুরি',
      icon: Icons.emergency,
      description: 'জরুরি প্রয়োজনে যোগাযোগ করুন',
      emergency: true,
    ),
  ];

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
    searchController.dispose();
    super.dispose();
  }

  List<HelplineContact> get filteredContacts {
    return contacts.where((contact) {
      final matchesSearch =
          searchQuery.isEmpty ||
          contact.title.toLowerCase().contains(searchQuery) ||
          contact.number.toLowerCase().contains(searchQuery) ||
          contact.description.toLowerCase().contains(searchQuery);

      final matchesCategory =
          selectedCategory == 'সব' ||
          contact.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void showCallDialog(HelplineContact contact) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contact.title),
          content: Text(
            '${contact.number} নম্বরে কল করতে চান?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('বাতিল'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${contact.title} নম্বরে কল করার ডেমো।',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.call),
              label: const Text('কল করুন'),
            ),
          ],
        );
      },
    );
  }

  void copyNumber(HelplineContact contact) {
    Clipboard.setData(
      ClipboardData(text: contact.number),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${contact.number} কপি করা হয়েছে।',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredContacts;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(
              title: 'কৃষি হেল্পলাইন',
              showBack: true,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'হেল্পলাইন খুঁজুন',
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  children: categories.map((category) {
                    final selected =
                        selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_disabled_outlined,
                            size: 50,
                            color: AppTheme.muted,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'কোনো হেল্পলাইন পাওয়া যায়নি',
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
                      itemCount: filtered.length,
                      itemBuilder: (_, index) {
                        final contact = filtered[index];

                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: contact.emergency
                                        ? Colors.red.shade50
                                        : AppTheme.lightGreen,
                                    child: Icon(
                                      contact.icon,
                                      color: contact.emergency
                                          ? Colors.red
                                          : AppTheme.green,
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          contact.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      if (contact.emergency)
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade50,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'জরুরি',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contact.number,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(contact.description),
                                      ],
                                    ),
                                  ),
                                ),

                                const Divider(),

                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () =>
                                            copyNumber(contact),
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 18,
                                        ),
                                        label: const Text('নম্বর কপি'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () =>
                                            showCallDialog(contact),
                                        icon: const Icon(
                                          Icons.call,
                                          size: 18,
                                        ),
                                        label: const Text('কল করুন'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              contact.emergency
                                                  ? Colors.red
                                                  : AppTheme.green,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
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

class HelplineContact {
  final String title;
  final String number;
  final String category;
  final IconData icon;
  final String description;
  final bool emergency;

  const HelplineContact({
    required this.title,
    required this.number,
    required this.category,
    required this.icon,
    required this.description,
    this.emergency = false,
  });
}


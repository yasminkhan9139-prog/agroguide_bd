import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class HelplineScreen extends StatelessWidget {
  const HelplineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      ('কৃষি কল সেন্টার', '16123', Icons.agriculture),
      ('স্থানীয় কৃষি অফিস', '০৯২১-xxxxxxx', Icons.location_city),
      ('জরুরি সহায়তা', '999', Icons.emergency),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'কৃষি হেল্পলাইন', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: contacts.map((c) => Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.lightGreen,
                      child: Icon(c.$3, color: AppTheme.green),
                    ),
                    title: Text(c.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text(c.$2),
                    trailing: IconButton(
                      icon: const Icon(Icons.call, color: AppTheme.green),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${c.$1} নম্বরে কল করার ডেমো।')),
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

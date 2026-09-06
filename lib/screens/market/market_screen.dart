import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/section_title.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AppTopBar(title: 'Market Prices'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'ফসল বা বাজার খুঁজুন',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 7,
                      children: [
                        Chip(label: Text('সব')),
                        Chip(label: Text('ধান')),
                        Chip(label: Text('সবজি')),
                        Chip(label: Text('গম')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SectionTitle(title: 'Popular Crop Today'),
                  ...marketItems.map((item) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 9),
                    child: ListTile(
                      title: Text(item.crop, style: const TextStyle(fontWeight: FontWeight.w800)),
                      subtitle: Text('${item.market} • ${item.unit}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item.price, style: const TextStyle(fontWeight: FontWeight.w800)),
                          Text(
                            item.rising ? '↑ বাড়ছে' : '↓ কমছে',
                            style: TextStyle(color: item.rising ? AppTheme.green : Colors.red, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: AppTheme.green),
                        SizedBox(width: 10),
                        Expanded(child: Text('বর্তমান ট্রেন্ড অনুযায়ী ধান বিক্রির আগে স্থানীয় বাজারের দাম তুলনা করুন।')),
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

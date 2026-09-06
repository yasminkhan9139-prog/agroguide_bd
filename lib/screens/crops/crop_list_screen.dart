import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';

class CropListScreen extends StatelessWidget {
  final CropItem? initialCrop;

  const CropListScreen({super.key, this.initialCrop});

  @override
  Widget build(BuildContext context) {
    if (initialCrop != null) {
      return _CropDetail(crop: initialCrop!);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'ফসলের তথ্য', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'ফসলের নাম বাংলায় খুঁজুন',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (_) {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: crops.length,
                itemBuilder: (_, i) {
                  final crop = crops[i];
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: AppTheme.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(crop.icon, style: const TextStyle(fontSize: 28))),
                      ),
                      title: Text(crop.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: Text(crop.season),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _CropDetail(crop: crop))),
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

class _CropDetail extends StatelessWidget {
  final CropItem crop;

  const _CropDetail({required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(title: crop.name, showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: AppTheme.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(crop.icon, style: const TextStyle(fontSize: 80))),
                    ),
                    const SizedBox(height: 16),
                    Text(crop.season, style: const TextStyle(color: AppTheme.green, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(crop.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                    const SizedBox(height: 18),
                    const Text('ধাপে ধাপে নির্দেশনা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    ...crop.tips.asMap().entries.map((entry) => Card(
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.green,
                          foregroundColor: Colors.white,
                          child: Text('${entry.key + 1}'),
                        ),
                        title: Text(entry.value),
                      ),
                    )),
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

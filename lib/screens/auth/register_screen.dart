import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final village = TextEditingController();
  final password = TextEditingController();
  String farmingType = 'ধান চাষ';

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    village.dispose();
    password.dispose();
    super.dispose();
  }

  void register() {
    if ([name.text, phone.text, village.text, password.text].any((x) => x.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('সব তথ্য পূরণ করুন।')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('রেজিস্ট্রেশন সফল'),
        content: const Text('ডেমো হিসেবে OTP verification সম্পন্ন হয়েছে। এখন লগইন করতে পারবেন।'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('অ্যাকাউন্ট তৈরি করুন'),
        backgroundColor: AppTheme.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.person_add_alt_1, size: 60, color: AppTheme.green),
            const SizedBox(height: 10),
            const Text('কৃষকের তথ্য দিন', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            TextField(controller: name, decoration: const InputDecoration(labelText: 'নাম')),
            const SizedBox(height: 12),
            TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'ফোন নম্বর')),
            const SizedBox(height: 12),
            TextField(controller: village, decoration: const InputDecoration(labelText: 'গ্রাম / লোকেশন')),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: farmingType,
              decoration: const InputDecoration(labelText: 'চাষের ধরন'),
              items: const ['ধান চাষ', 'সবজি চাষ', 'গম চাষ', 'মিশ্র চাষ']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => farmingType = v!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'পাসওয়ার্ড'),
            ),
            const SizedBox(height: 22),
            ElevatedButton(onPressed: register, child: const Text('অ্যাকাউন্ট তৈরি করুন')),
          ],
        ),
      ),
    );
  }
}

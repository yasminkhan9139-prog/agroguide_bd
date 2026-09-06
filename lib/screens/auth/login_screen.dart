import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (phoneController.text.trim().isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ফোন নম্বর/ইউজারনেম এবং পাসওয়ার্ড দিন।')),
      );
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                  child: Icon(Icons.eco, size: 44, color: AppTheme.green),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'AgroGuide BD',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.green),
              ),
              const Text(
                'কৃষকের স্মার্ট সহকারী',
                style: TextStyle(color: AppTheme.orange, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 36),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('কৃষক লগইন / Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'ইউজারনেম / ফোন নম্বর',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'পাসওয়ার্ড',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('পাসওয়ার্ড রিকভারি ডেমো।')),
                    );
                  },
                  child: const Text('পাসওয়ার্ড ভুলে গেছেন?'),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: login,
                child: const Text('লগইন করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('নতুন অ্যাকাউন্ট তৈরি করুন'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

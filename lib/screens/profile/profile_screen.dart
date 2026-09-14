import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_top_bar.dart';
import '../feedback/feedback_screen.dart';
import '../helpline/helpline_screen.dart';
import '../expert/expert_question_screen.dart';
import '../../data/user_session.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const AppTopBar(title: 'প্রোফাইল'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGreen,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 34, color: AppTheme.green),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(UserSession.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
Text(UserSession.location),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _Item(icon: Icons.edit_outlined, title: 'প্রোফাইল আপডেট', onTap: () => _showMessage(context, 'প্রোফাইল এডিট ডেমো।')),
                _Item(icon: Icons.help_outline, title: 'বিশেষজ্ঞকে প্রশ্ন করুন', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpertQuestionScreen()))),
                _Item(icon: Icons.phone_in_talk_outlined, title: 'কৃষি হেল্পলাইন', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelplineScreen()))),
                _Item(icon: Icons.feedback_outlined, title: 'ফিডব্যাক / রিপোর্ট', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen()))),
                _Item(icon: Icons.lock_outline, title: 'পাসওয়ার্ড পরিবর্তন', onTap: () => _showMessage(context, 'পাসওয়ার্ড পরিবর্তন ডেমো।')),
                _Item(icon: Icons.logout, title: 'লগআউট', onTap: () => Navigator.pushReplacementNamed(context, '/login')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _Item({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

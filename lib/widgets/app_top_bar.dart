import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppTopBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onNotification;

  const AppTopBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      color: AppTheme.green,
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: onNotification ?? () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
